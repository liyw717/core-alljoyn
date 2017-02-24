#ifndef _ALLJOYN_PERMISSION_CONFIGURATOR_H
#define _ALLJOYN_PERMISSION_CONFIGURATOR_H
/**
 * @file
 * This file defines the Permission Configurator class that exposes some permission
 * management capabilities to the application.
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

#ifndef __cplusplus
#error Only include PermissionConfigurator.h in C++ code.
#endif

#include <qcc/platform.h>
#include <qcc/String.h>
#include <qcc/CertificateECC.h>
#include <alljoyn/Status.h>
#include <alljoyn/PermissionPolicy.h>

namespace ajn {

/**
 * Class to allow the application to manage some limited permission feature.
 */

class PermissionConfigurator {

  public:

    typedef enum {
        NOT_CLAIMABLE = 0, ///< The application is not claimed and not accepting claim requests.
        CLAIMABLE = 1,     ///< The application is not claimed and is accepting claim requests.
        CLAIMED = 2,       ///< The application is claimed and can be configured.
        NEED_UPDATE = 3    ///< The application is claimed, but requires a configuration update (after a software upgrade).
    } ApplicationState;

    /**
     * @brief returns the string representation of the application state.
     *
     * @param[in] as    application state.
     *
     * @return string   representation of the application state.
     */
    static const char* ToString(const PermissionConfigurator::ApplicationState as) {
        switch (as) {
        case PermissionConfigurator::NOT_CLAIMABLE:
            return "NOT CLAIMABLE";

        case PermissionConfigurator::CLAIMABLE:
            return "CLAIMABLE";

        case PermissionConfigurator::CLAIMED:
            return "CLAIMED";

        case PermissionConfigurator::NEED_UPDATE:
            return "NEED UPDATE";
        }

        return "UNKNOWN";
    }


    /**@name ClaimCapabilities */
    // {@
    typedef uint16_t ClaimCapabilities;
    typedef enum {
        CAPABLE_ECDHE_NULL = 0x01,
        CAPABLE_ECDHE_PSK = 0x02,   ///< Deprecated, will be removed in a future release.
        CAPABLE_ECDHE_ECDSA = 0x04,
        CAPABLE_ECDHE_SPEKE = 0x08
    } ClaimCapabilityMasks;
    // @}

    /** Default ClaimCapabilities: NULL, PSK and SPEKE. */
    static const uint16_t CLAIM_CAPABILITIES_DEFAULT;

    /**@name ClaimCapabilityAdditionalInfo */
    // {@
    typedef uint16_t ClaimCapabilityAdditionalInfo;
    typedef enum {
        PSK_GENERATED_BY_SECURITY_MANAGER = 0x01,   ///< The pre-shared key or password is generated by the security manager
        PSK_GENERATED_BY_APPLICATION      = 0x02    ///< The pre-shared key or password is generated by the application
    } ClaimCapabilityAdditionalInfoMasks;
    // @}
    /**
     * Constructor
     *
     */
    PermissionConfigurator(BusAttachment& bus);

    /**
     * virtual destructor
     */
    virtual ~PermissionConfigurator();

    /**
     * Set the permission manifest template for the application.
     * @param rules the permission rules.
     * @param count the number of permission rules
     * @return ER_OK if successful; otherwise, an error code.
     */
    QStatus SetPermissionManifestTemplate(PermissionPolicy::Rule* rules, size_t count);

    /**
     * Get the manifest template for the application as XML.
     *
     * @param[out] manifestTemplateXml std::string to receive the manifest template as XML.
     *
     * @return ER_OK if successful; otherwise, an error code.
     */
    QStatus GetManifestTemplateAsXml(std::string& manifestTemplateXml);

    /**
     * Set the manifest template for the application from an XML.
     *
     * @param[in] manifestTemplateXml XML containing the manifest template.
     *
     * @return ER_OK if successful; otherwise, an error code.
     */
    QStatus SetManifestTemplateFromXml(AJ_PCSTR manifestTemplateXml);

