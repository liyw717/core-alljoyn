/*
 * Copyright (c) 2016 Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright 2016 Open Connectivity Foundation and Contributors to
 *    AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 */
#ifndef _HTTPREQUESTHOST_H
#define _HTTPREQUESTHOST_H

#include "HttpServer.h"
#include "ScriptableObject.h"
#include <qcc/String.h>
#include <map>

class _HttpRequestHost : public ScriptableObject {
  public:
    _HttpRequestHost(Plugin& plugin, HttpServer& httpServer, Http::Headers& requestHeaders, qcc::SocketStream& stream, qcc::SocketFd sessionFd);
    virtual ~_HttpRequestHost();

  private:
    HttpServer httpServer;
    Http::Headers requestHeaders;
    qcc::SocketStream stream;
    qcc::SocketFd sessionFd;
    uint16_t status;
    qcc::String statusText;
    Http::Headers responseHeaders;

    bool getStatus(NPVariant* result);
    bool setStatus(const NPVariant* value);
    bool getStatusText(NPVariant* result);
    bool setStatusText(const NPVariant* value);

    bool getAllRequestHeaders(const NPVariant* args, uint32_t argCount, NPVariant* result);
    bool getRequestHeader(const NPVariant* args, uint32_t argCount, NPVariant* result);
    bool setResponseHeader(const NPVariant* args, uint32_t argCount, NPVariant* result);
    bool send(const NPVariant* args, uint32_t argCount, NPVariant* result);
};

typedef qcc::ManagedObj<_HttpRequestHost> HttpRequestHost;

#endif // _HTTPREQUESTHOST_H