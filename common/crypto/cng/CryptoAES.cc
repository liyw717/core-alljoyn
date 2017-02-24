/**
 * @file CryptoAES.cc
 *
 * Class for AES block encryption/decryption this wraps the Windows CNG APIs
 */

/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
 *    
 *    SPDX-License-Identifier: Apache-2.0
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *    
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *    
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *    
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
******************************************************************************/

#include <windows.h>
#include <bcrypt.h>

#include <qcc/platform.h>

#include <qcc/String.h>
#include <qcc/StringUtil.h>
#include <qcc/Crypto.h>
#include <qcc/KeyBlob.h>

#include <Status.h>

#include <qcc/CngCache.h>

// This status code is defined in ntstatus.h but including nststatus.h generate numerous compiler
// warnings about duplicate defines.
#ifndef STATUS_AUTH_TAG_MISMATCH
#define STATUS_AUTH_TAG_MISMATCH  ((NTSTATUS)0xC000A002L)
#endif

using namespace std;
using namespace qcc;

#define QCC_MODULE "CRYPTO"

struct Crypto_AES::KeyState {
  public:

    KeyState(size_t len) : handle(0) {
        keyObj = new uint8_t[len];
    }

    ~KeyState() {
        // Must destroy the handle BEFORE freeing the key object
        if (handle) {
            BCryptDestroyKey(handle);
        }
        delete [] keyObj;
    }

    BCRYPT_KEY_HANDLE handle;
    uint8_t* keyObj;
  private:
    /**
     * Private copy constructor to prevent copying
     *
     * @param src KeyState to be copied.
     */
    KeyState(const KeyState&);
    /**
     * Assignment operator
     *
     * @param src source KeyState
     *
     * @return copy of KeyState
     */
    KeyState& operator=(const KeyState&);
};

Crypto_AES::Crypto_AES(const KeyBlob& key, Mode mode) : mode(mode), keyState(NULL)
{
    QStatus status;
    BCRYPT_ALG_HANDLE aesHandle = 0;
    BCRYPT_KEY_DATA_BLOB_HEADER* kbh = NULL;

    // We depend on this being true
    QCC_ASSERT(sizeof(Block) == 16);

    if (mode == CCM) {
        if (!cngCache.ccmHandle) {
            status = cngCache.OpenCcmHandle();
            if (ER_OK != status) {
                QCC_ASSERT(!"Failed to open AES-CCM handle");
                abort();
            }
            // Enable CCM
            if (!BCRYPT_SUCCESS(BCryptSetProperty(cngCache.ccmHandle, BCRYPT_CHAINING_MODE, (PUCHAR)BCRYPT_CHAIN_MODE_CCM, sizeof(BCRYPT_CHAIN_MODE_CCM), 0))) {
                status = ER_CRYPTO_ERROR;
                QCC_LogError(status, ("Failed to enable CCM mode on AES algorithm provider"));
                QCC_ASSERT(!"Failed to enable CCM on AES-CCM handle");
                abort();
            }
        }
        aesHandle = cngCache.ccmHandle;
    } else {
        if (!cngCache.ecbHandle) {
            status = cngCache.OpenEcbHandle();
            if (ER_OK != status) {
                QCC_ASSERT(!"Failed to open AES-ECB handle");
                abort();
            }
        }
        aesHandle = cngCache.ecbHandle;
    }

    // Initialize a BCRYPT key blob with the key
    ULONG kbhLen = sizeof(BCRYPT_KEY_DATA_BLOB_HEADER) + key.GetSize();
    kbh = (BCRYPT_KEY_DATA_BLOB_HEADER*)malloc(kbhLen);
    if (NULL == kbh) {
        abort();
    }
    kbh->dwMagic = BCRYPT_KEY_DATA_BLOB_MAGIC;
    kbh->dwVersion = BCRYPT_KEY_DATA_BLOB_VERSION1;
    kbh->cbKeyData = key.GetSize();
    memcpy(kbh + 1, key.GetData(), key.GetSize());

    // Get length of key object and allocate the object
    DWORD got;
    ULONG keyObjLen;

    if (!BCRYPT_SUCCESS(BCryptGetProperty(aesHandle, BCRYPT_OBJECT_LENGTH, (PBYTE)&keyObjLen, sizeof(ULONG), &got, 0))) {
        status = ER_CRYPTO_ERROR;
        QCC_LogError(status, ("Failed to get AES object length property"));
        abort();
    }

    keyState = new KeyState(keyObjLen);

    if (!BCRYPT_SUCCESS(BCryptImportKey(aesHandle, NULL, BCRYPT_KEY_DATA_BLOB, &keyState->handle, keyState->keyObj, keyObjLen, (PUCHAR)kbh, kbhLen, 0))) {
        status = ER_CRYPTO_ERROR;
        QCC_LogError(status, ("Failed to import AES key"));
        abort();
    }

    free(kbh);
}