    /**
     * Retrieve the state of the application.
     * @param[out] applicationState the application state
     * @return
     *      - #ER_OK if successful
     *      - #ER_NOT_IMPLEMENTED if the method is not implemented
     *      - #ER_FEATURE_NOT_AVAILABLE if the value is not known
     */
    QStatus GetApplicationState(ApplicationState& applicationState) const;

    /**
     * Set the application state.  The state can't be changed from CLAIMED to
     * CLAIMABLE.
     * @param newState The new application state
     * @return
     *      - #ER_OK if action is allowed.
     *      - #ER_INVALID_APPLICATION_STATE if the state can't be changed
     *      - #ER_NOT_IMPLEMENTED if the method is not implemented
     */
    QStatus SetApplicationState(ApplicationState newState);

    /**
     * Retrieve the public key info for the signing key.
     * @param[out] keyInfo the public key info
     * @return ER_OK if successful; otherwise, an error code.
     */
    QStatus GetSigningPublicKey(qcc::KeyInfoECC& keyInfo);

    /**
     * Sign the X509 certificate using the signing key
     * @param[out] cert the certificate to be signed
     * @return ER_OK if successful; otherwise, an error code.
     */
    QStatus SignCertificate(qcc::CertificateX509& cert);

    /**
     * Sign a manifest using the signing key, and bind the manifest to a particular identity
     * certificate by providing its thumbprint. For this manifest to be valid when later used,
     * the signing key of this PermissionConfigurator must be the signing key that issued the
     * certificate. Callers must ensure the correct key is used.
     *
     * @param[in] subjectThumbprint Identity certificate thumbprint to use the manifest
     * @param[in,out] manifest Manifest to sign
     * @return ER_OK of successful; otherwise, an error code.
     */
    QStatus SignManifest(const std::vector<uint8_t>& subjectThumbprint, Manifest& manifest);

    /**
     * Sign a manifest using the signing key, and bind the manifest to a particular identity
     * certificate by providing the certificate. For this manifest to be valid when later used,
     * the signing key of this PermissionConfigurator must be the signing key that issued the
     * certificate. Callers must ensure the correct key is used; this method does not verify
     * the signing key was used to issue the provided certificate.
     *
     * @param[in] subjectCertificate Certificate to use the manifest. Certificate must already be
     *                               signed in order to encode its identity correctly in the manifest.
     * @param[in,out] manifest       Manifest to sign
     * @return ER_OK if successful; otherwise, an error code.
     */
    QStatus ComputeThumbprintAndSignManifest(const qcc::CertificateX509& subjectCertificate, Manifest& manifest);

    /**
     * Sign a manifest using the signing key, and bind the manifest to a particular identity
     * certificate by providing the certificate. For this manifest to be valid when later used,
     * the signing key of this PermissionConfigurator must be the signing key that issued the
     * certificate. Callers must ensure the correct key is used; this method does not verify
     * the signing key was used to issue the provided certificate.
     *
     * @param[in] subjectCertificate Certificate to use the manifest. Certificate must already be
     *                               signed in order to encode its identity correctly in the manifest.
     * @param[in,out] manifest       Manifest to sign
     * @return ER_OK if successful; otherwise, an error code.
     */
    QStatus ComputeThumbprintAndSignManifestXml(const qcc::CertificateX509& subjectCertificate, std::string& manifest);

    /**
     * Reset the permission settings by removing the manifest all the
     * trust anchors, installed policy and certificates. This call
     * must be invoked after the bus attachment has enable peer security.
     * @return ER_OK if successful; otherwise, an error code.
     * @see BusAttachment::EnablePeerSecurity
     */
    QStatus Reset();

