/**
 * @file
 *
 * This file tests SRP against the RFC 5054 test vector
 */

/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
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

#include <qcc/platform.h>

#include <qcc/Crypto.h>
#include <qcc/Debug.h>
#include <qcc/KeyBlob.h>
#include <qcc/String.h>
#include <qcc/StringUtil.h>
#include <qcc/Util.h>
#include <qcc/Debug.h>
#include <qcc/BigNum.h>

#include <alljoyn/version.h>
#include <alljoyn/BusAttachment.h>
#include <alljoyn/AuthListener.h>

#include <alljoyn/Status.h>

/* Private files included for unit testing */
#include <SASLEngine.h>

#include <gtest/gtest.h>
#include "ajTestCommon.h"

#define QCC_MODULE "CRYPTO"

using namespace qcc;
using namespace std;
using namespace ajn;

TEST(SRPTest, RFC_5246_test_vector) {
    Crypto_SRP srp;
    QStatus status = srp.TestVector();
    EXPECT_EQ(ER_OK, status) << " Sign failed";
}


TEST(SRPTest, Basic_API) {
    /*
     * Basic API test.
     */
    QStatus status = ER_OK;
    String toClient;
    String toServer;
    String verifier;
    KeyBlob serverPMS;
    KeyBlob clientPMS;
    String user = "someuser";
    String pwd = "a-secret-password";
    String otherPwd = "a-different-password";

    for (int i = 0; i < 1; ++i) {
        {
            Crypto_SRP client;
            Crypto_SRP server;

            status = server.ServerInit(user, pwd, toClient);
            ASSERT_EQ(ER_OK, status) << " SRP ServerInit failed";

            status = client.ClientInit(toClient, toServer);
            ASSERT_EQ(ER_OK, status) << " SRP ClientInit failed";

            status = server.ServerFinish(toServer);
            ASSERT_EQ(ER_OK, status) << " SRP ServerFinish failed";

            status = client.ClientFinish(user, pwd);
            ASSERT_EQ(ER_OK, status) << " SRP ClientFinish failed";

            /*
             * Check premaster secrets match
             */
            server.GetPremasterSecret(serverPMS);
            client.GetPremasterSecret(clientPMS);
            ASSERT_EQ(clientPMS.GetSize(), serverPMS.GetSize())
                << "Premaster secrets have different sizes"
                << "Premaster secret = " << BytesToHexString(serverPMS.GetData(), serverPMS.GetSize()).c_str();

            ASSERT_EQ(0, memcmp(serverPMS.GetData(), clientPMS.GetData(), serverPMS.GetSize()))
                << "Premaster secrets don't match\n"
                << "server = " << BytesToHexString(serverPMS.GetData(), serverPMS.GetSize()).c_str() << "\n"
                << "client = " << BytesToHexString(clientPMS.GetData(), clientPMS.GetSize()).c_str() << "\n"
                << "Premaster secret = " << BytesToHexString(serverPMS.GetData(), serverPMS.GetSize()).c_str();

            verifier = server.ServerGetVerifier();

        }
    }

    //###### Checking verifier ########
    /*
     * Test using the verifier from the previous test.
     */
    {
        Crypto_SRP client;
        Crypto_SRP server;

        status = server.ServerInit(verifier, toClient);
        ASSERT_EQ(ER_OK, status) << " SRP ServerInit failed";

        status = client.ClientInit(toClient, toServer);
        ASSERT_EQ(ER_OK, status) << " SRP ClientInit failed";

        status = server.ServerFinish(toServer);
        ASSERT_EQ(ER_OK, status) << " SRP ServerFinish failed";

        status = client.ClientFinish(user, pwd);
        ASSERT_EQ(ER_OK, status) << " SRP ClientFinish failed";

        /*
         * Check premaster secrets match
         */
        server.GetPremasterSecret(serverPMS);
        client.GetPremasterSecret(clientPMS);
        ASSERT_EQ(clientPMS.GetSize(), serverPMS.GetSize())
            << "Premaster secrets have different sizes"
            << "Premaster secret = " << BytesToHexString(serverPMS.GetData(), serverPMS.GetSize()).c_str();

        ASSERT_EQ(0, memcmp(serverPMS.GetData(), clientPMS.GetData(), serverPMS.GetSize()))
            << "Premaster secrets don't match\n"
            << "server = " << BytesToHexString(serverPMS.GetData(), serverPMS.GetSize()).c_str() << "\n"
            << "client = " << BytesToHexString(clientPMS.GetData(), clientPMS.GetSize()).c_str() << "\n"
            << "Premaster secret = " << BytesToHexString(serverPMS.GetData(), serverPMS.GetSize()).c_str();

        /*
         *  Testing pseudo random function with SRP output.
         */
        qcc::String serverRand = RandHexString(64);
        qcc::String clientRand = RandHexString(64);
        uint8_t masterSecret[48];

        status = Crypto_PseudorandomFunction(serverPMS, "foobar", serverRand + clientRand, masterSecret, sizeof(masterSecret));
        ASSERT_EQ(ER_OK, status)
            << " SRP ClientFinish failed\n"
            << "Master secret = " << BytesToHexString(masterSecret, sizeof(masterSecret)).c_str();
    }



    /*
     * Ensure protocol *fails* with incorrect password.
     * Use the server verifier for pwd, client will try to authenticated with otherPwd.
     */
    {
        Crypto_SRP client;
        Crypto_SRP server;

        status = server.ServerInit(verifier, toClient);
        ASSERT_EQ(ER_OK, status) << " SRP ServerInit failed";

        status = client.ClientInit(toClient, toServer);
        ASSERT_EQ(ER_OK, status) << " SRP ClientInit failed";

        status = server.ServerFinish(toServer);
        ASSERT_EQ(ER_OK, status) << " SRP ServerFinish failed";

        status = client.ClientFinish(user, otherPwd);
        ASSERT_EQ(ER_OK, status) << " SRP ClientFinish failed";

        /*
         * Check premaster secrets don't match
         */
        server.GetPremasterSecret(serverPMS);
        client.GetPremasterSecret(clientPMS);
        if (clientPMS.GetSize() == serverPMS.GetSize()) {
            ASSERT_NE(0, memcmp(serverPMS.GetData(), clientPMS.GetData(), serverPMS.GetSize()))
                << "Premaster secrets match but shouldn't (different passwords)\n"
                << "server = " << BytesToHexString(serverPMS.GetData(), serverPMS.GetSize()).c_str() << "\n"
                << "client = " << BytesToHexString(clientPMS.GetData(), clientPMS.GetSize()).c_str() << "\n"
                << "Premaster secret = " << BytesToHexString(serverPMS.GetData(), serverPMS.GetSize()).c_str();
        }

        /*
         *  Testing pseudo random function with SRP output.
         */
        qcc::String serverRand = RandHexString(64);
        qcc::String clientRand = RandHexString(64);
        uint8_t masterSecret[48];

        status = Crypto_PseudorandomFunction(serverPMS, "foobar", serverRand + clientRand, masterSecret, sizeof(masterSecret));
        ASSERT_EQ(ER_OK, status)
            << " SRP ClientFinish failed\n"
            << "Master secret = " << BytesToHexString(masterSecret, sizeof(masterSecret)).c_str();
    }

}