Crypto_AES::~Crypto_AES()
{
    delete keyState;
}

QStatus Crypto_AES::Encrypt(const Block* in, Block* out, uint32_t numBlocks)
{
    if (!in || !out) {
        return in ? ER_BAD_ARG_1 : ER_BAD_ARG_2;
    }
    /*
     * Check we are initialized for encryption
     */
    if (mode != ECB_ENCRYPT) {
        return ER_CRYPTO_ERROR;
    }
    ULONG len = numBlocks * sizeof(Block);
    ULONG clen;
    if (!BCRYPT_SUCCESS(BCryptEncrypt(keyState->handle, (PUCHAR)in, len, NULL, NULL, 0, (PUCHAR)out, len, &clen, 0))) {
        return ER_CRYPTO_ERROR;
    } else {
        return ER_OK;
    }
}

QStatus Crypto_AES::Encrypt(const void* in, size_t len, Block* out, uint32_t numBlocks)
{
    QStatus status;

    if (!in || !out) {
        return in ? ER_BAD_ARG_1 : ER_BAD_ARG_2;
    }
    /*
     * Check the lengths make sense
     */
    if (numBlocks != NumBlocks(len)) {
        return ER_CRYPTO_ERROR;
    }
    /*
     * Check for a partial final block
     */
    size_t partial = len % sizeof(Block);
    if (partial) {
        numBlocks--;
        status = Encrypt((Block*)in, out, numBlocks);
        if (status == ER_OK) {
            Block padBlock;
            memcpy(&padBlock, ((const uint8_t*)in) + numBlocks * sizeof(Block), partial);
            status = Encrypt(&padBlock, out + numBlocks, 1);
        }
    } else {
        status = Encrypt((const Block*)in, out, numBlocks);
    }
    return status;
}