    /**
     * Get the connected peer ECC public key if the connection uses the
     * ECDHE_ECDSA key exchange.
     * @param guid the peer guid
     * @param[out] publicKey the buffer to hold the ECC public key.
     * @return ER_OK if successful; otherwise, error code.
     */
    QStatus GetConnectedPeerPublicKey(const qcc::GUID128& guid, qcc::ECCPublicKey* publicKey);

    /**
     * Set the authentication mechanisms the application supports for the
     * claim process.  It is a bit mask.
     *
     * | Mask                | Description              |
     * |---------------------|--------------------------|
     * | CAPABLE_ECDHE_NULL  | claiming via ECDHE_NULL  |
     * | CAPABLE_ECDHE_PSK   | claiming via ECDHE_PSK   |
     * | CAPABLE_ECDHE_ECDSA | claiming via ECDHE_ECDSA |
     *
     * @param[in] claimCapabilities The authentication mechanisms the application supports
     *
     * @return
     *  - #ER_OK if successful
     *  - an error status indicating failure
     */
    QStatus SetClaimCapabilities(PermissionConfigurator::ClaimCapabilities claimCapabilities);

    /**
     * Get the authentication mechanisms the application supports for the
     * claim process.
     *
     * @param[out] claimCapabilities The authentication mechanisms the application supports
     *
     * @return
     *  - #ER_OK if successful
     *  - an error status indicating failure
     */
    QStatus GetClaimCapabilities(PermissionConfigurator::ClaimCapabilities& claimCapabilities) const;

    /**
     * Set the additional information on the claim capabilities.
     * It is a bit mask.
     *
     * | Mask                              | Description                       |
     * |-----------------------------------|-----------------------------------|
     * | PSK_GENERATED_BY_SECURITY_MANAGER | PSK generated by Security Manager |
     * | PSK_GENERATED_BY_APPLICATION      | PSK generated by application      |
     *
     * @param[in] additionalInfo The additional info
     *
     * @return
     *  - #ER_OK if successful
     *  - an error status indicating failure
     */
    QStatus SetClaimCapabilityAdditionalInfo(PermissionConfigurator::ClaimCapabilityAdditionalInfo additionalInfo);

    /**
     * Get the additional information on the claim capabilities.
     * @param[out] additionalInfo The additional info
     *
     * @return
     *  - #ER_OK if successful
     *  - an error status indicating failure
     */
    QStatus GetClaimCapabilityAdditionalInfo(PermissionConfigurator::ClaimCapabilityAdditionalInfo& additionalInfo) const;

    /**
     * Perform claiming of this app locally/offline. Peer security must first be enabled on the bus attachment.
     *
     * To prevent a potential security-critical race condition, before claiming a bus attachment with this method,
     * it is recommended to call EnablePeerSecurity on an unclaimed BusAttachment with "ALLJOYN_ECDHE_ECDSA" only
     * in the authMechanisms parameter. The default claim capabilities do not allow ALLJOYN_ECDHE_ECDSA for claiming,
     * and this will guarantee a rogue security manager on the same bus can't claim the bus attachment before this
     * method is called. Do not set claim capabilities on a bus attachment which will be claimed using this method.
     *
     * After the bus attachment is claimed, EnablePeerSecurity can be called again if any of the other authentication
     * mechanisms are required; this will usually only be required if the bus attachment will be used by a security
     * manager to claim other apps over the bus. See BusAttachment::EnablePeerSecurity's documentation for details on
     * changing authentication mechanisms.
     *
     * @param[in] certificateAuthority Certificate authority public key
     * @param[in] adminGroupGuid Admin group GUID
     * @param[in] adminGroupAuthority Admin group authority public key
     * @param[in] identityCertChain Identity cert chain
     * @param[in] identityCertChainCount Count of certs array
     * @param[in] manifestsXmls Signed manifests in XML format
     * @param[in] manifestsCount Number of manifests in the manifestsXmls array
     *
     * @return
     *    - #ER_OK if the app was successfully claimed
     *    - #ER_FAIL if the app could not be claimed, but could not then be reset back to original state.
     *               App will be in unknown state in this case.
     *    - other error code indicating failure, but app is returned to reset state
     */
    QStatus Claim(
        const qcc::KeyInfoNISTP256& certificateAuthority,
        const qcc::GUID128& adminGroupGuid,
        const qcc::KeyInfoNISTP256& adminGroupAuthority,
        const qcc::CertificateX509* identityCertChain,
        size_t identityCertChainCount,
        AJ_PCSTR* manifestsXmls,
        size_t manifestsCount);