class MyAuthListener : public AuthListener {
    bool RequestCredentials(const char* authMechanism, const char* authPeer, uint16_t authCount, const char* userId, uint16_t credMask, Credentials& creds) {
        QCC_UNUSED(authMechanism);
        QCC_UNUSED(authPeer);
        QCC_UNUSED(authCount);
        QCC_UNUSED(userId);
        QCC_UNUSED(credMask);
        creds.SetPassword("123456");
        return true;
    }
    void AuthenticationComplete(const char* authMechanism, const char* authPeer, bool success) {
        QCC_UNUSED(authPeer);
        printf("Authentication %s %s\n", authMechanism, success ? "succesful" : "failed");
    }
};

TEST(SRPTest, authentication_mechanism) {
    QStatus status = ER_OK;

    BusAttachment bus("srp");
    MyAuthListener myListener;
    bus.EnablePeerSecurity("ALLJOYN_SRP_KEYX", &myListener);

    ProtectedAuthListener listener;
    listener.Set(&myListener);

    SASLEngine responder(bus, ajn::AuthMechanism::RESPONDER, "ALLJOYN_SRP_KEYX", "1:1", listener);
    SASLEngine challenger(bus, ajn::AuthMechanism::CHALLENGER, "ALLJOYN_SRP_KEYX", "1:1", listener);

    SASLEngine::AuthState rState = SASLEngine::ALLJOYN_AUTH_FAILED;
    SASLEngine::AuthState cState = SASLEngine::ALLJOYN_AUTH_FAILED;

    qcc::String rStr;
    qcc::String cStr;

    while (status == ER_OK) {
        status = responder.Advance(cStr, rStr, rState);
        ASSERT_EQ(ER_OK, status) << "  Responder";

        status = challenger.Advance(rStr, cStr, cState);
        ASSERT_EQ(ER_OK, status) << "  Challenger";

        if ((rState == SASLEngine::ALLJOYN_AUTH_SUCCESS) && (cState == SASLEngine::ALLJOYN_AUTH_SUCCESS)) {
            break;
        }
    }
}