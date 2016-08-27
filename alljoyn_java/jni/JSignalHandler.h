/******************************************************************************
 * Copyright AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for any
 *    purpose with or without fee is hereby granted, provided that the above
 *    copyright notice and this permission notice appear in all copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 ******************************************************************************/
#ifndef _ALLJOYN_JSIGNALHANDLER_H
#define _ALLJOYN_JSIGNALHANDLER_H

#include <jni.h>
#include <alljoyn/BusAttachment.h>
#include <qcc/String.h>

using namespace ajn;
using namespace qcc;

class JSignalHandler : public MessageReceiver {
  public:
    JSignalHandler(jobject jobj, jobject jmethod);
    virtual ~JSignalHandler();
    bool IsSameObject(jobject jobj, jobject jmethod);
    virtual QStatus Register(BusAttachment& bus, const char* ifaceName, const char* signalName, const char* ancillary);
    virtual void Unregister(BusAttachment& bus) = 0;
    void SignalHandler(const InterfaceDescription::Member* member, const char* sourcePath, Message& msg);
  protected:
    jweak jsignalHandler;
    jobject jmethod;
    const InterfaceDescription::Member* member;
    String ancillary_data; /* can be both source or matchRule; */

  private:
    JSignalHandler(const JSignalHandler& other);
    JSignalHandler& operator =(const JSignalHandler& other);

};

#endif