    /**
     * Perform a local UpdateIdentity to replace the identity certificate chain and
     * the signed manifests. If successful, already-installed certificates and signed
     * manifests are cleared; on failure, the state of both are unchanged.
     *
     * @param[in] certs Identity cert chain to be installed
     * @param[in] certCount Number of certificates in certs array
     * @param[in] manifestsXmls Signed manifests to be installed
     * @param[in] manifestsCount Number of signed manifests in manifestsXmls array
     *
     * @return
     *    - #ER_OK if the identity was successfully updated
     *    - other error code indicating failure
     */
    QStatus UpdateIdentity(
        const qcc::CertificateX509* certs,
        size_t certCount,
        AJ_PCSTR* manifestsXmls,
        size_t manifestsCount);

    /**
     * Retrieve the local app's identity certificate chain.
     *
     * @param[out] certChain A vector containing the identity certificate chain
     *
     * @return
     *    - #ER_OK if the chain is successfully stored in certChain
     *    - other error indicating failure
     */
    QStatus GetIdentity(std::vector<qcc::CertificateX509>& certChain);

    /**
     * Retrieve the local app's signed manifests.
     *
     * @param[out] manifests A vector containing the signed manifests
     *
     * @return
     *    - #ER_OK if the signed manifests are successfully retrieved
     *    - #ER_MANIFEST_NOT_FOUND if no manifests have been installed into the keystore
     *    - other error indicating failure
     */
    QStatus GetManifests(std::vector<Manifest>& manifests);

    /**
     * Retrieve the local app's identity certificate information.
     *
     * @param[out] serial Identity certificate's serial
     * @param[out] keyInfo Identity certificate's KeyInfoNISTP256 structure
     *
     * @return
     *    - #ER_OK if the identity certificate information is placed in the parameters
     *    - #ER_CERTIFICATE_NOT_FOUND if no identity certificate is installed
     *    - other error code indicating failure
     */
    QStatus GetIdentityCertificateId(qcc::String& serial, qcc::KeyInfoNISTP256& issuerKeyInfo);

    /**
     * Update the local app's active policy. Unlike the UpdatePolicy method of the Managed
     * application interface, this method WILL allow you to install a policy with a lesser version
     * number. Caller is responsible for getting the current policy and checking its version number
     * first if only installing policy with a higher version number is desired.
     *
     * @see PermissionConfigurator::GetPolicy(PermissionPolicy&)
     *
     * @param[in] policy Policy to install
     *
     * @return
     *    - #ER_OK if the policy is successfully updated
     *    - other error code indicating failure. Policy is unchanged.
     */
    QStatus UpdatePolicy(const PermissionPolicy& policy);

    /**
     * Get the local app's active policy.
     *
     * @param[out] policy The active policy
     *
     * @return
     *    - #ER_OK if the policy is successfully retrieved
     *    - other error code indicating failure
     */
    QStatus GetPolicy(PermissionPolicy& policy);

    /**
     * Get the local app's default policy.
     *
     * @param[out] policy The default policy
     *
     * @return
     *    - #ER_OK if the default policy is successfully retrieved
     *    - other error code indicating failure
     */
    QStatus GetDefaultPolicy(PermissionPolicy& policy);