QStatus Crypto_AES::Encrypt_CCM(const void* in, void* out, size_t& len, const KeyBlob& nonce, const void* addData, size_t addLen, uint8_t authLen)
{
    QStatus status = ER_OK;
    /*
     * Check we are initialized for CCM
     */
    if (mode != CCM) {
        return ER_CRYPTO_ERROR;
    }
    size_t nLen = nonce.GetSize();
    if (!in && len) {
        return ER_BAD_ARG_1;
    }
    if (!out && len) {
        return ER_BAD_ARG_2;
    }
    if (nLen < 4 || nLen > 14) {
        return ER_BAD_ARG_4;
    }
    if ((authLen < 4) || (authLen > 16)) {
        return ER_BAD_ARG_8;
    }
    // Address to put the mac
    uint8_t* mac = (uint8_t*)out + len;
    // Set CCM cipher mode info
    BCRYPT_AUTHENTICATED_CIPHER_MODE_INFO cmi;
    BCRYPT_INIT_AUTH_MODE_INFO(cmi);

    // Zero pad nonce to a minimum size of 11 bytes.
    uint8_t npad[11];
    if (nLen < 11) {
        memcpy(npad, nonce.GetData(), nLen);
        memset(npad + nLen, 0, 11 - nLen);
        cmi.pbNonce = (PUCHAR)npad;
        nLen = 11;
    } else {
        cmi.pbNonce = (PUCHAR)nonce.GetData();
    }
    cmi.cbNonce = nLen;

    cmi.pbAuthData = (PUCHAR)addData;
    cmi.cbAuthData = addLen;
    cmi.pbTag = mac;
    cmi.cbTag = authLen;
    cmi.pbMacContext = NULL;
    cmi.cbMacContext = 0;
    cmi.cbAAD = 0;
    cmi.cbData = 0;
    cmi.dwFlags = 0;

    ULONG clen;
    Block iv;
    NTSTATUS ntstatus = BCryptEncrypt(keyState->handle, (PUCHAR)in, len, &cmi, NULL, 0, (PUCHAR)out, len, &clen, 0);
    if (!BCRYPT_SUCCESS(ntstatus)) {
        status = ER_CRYPTO_ERROR;
        QCC_LogError(status, ("CCM mode encryption failed NTSTATUS=%x", ntstatus));
    } else {
        QCC_ASSERT(len == clen);
        len += authLen;
    }
    return status;
}


QStatus Crypto_AES::Decrypt_CCM(const void* in, void* out, size_t& len, const KeyBlob& nonce, const void* addData, size_t addLen, uint8_t authLen)
{
    QStatus status = ER_OK;
    /*
     * Check we are initialized for CCM
     */
    if (mode != CCM) {
        return ER_CRYPTO_ERROR;
    }
    size_t nLen = nonce.GetSize();
    if (!in && len) {
        return ER_BAD_ARG_1;
    }
    if (!out && len) {
        return ER_BAD_ARG_2;
    }
    if (nLen < 4 || nLen > 14) {
        return ER_BAD_ARG_4;
    }
    if ((authLen < 4) || (authLen > 16)) {
        return ER_BAD_ARG_8;
    }
    // Address to find the mac
    uint8_t* mac = (uint8_t*)in + len - authLen;
    // Set CCM cipher mode info
    BCRYPT_AUTHENTICATED_CIPHER_MODE_INFO cmi;
    BCRYPT_INIT_AUTH_MODE_INFO(cmi);

    // Zero pad nonce to a minimum size of 11 bytes.
    uint8_t npad[11];
    if (nLen < 11) {
        memcpy(npad, nonce.GetData(), nLen);
        memset(npad + nLen, 0, 11 - nLen);
        cmi.pbNonce = (PUCHAR)npad;
        nLen = 11;
    } else {
        cmi.pbNonce = (PUCHAR)nonce.GetData();
    }
    cmi.cbNonce = nLen;

    cmi.pbAuthData = (PUCHAR)addData;
    cmi.cbAuthData = addLen;
    cmi.pbTag = mac;
    cmi.cbTag = authLen;
    cmi.pbMacContext = NULL;
    cmi.cbMacContext = 0;
    cmi.cbAAD = 0;
    cmi.cbData = 0;
    cmi.dwFlags = 0;

    ULONG clen;
    NTSTATUS ntstatus = BCryptDecrypt(keyState->handle, (PUCHAR)in, len - authLen, &cmi, NULL, 0, (PUCHAR)out, len, &clen, 0);
    if (!BCRYPT_SUCCESS(ntstatus)) {
        if (ntstatus == STATUS_AUTH_TAG_MISMATCH) {
            status = ER_AUTH_FAIL;
        } else {
            status = ER_CRYPTO_ERROR;
        }
        QCC_LogError(status, ("CCM mode decryption failed NTSTATUS=%x", ntstatus));
    } else {
        len -= authLen;
        QCC_ASSERT(len == clen);
    }
    return status;
}