    /**
     * Reset the local app's policy to the default policy.
     *
     * @return
     *    - #ER_OK if the policy was successfully reset
     *    - other error code indicating failure
     */
    QStatus ResetPolicy();

    /**
     * Get the membership certificate summaries.
     *
     * @param[out] serials A vector of String to receive all the serial numbers
     * @param[out] keyInfos A vector of KeyInfoNISTP256 to receive all the issuer key information structures
     *
     * @remarks Existing contents of serials and keyInfos will be overwritten. If this method fails, or
     *          there are no membership certificates installed, both will be returned empty.
     *
     * @return
     *    - #ER_OK if the membership summaries are successfully retrieved
     *    - other error indicating failure
     */
    QStatus GetMembershipSummaries(std::vector<qcc::String>& serials, std::vector<qcc::KeyInfoNISTP256>& keyInfos);

    /**
     * Install a membership certificate chain.
     *
     * @param[in] certChain Certificate chain
     * @param[in] certCount Number of certificates in certChain
     *
     * @return
     *    - #ER_OK if the membership certificate chain is successfully installed
     *    - other error code indicating failure
     */
    QStatus InstallMembership(const qcc::CertificateX509* certChain, size_t certCount);

    /**
     * Remove a membership certificate chain.
     *
     * @param[in] serial Serial number of the certificate
     * @param[in] issuerPubKey Pointer to certificate issuer's public key
     * @param[in] issuerAki Certificate issuer's AKI
     *
     * @return
     *    - #ER_OK if the certificate was found and removed
     *    - #ER_CERTIFICATE_NOT_FOUND if the certificate was not found
     *    - other error code indicating failure
     */
    QStatus RemoveMembership(const qcc::String& serial, const qcc::ECCPublicKey* issuerPubKey, const qcc::String& issuerAki);

    /**
     * Remove a membership certificate chain.
     *
     * @param[in] serial Serial number of the certificate
     * @param[in] issuerKeyInfo KeyInfoNISTP256 object containing the issuer info
     *
     * @return
     *    - #ER_OK if the certificate was found and removed
     *    - #ER_CERTIFICATE_NOT_FOUND if the certificate was not found
     *    - other error code indicating failure
     */
    QStatus RemoveMembership(const qcc::String& serial, const qcc::KeyInfoNISTP256& issuerKeyInfo);

    /**
     * Signal the app locally that management is starting.
     *
     * @return
     *    - #ER_OK if the start management signal was sent
     *    - #ER_MANAGEMENT_ALREADY_STARTED if the app is already in this state
     */
    QStatus StartManagement();

    /**
     * Signal the app locally that management is ending.
     *
     * @return
     *    - #ER_OK if the start management signal was sent
     *    - #ER_MANAGEMENT_NOT_STARTED if the app was not in the management state
     */
    QStatus EndManagement();

    /**
     * Install signed manifests to the local app.
     *
     * @param[in] manifestsXmls An array of signed manifests to install in XML format
     * @param[in] manifestsCount The number of manifests in the manifests array
     * @param[in] append True to append the manifests to any already installed, or false to clear manifests out first
     *
     * On failure, the installed set of manifests is unchanged.
     *
     * @return
     *    - #ER_OK if manifests are successfully installed
     *    - #ER_DIGEST_MISMATCH if none of the manifests have been signed
     *    - other error code indicating failure
     */
    QStatus InstallManifests(AJ_PCSTR* manifestsXmls, size_t manifestsCount, bool append);

  private:
    /**
     * @internal
     * Class for internal state of a PermissionConfigurator object.
     */
    class Internal;

    /**
     * @internal
     * Contains internal state of a PermissionConfigurator object.
     */
    PermissionConfigurator::Internal* m_internal;

    /**
     * Assignment operator is private.
     */
    PermissionConfigurator& operator=(const PermissionConfigurator& other);

    /**
     * Copy constructor is private.
     */
    PermissionConfigurator(const PermissionConfigurator& other);
};

}
#endif