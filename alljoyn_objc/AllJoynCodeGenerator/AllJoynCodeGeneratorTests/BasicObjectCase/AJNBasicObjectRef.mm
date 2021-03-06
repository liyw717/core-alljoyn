////////////////////////////////////////////////////////////////////////////////
//    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
//    Project (AJOSP) Contributors and others.
//
//    SPDX-License-Identifier: Apache-2.0
//
//    All rights reserved. This program and the accompanying materials are
//    made available under the terms of the Apache License, Version 2.0
//    which accompanies this distribution, and is available at
//    http://www.apache.org/licenses/LICENSE-2.0
//
//    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
//    Alliance. All rights reserved.
//
//    Permission to use, copy, modify, and/or distribute this software for
//    any purpose with or without fee is hereby granted, provided that the
//    above copyright notice and this permission notice appear in all
//    copies.
//
//    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
//    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
//    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
//    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
//    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
//    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
//    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
//    PERFORMANCE OF THIS SOFTWARE.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  ALLJOYN MODELING TOOL - GENERATED CODE
//
////////////////////////////////////////////////////////////////////////////////
//
//  DO NOT EDIT
//
//  Add a category or subclass in separate .h/.m files to extend these classes
//
////////////////////////////////////////////////////////////////////////////////
//
//  AJNBasicObject.mm
//
////////////////////////////////////////////////////////////////////////////////

#import <alljoyn/BusAttachment.h>
#import <alljoyn/BusObject.h>
#import "AJNBusObjectImpl.h"
#import "AJNInterfaceDescription.h"
#import "AJNMessageArgument.h"
#import "AJNSignalHandlerImpl.h"

#import "BasicObject.h"

using namespace ajn;

@interface AJNMessageArgument(Private)

/**
 * Helper to return the C++ API object that is encapsulated by this objective-c class
 */
@property (nonatomic, readonly) MsgArg *msgArg;

@end


////////////////////////////////////////////////////////////////////////////////
//
//  C++ Bus Object class declaration for BasicObjectImpl
//
////////////////////////////////////////////////////////////////////////////////
class BasicObjectImpl : public AJNBusObjectImpl
{
private:
    const InterfaceDescription::Member* TestStringPropertyChangedSignalMember;
	const InterfaceDescription::Member* TestSignalWithComplexArgsSignalMember;
	const InterfaceDescription::Member* TestSignalWithNoArgsSignalMember;
	const InterfaceDescription::Member* ChatSignalMember;


public:
    BasicObjectImpl(const char *path, id<BasicStringsDelegate, BasicChatDelegate> aDelegate);
    BasicObjectImpl(BusAttachment &bus, const char *path, id<BasicStringsDelegate, BasicChatDelegate> aDelegate);

    virtual QStatus AddInterfacesAndHandlers(BusAttachment &bus);


    // properties
    //
    virtual QStatus Get(const char* ifcName, const char* propName, MsgArg& val);
    virtual QStatus Set(const char* ifcName, const char* propName, MsgArg& val);


    // methods
    //
    void Concatentate(const InterfaceDescription::Member* member, Message& msg);
	void MethodWithOneInAndMultipleOutArgs(const InterfaceDescription::Member* member, Message& msg);
	void MethodWithMultipleOutArgs(const InterfaceDescription::Member* member, Message& msg);
	void MethodWithOnlyOutArgs(const InterfaceDescription::Member* member, Message& msg);
	void MethodWithNoReturnAndNoArgs(const InterfaceDescription::Member* member, Message& msg);
	void MethodWithReturnAndNoInArgs(const InterfaceDescription::Member* member, Message& msg);
	void MethodWithComplexTypesForArgs(const InterfaceDescription::Member* member, Message& msg);
	void MethodWithBoolInAndReturnArg(const InterfaceDescription::Member* member, Message& msg);


    // signals
    //
    QStatus SendTestStringPropertyChanged(const char * oldString,const char * newString, const char* destination, SessionId sessionId, uint16_t timeToLive = 0, uint8_t flags = 0);
	QStatus SendTestSignalWithComplexArgs(MsgArg* oldString, const char* destination, SessionId sessionId, uint16_t timeToLive = 0, uint8_t flags = 0);
	QStatus SendTestSignalWithNoArgs( const char* destination, SessionId sessionId, uint16_t timeToLive = 0, uint8_t flags = 0);
	QStatus SendChat(const char * message, const char* destination, SessionId sessionId, uint16_t timeToLive = 0, uint8_t flags = 0);

};
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  C++ Bus Object implementation for BasicObjectImpl
//
////////////////////////////////////////////////////////////////////////////////

BasicObjectImpl::BasicObjectImpl(const char *path, id<BasicStringsDelegate, BasicChatDelegate> aDelegate) :
    AJNBusObjectImpl(path,aDelegate)
{
    // Intentionally empty
}

BasicObjectImpl::BasicObjectImpl(BusAttachment &bus, const char *path, id<BasicStringsDelegate, BasicChatDelegate> aDelegate) :
    AJNBusObjectImpl(bus,path,aDelegate)
{
    AddInterfacesAndHandlers(bus);
}

QStatus BasicObjectImpl::AddInterfacesAndHandlers(BusAttachment &bus)
{
    const InterfaceDescription* interfaceDescription = NULL;
    QStatus status = ER_OK;


    // Add the org.alljoyn.bus.sample.strings interface to this object
    //
    interfaceDescription = bus.GetInterface("org.alljoyn.bus.sample.strings");
    assert(interfaceDescription);
    status = AddInterface(*interfaceDescription);
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred while adding the interface org.alljoyn.bus.sample.strings.%@", [AJNStatus descriptionForStatusCode:status]);
    }

    // Register the method handlers for interface BasicStringsDelegate with the object
    //
    const MethodEntry methodEntriesForBasicStringsDelegate[] = {

        {
			interfaceDescription->GetMember("Concatentate"), static_cast<MessageReceiver::MethodHandler>(&BasicObjectImpl::Concatentate)
		},

		{
			interfaceDescription->GetMember("MethodWithOneInAndMultipleOutArgs"), static_cast<MessageReceiver::MethodHandler>(&BasicObjectImpl::MethodWithOneInAndMultipleOutArgs)
		},

		{
			interfaceDescription->GetMember("MethodWithMultipleOutArgs"), static_cast<MessageReceiver::MethodHandler>(&BasicObjectImpl::MethodWithMultipleOutArgs)
		},

		{
			interfaceDescription->GetMember("MethodWithOnlyOutArgs"), static_cast<MessageReceiver::MethodHandler>(&BasicObjectImpl::MethodWithOnlyOutArgs)
		},

		{
			interfaceDescription->GetMember("MethodWithNoReturnAndNoArgs"), static_cast<MessageReceiver::MethodHandler>(&BasicObjectImpl::MethodWithNoReturnAndNoArgs)
		},

		{
			interfaceDescription->GetMember("MethodWithReturnAndNoInArgs"), static_cast<MessageReceiver::MethodHandler>(&BasicObjectImpl::MethodWithReturnAndNoInArgs)
		},

		{
			interfaceDescription->GetMember("MethodWithComplexTypesForArgs"), static_cast<MessageReceiver::MethodHandler>(&BasicObjectImpl::MethodWithComplexTypesForArgs)
		},

		{
			interfaceDescription->GetMember("MethodWithBoolInAndReturnArg"), static_cast<MessageReceiver::MethodHandler>(&BasicObjectImpl::MethodWithBoolInAndReturnArg)
		}

    };

    status = AddMethodHandlers(methodEntriesForBasicStringsDelegate, sizeof(methodEntriesForBasicStringsDelegate) / sizeof(methodEntriesForBasicStringsDelegate[0]));
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred while adding method handlers for interface org.alljoyn.bus.sample.strings to the interface description. %@", [AJNStatus descriptionForStatusCode:status]);
    }

    // save off signal members for later
    //
    TestStringPropertyChangedSignalMember = interfaceDescription->GetMember("TestStringPropertyChanged");
    assert(TestStringPropertyChangedSignalMember);

TestSignalWithComplexArgsSignalMember = interfaceDescription->GetMember("TestSignalWithComplexArgs");
    assert(TestSignalWithComplexArgsSignalMember);

TestSignalWithNoArgsSignalMember = interfaceDescription->GetMember("TestSignalWithNoArgs");
    assert(TestSignalWithNoArgsSignalMember);


    // Add the org.alljoyn.bus.samples.chat interface to this object
    //
    interfaceDescription = bus.GetInterface("org.alljoyn.bus.samples.chat");
    assert(interfaceDescription);
    status = AddInterface(*interfaceDescription);
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred while adding the interface org.alljoyn.bus.samples.chat.%@", [AJNStatus descriptionForStatusCode:status]);
    }

    // save off signal members for later
    //
    ChatSignalMember = interfaceDescription->GetMember("Chat");
    assert(ChatSignalMember);

    return status;
}


QStatus BasicObjectImpl::Get(const char* ifcName, const char* propName, MsgArg& val)
{
    QStatus status = ER_BUS_NO_SUCH_PROPERTY;

    @autoreleasepool {

    if (strcmp(ifcName, "org.alljoyn.bus.sample.strings") == 0)
    {

        if (strcmp(propName, "testArrayProperty") == 0)
        {

            MsgArg *pPropertyValue = (MsgArg*)[((id<BasicStringsDelegate>)delegate).testArrayProperty msgArg];
            val = *pPropertyValue;
            status = ER_OK;

        }

        if (strcmp(propName, "testStringProperty") == 0)
        {

            status = val.Set( "s", [((id<BasicStringsDelegate>)delegate).testStringProperty UTF8String] );

        }

        if (strcmp(propName, "testBoolProperty") == 0)
        {

            status = val.Set( "b", ((id<BasicStringsDelegate>)delegate).testBoolProperty  );

        }

        if (strcmp(propName, "testStringOnlyReadProperty") == 0)
        {

            status = val.Set( "s", [((id<BasicStringsDelegate>)delegate).testStringOnlyReadProperty UTF8String] );

        }

    }
    else if (strcmp(ifcName, "org.alljoyn.bus.samples.chat") == 0)
    {

        if (strcmp(propName, "name") == 0)
        {

            status = val.Set( "s", [((id<BasicChatDelegate>)delegate).name UTF8String] );

        }

    }


    } //autoreleasepool

    return status;
}

QStatus BasicObjectImpl::Set(const char* ifcName, const char* propName, MsgArg& val)
{
    QStatus status = ER_BUS_NO_SUCH_PROPERTY;

    @autoreleasepool {

    if (strcmp(ifcName, "org.alljoyn.bus.sample.strings") == 0)
    {

        if (strcmp(propName, "testArrayProperty") == 0)
        {

            MsgArg *pPropertyValue = (MsgArg*)[((id<BasicStringsDelegate>)delegate).testArrayProperty msgArg];
            *pPropertyValue = val;
            status = ER_OK;

        }

        if (strcmp(propName, "testStringProperty") == 0)
        {
        char * propValue;
            status = val.Get("s", &propValue);
            ((id<BasicStringsDelegate>)delegate).testStringProperty = [NSString stringWithCString:propValue encoding:NSUTF8StringEncoding];

        }

        if (strcmp(propName, "testBoolProperty") == 0)
        {
        bool propValue;
            status = val.Get("b", &propValue);
            ((id<BasicStringsDelegate>)delegate).testBoolProperty = propValue;

        }

        if (strcmp(propName, "testStringOnlyWriteProperty") == 0)
        {
        char * propValue;
            status = val.Get("s", &propValue);
            ((id<BasicStringsDelegate>)delegate).testStringOnlyWriteProperty = [NSString stringWithCString:propValue encoding:NSUTF8StringEncoding];

        }

    }


    } //autoreleasepool

    return status;
}

void BasicObjectImpl::Concatentate(const InterfaceDescription::Member *member, Message& msg)
{
    @autoreleasepool {



    // get all input arguments
    //

    qcc::String inArg0 = msg->GetArg(0)->v_string.str;

    qcc::String inArg1 = msg->GetArg(1)->v_string.str;

    // declare the output arguments
    //

	NSString * outArg0;


    // call the Objective-C delegate method
    //

	[(id<BasicStringsDelegate>)delegate concatenateString:[NSString stringWithCString:inArg0.c_str() encoding:NSUTF8StringEncoding] withString:[NSString stringWithCString:inArg1.c_str() encoding:NSUTF8StringEncoding] outString:&outArg0  message:[[AJNMessage alloc] initWithHandle:&msg]];


    // formulate the reply
    //
    MsgArg outArgs[1];

    outArgs[0].Set("s", [outArg0 UTF8String]);

    QStatus status = MethodReply(msg, outArgs, 1);
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred when attempting to send a method reply for Concatentate. %@", [AJNStatus descriptionForStatusCode:status]);
    }


    } //autoreleasepool
}

void BasicObjectImpl::MethodWithOneInAndMultipleOutArgs(const InterfaceDescription::Member *member, Message& msg)
{
    @autoreleasepool {



    // get all input arguments
    //

    qcc::String inArg0 = msg->GetArg(0)->v_string.str;

    // declare the output arguments
    //

	NSString * outArg0;
	NSString * outArg1;


    // call the Objective-C delegate method
    //

	[(id<BasicStringsDelegate>)delegate methodWithInString:[NSString stringWithCString:inArg0.c_str() encoding:NSUTF8StringEncoding] outString1:&outArg0 outString2:&outArg1  message:[[AJNMessage alloc] initWithHandle:&msg]];


    // formulate the reply
    //
    MsgArg outArgs[2];

    outArgs[0].Set("s", [outArg0 UTF8String]);

    outArgs[1].Set("s", [outArg1 UTF8String]);

    QStatus status = MethodReply(msg, outArgs, 2);
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred when attempting to send a method reply for MethodWithOneInAndMultipleOutArgs. %@", [AJNStatus descriptionForStatusCode:status]);
    }


    } //autoreleasepool
}

void BasicObjectImpl::MethodWithMultipleOutArgs(const InterfaceDescription::Member *member, Message& msg)
{
    @autoreleasepool {



    // get all input arguments
    //

    qcc::String inArg0 = msg->GetArg(0)->v_string.str;

    qcc::String inArg1 = msg->GetArg(1)->v_string.str;

    // declare the output arguments
    //

	NSString * outArg0;
	NSString * outArg1;


    // call the Objective-C delegate method
    //

	[(id<BasicStringsDelegate>)delegate methodWithOutString:[NSString stringWithCString:inArg0.c_str() encoding:NSUTF8StringEncoding] inString2:[NSString stringWithCString:inArg1.c_str() encoding:NSUTF8StringEncoding] outString1:&outArg0 outString2:&outArg1  message:[[AJNMessage alloc] initWithHandle:&msg]];


    // formulate the reply
    //
    MsgArg outArgs[2];

    outArgs[0].Set("s", [outArg0 UTF8String]);

    outArgs[1].Set("s", [outArg1 UTF8String]);

    QStatus status = MethodReply(msg, outArgs, 2);
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred when attempting to send a method reply for MethodWithMultipleOutArgs. %@", [AJNStatus descriptionForStatusCode:status]);
    }


    } //autoreleasepool
}

void BasicObjectImpl::MethodWithOnlyOutArgs(const InterfaceDescription::Member *member, Message& msg)
{
    @autoreleasepool {


    // declare the output arguments
    //

	NSString * outArg0;
	BOOL outArg1;


    // call the Objective-C delegate method
    //

	[(id<BasicStringsDelegate>)delegate methodWithOnlyOutString:&outArg0 outBool:&outArg1  message:[[AJNMessage alloc] initWithHandle:&msg]];


    // formulate the reply
    //
    MsgArg outArgs[2];

    outArgs[0].Set("s", [outArg0 UTF8String]);

    outArgs[1].Set("b", outArg1 );

    QStatus status = MethodReply(msg, outArgs, 2);
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred when attempting to send a method reply for MethodWithOnlyOutArgs. %@", [AJNStatus descriptionForStatusCode:status]);
    }


    } //autoreleasepool
}

void BasicObjectImpl::MethodWithNoReturnAndNoArgs(const InterfaceDescription::Member *member, Message& msg)
{
    @autoreleasepool {



    // call the Objective-C delegate method
    //

	[(id<BasicStringsDelegate>)delegate methodWithNoReturnAndNoArgs:[[AJNMessage alloc] initWithHandle:&msg]];

    // formulate the reply
    //
    MsgArg outArgs[0];
    QStatus status = MethodReply(msg, outArgs, 0);
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred when attempting to send a method reply for MethodWithNoReturnAndNoArgs. %@", [AJNStatus descriptionForStatusCode:status]);
    }


    } //autoreleasepool
}

void BasicObjectImpl::MethodWithReturnAndNoInArgs(const InterfaceDescription::Member *member, Message& msg)
{
    @autoreleasepool {


    // declare the output arguments
    //

	NSString * outArg0;


    // call the Objective-C delegate method
    //

	[(id<BasicStringsDelegate>)delegate methodWithReturnAndNoInArgs:&outArg0  message:[[AJNMessage alloc] initWithHandle:&msg]];


    // formulate the reply
    //
    MsgArg outArgs[1];

    outArgs[0].Set("s", [outArg0 UTF8String]);

    QStatus status = MethodReply(msg, outArgs, 1);
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred when attempting to send a method reply for MethodWithReturnAndNoInArgs. %@", [AJNStatus descriptionForStatusCode:status]);
    }


    } //autoreleasepool
}

void BasicObjectImpl::MethodWithComplexTypesForArgs(const InterfaceDescription::Member *member, Message& msg)
{
    @autoreleasepool {



    // get all input arguments
    //

    AJNMessageArgument* inArg0 = [[AJNMessageArgument alloc] initWithHandle:(AJNHandle)new MsgArg(*(msg->GetArg(0))) shouldDeleteHandleOnDealloc:YES];

    AJNMessageArgument* inArg1 = [[AJNMessageArgument alloc] initWithHandle:(AJNHandle)new MsgArg(*(msg->GetArg(1))) shouldDeleteHandleOnDealloc:YES];

    // declare the output arguments
    //

	NSString * outArg0;


    // call the Objective-C delegate method
    //

	[(id<BasicStringsDelegate>)delegate methodWithStringArray:inArg0 structWithStringAndInt:inArg1 outStr:&outArg0  message:[[AJNMessage alloc] initWithHandle:&msg]];


    // formulate the reply
    //
    MsgArg outArgs[1];

    outArgs[0].Set("s", [outArg0 UTF8String]);

    QStatus status = MethodReply(msg, outArgs, 1);
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred when attempting to send a method reply for MethodWithComplexTypesForArgs. %@", [AJNStatus descriptionForStatusCode:status]);
    }


    } //autoreleasepool
}

void BasicObjectImpl::MethodWithBoolInAndReturnArg(const InterfaceDescription::Member *member, Message& msg)
{
    @autoreleasepool {



    // get all input arguments
    //

    bool inArg0 = msg->GetArg(0)->v_bool;

    // declare the output arguments
    //

	NSString * outArg0;


    // call the Objective-C delegate method
    //

	[(id<BasicStringsDelegate>)delegate methodWithBoolIn:(inArg0 ? YES : NO) outStr:&outArg0  message:[[AJNMessage alloc] initWithHandle:&msg]];


    // formulate the reply
    //
    MsgArg outArgs[1];

    outArgs[0].Set("s", [outArg0 UTF8String]);

    QStatus status = MethodReply(msg, outArgs, 1);
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred when attempting to send a method reply for MethodWithBoolInAndReturnArg. %@", [AJNStatus descriptionForStatusCode:status]);
    }


    } //autoreleasepool
}

QStatus BasicObjectImpl::SendTestStringPropertyChanged(const char * oldString,const char * newString, const char* destination, SessionId sessionId, uint16_t timeToLive, uint8_t flags)
{

    MsgArg args[2];


            args[0].Set( "s", oldString );

            args[1].Set( "s", newString );


    return Signal(destination, sessionId, *TestStringPropertyChangedSignalMember, args, 2, timeToLive, flags);
}


QStatus BasicObjectImpl::SendTestSignalWithComplexArgs(MsgArg* oldString, const char* destination, SessionId sessionId, uint16_t timeToLive, uint8_t flags)
{

    MsgArg args[1];

    args[0] = *oldString;

    return Signal(destination, sessionId, *TestSignalWithComplexArgsSignalMember, args, 1, timeToLive, flags);
}


QStatus BasicObjectImpl::SendTestSignalWithNoArgs( const char* destination, SessionId sessionId, uint16_t timeToLive, uint8_t flags)
{

    MsgArg args[0];



    return Signal(destination, sessionId, *TestSignalWithNoArgsSignalMember, args, 0, timeToLive, flags);
}


QStatus BasicObjectImpl::SendChat(const char * message, const char* destination, SessionId sessionId, uint16_t timeToLive, uint8_t flags)
{

    MsgArg args[1];


            args[0].Set( "s", message );


    return Signal(destination, sessionId, *ChatSignalMember, args, 1, timeToLive, flags);
}


////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  C++ Bus Object class declaration for PingObjectImpl
//
////////////////////////////////////////////////////////////////////////////////
class PingObjectImpl : public AJNBusObjectImpl
{
private:


public:
    PingObjectImpl(const char *path, id<PingObjectDelegate> aDelegate);
    PingObjectImpl(BusAttachment &bus, const char *path, id<PingObjectDelegate> aDelegate);

    virtual QStatus AddInterfacesAndHandlers(BusAttachment &bus);



    // methods
    //
    void Ping(const InterfaceDescription::Member* member, Message& msg);


    // signals
    //

};
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  C++ Bus Object implementation for PingObjectImpl
//
////////////////////////////////////////////////////////////////////////////////

PingObjectImpl::PingObjectImpl(const char *path, id<PingObjectDelegate> aDelegate) :
    AJNBusObjectImpl(path,aDelegate)
{
    // Intentionally empty
}

PingObjectImpl::PingObjectImpl(BusAttachment &bus, const char *path, id<PingObjectDelegate> aDelegate) :
    AJNBusObjectImpl(bus,path,aDelegate)
{
    AddInterfacesAndHandlers(bus);
}

QStatus PingObjectImpl::AddInterfacesAndHandlers(BusAttachment &bus)
{
    const InterfaceDescription* interfaceDescription = NULL;
    QStatus status = ER_OK;


    // Add the org.alljoyn.bus.samples.ping interface to this object
    //
    interfaceDescription = bus.GetInterface("org.alljoyn.bus.samples.ping");
    assert(interfaceDescription);
    status = AddInterface(*interfaceDescription);
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred while adding the interface org.alljoyn.bus.samples.ping.%@", [AJNStatus descriptionForStatusCode:status]);
    }

    // Register the method handlers for interface PingObjectDelegate with the object
    //
    const MethodEntry methodEntriesForPingObjectDelegate[] = {

        {
			interfaceDescription->GetMember("Ping"), static_cast<MessageReceiver::MethodHandler>(&PingObjectImpl::Ping)
		}

    };

    status = AddMethodHandlers(methodEntriesForPingObjectDelegate, sizeof(methodEntriesForPingObjectDelegate) / sizeof(methodEntriesForPingObjectDelegate[0]));
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred while adding method handlers for interface org.alljoyn.bus.samples.ping to the interface description. %@", [AJNStatus descriptionForStatusCode:status]);
    }

    return status;
}


void PingObjectImpl::Ping(const InterfaceDescription::Member *member, Message& msg)
{
    @autoreleasepool {



    // get all input arguments
    //

    uint8_t inArg0 = msg->GetArg(0)->v_byte;


    // call the Objective-C delegate method
    //

	[(id<PingObjectDelegate>)delegate pingWithValue:[NSNumber numberWithUnsignedChar:inArg0]  message:[[AJNMessage alloc] initWithHandle:&msg]];

    // formulate the reply
    //
    MsgArg outArgs[0];
    QStatus status = MethodReply(msg, outArgs, 0);
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred when attempting to send a method reply for Ping. %@", [AJNStatus descriptionForStatusCode:status]);
    }


    } //autoreleasepool
}

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  Objective-C Bus Object implementation for AJNBasicObject
//
////////////////////////////////////////////////////////////////////////////////

@interface AJNBasicObject()
/**
* The bus attachment this object is associated with.
*/
@property (nonatomic, weak) AJNBusAttachment *bus;

@end

@implementation AJNBasicObject

@dynamic handle;
@synthesize bus = _bus;

@synthesize testArrayProperty = _testArrayProperty;
@synthesize testStringProperty = _testStringProperty;
@synthesize testBoolProperty = _testBoolProperty;
@synthesize testStringOnlyReadProperty = _testStringOnlyReadProperty;
@synthesize testStringOnlyWriteProperty = _testStringOnlyWriteProperty;
@synthesize name = _name;


- (BasicObjectImpl*)busObject
{
    return static_cast<BasicObjectImpl*>(self.handle);
}

- (QStatus)registerInterfacesWithBus:(AJNBusAttachment *)busAttachment
{
    QStatus status = [self activateInterfacesWithBus: busAttachment];

    self.busObject->AddInterfacesAndHandlers(*((ajn::BusAttachment*)busAttachment.handle));

    return status;
}

- (QStatus)activateInterfacesWithBus:(AJNBusAttachment *)busAttachment
{
    QStatus status = ER_OK;

    AJNInterfaceDescription *interfaceDescription;

    //
    // BasicStringsDelegate interface (org.alljoyn.bus.sample.strings)
    //
    // create an interface description, or if that fails, get the interface as it was already created
    //
    interfaceDescription = [busAttachment createInterfaceWithName:@"org.alljoyn.bus.sample.strings" enableSecurity:NO];

    // add the properties to the interface description
    //

    status = [interfaceDescription addPropertyWithName:@"testArrayProperty" signature:@"a(ssssssis)" accessPermissions:kAJNInterfacePropertyAccessReadWriteFlag];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add property to interface: testArrayProperty" userInfo:nil];
    }

    status = [interfaceDescription addPropertyWithName:@"testStringProperty" signature:@"s" accessPermissions:kAJNInterfacePropertyAccessReadWriteFlag];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add property to interface: testStringProperty" userInfo:nil];
    }

    status = [interfaceDescription addPropertyWithName:@"testBoolProperty" signature:@"b" accessPermissions:kAJNInterfacePropertyAccessReadWriteFlag];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add property to interface: testBoolProperty" userInfo:nil];
    }

    status = [interfaceDescription addPropertyWithName:@"testStringOnlyReadProperty" signature:@"s" accessPermissions:kAJNInterfacePropertyAccessReadFlag];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add property to interface: testStringOnlyReadProperty" userInfo:nil];
    }

    status = [interfaceDescription addPropertyWithName:@"testStringOnlyWriteProperty" signature:@"s" accessPermissions:kAJNInterfacePropertyAccessWriteFlag];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add property to interface: testStringOnlyWriteProperty" userInfo:nil];
    }

    // add the methods to the interface description
    //

    status = [interfaceDescription addMethodWithName:@"Concatentate" inputSignature:@"ss" outputSignature:@"s" argumentNames:[NSArray arrayWithObjects:@"str1", @"str2", @"outStr", nil]];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add method to interface: Concatentate" userInfo:nil];
    }

    status = [interfaceDescription addMethodWithName:@"MethodWithOneInAndMultipleOutArgs" inputSignature:@"s" outputSignature:@"ss" argumentNames:[NSArray arrayWithObjects:@"str", @"outStr1", @"outStr2", nil]];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add method to interface: MethodWithOneInAndMultipleOutArgs" userInfo:nil];
    }

    status = [interfaceDescription addMethodWithName:@"MethodWithMultipleOutArgs" inputSignature:@"ss" outputSignature:@"ss" argumentNames:[NSArray arrayWithObjects:@"str1", @"str2", @"outStr1", @"outStr2", nil]];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add method to interface: MethodWithMultipleOutArgs" userInfo:nil];
    }

    status = [interfaceDescription addMethodWithName:@"MethodWithOnlyOutArgs" inputSignature:@"" outputSignature:@"sb" argumentNames:[NSArray arrayWithObjects:@"outStr", @"outBool", nil]];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add method to interface: MethodWithOnlyOutArgs" userInfo:nil];
    }

    status = [interfaceDescription addMethodWithName:@"MethodWithNoReturnAndNoArgs" inputSignature:@"" outputSignature:@"" argumentNames:[NSArray array]];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add method to interface: MethodWithNoReturnAndNoArgs" userInfo:nil];
    }

    status = [interfaceDescription addMethodWithName:@"MethodWithReturnAndNoInArgs" inputSignature:@"" outputSignature:@"s" argumentNames:[NSArray arrayWithObjects:@"outStr", nil]];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add method to interface: MethodWithReturnAndNoInArgs" userInfo:nil];
    }

    status = [interfaceDescription addMethodWithName:@"MethodWithComplexTypesForArgs" inputSignature:@"as(si)" outputSignature:@"s" argumentNames:[NSArray arrayWithObjects:@"stringArray", @"aStruct", @"outStr", nil]];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add method to interface: MethodWithComplexTypesForArgs" userInfo:nil];
    }

    status = [interfaceDescription addMethodWithName:@"MethodWithBoolInAndReturnArg" inputSignature:@"b" outputSignature:@"s" argumentNames:[NSArray arrayWithObjects:@"inBool", @"outStr", nil]];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add method to interface: MethodWithBoolInAndReturnArg" userInfo:nil];
    }

    // add the signals to the interface description
    //

    status = [interfaceDescription addSignalWithName:@"TestStringPropertyChanged" inputSignature:@"ss" argumentNames:[NSArray arrayWithObjects:@"oldString", @"newString", nil]];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add signal to interface:  TestStringPropertyChanged" userInfo:nil];
    }

    status = [interfaceDescription addSignalWithName:@"TestSignalWithComplexArgs" inputSignature:@"as" argumentNames:[NSArray arrayWithObjects:@"oldString", nil]];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add signal to interface:  TestSignalWithComplexArgs" userInfo:nil];
    }

    status = [interfaceDescription addSignalWithName:@"TestSignalWithNoArgs" inputSignature:@"" argumentNames:[NSArray array]];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add signal to interface:  TestSignalWithNoArgs" userInfo:nil];
    }


    [interfaceDescription activate];

    //
    // BasicChatDelegate interface (org.alljoyn.bus.samples.chat)
    //
    // create an interface description, or if that fails, get the interface as it was already created
    //
    interfaceDescription = [busAttachment createInterfaceWithName:@"org.alljoyn.bus.samples.chat" enableSecurity:NO];

    // add the properties to the interface description
    //

    status = [interfaceDescription addPropertyWithName:@"name" signature:@"s" accessPermissions:kAJNInterfacePropertyAccessReadFlag];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add property to interface: name" userInfo:nil];
    }

    // add the signals to the interface description
    //

    status = [interfaceDescription addSignalWithName:@"Chat" inputSignature:@"s" argumentNames:[NSArray arrayWithObjects:@"message", nil]];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add signal to interface:  Chat" userInfo:nil];
    }


    [interfaceDescription activate];


    self.bus = busAttachment;

    return status;
}

- (id)initWithPath:(NSString *)path
{
    self = [super initWithPath:path];
    if (self) {
    // create the internal C++ bus object
    //
        BasicObjectImpl *busObject = new BasicObjectImpl([path UTF8String],(id<BasicStringsDelegate, BasicChatDelegate>)self);
        self.handle = busObject;
    }
    return self;
}

- (id)initWithBusAttachment:(AJNBusAttachment *)busAttachment onPath:(NSString *)path
{
    self = [super initWithBusAttachment:busAttachment onPath:path];
    if (self) {
        [self activateInterfacesWithBus:busAttachment];

        // create the internal C++ bus object
        //
        BasicObjectImpl *busObject = new BasicObjectImpl(*((ajn::BusAttachment*)busAttachment.handle), [path UTF8String], (id<BasicStringsDelegate, BasicChatDelegate>)self);

        self.handle = busObject;


    }
    return self;
}

- (void)dealloc
{
    BasicObjectImpl *busObject = [self busObject];
    delete busObject;
    self.handle = nil;
}


- (QStatus)concatenateString:(NSString *)str1 withString:(NSString *)str2 outString:(NSString **)outStr message:(AJNMessage *)methodCallMessage;

{
    //
    // GENERATED CODE - DO NOT EDIT
    //
    // Create a category or subclass in separate .h/.m files
    @throw([NSException exceptionWithName:@"NotImplementedException" reason:@"You must override this method in a subclass" userInfo:nil]);
}

- (QStatus)methodWithInString:(NSString *)str outString1:(NSString **)outStr1 outString2:(NSString **)outStr2 message:(AJNMessage *)methodCallMessage;

{
    //
    // GENERATED CODE - DO NOT EDIT
    //
    // Create a category or subclass in separate .h/.m files
    @throw([NSException exceptionWithName:@"NotImplementedException" reason:@"You must override this method in a subclass" userInfo:nil]);
}

- (QStatus)methodWithOutString:(NSString *)str1 inString2:(NSString *)str2 outString1:(NSString **)outStr1 outString2:(NSString **)outStr2 message:(AJNMessage *)methodCallMessage;

{
    //
    // GENERATED CODE - DO NOT EDIT
    //
    // Create a category or subclass in separate .h/.m files
    @throw([NSException exceptionWithName:@"NotImplementedException" reason:@"You must override this method in a subclass" userInfo:nil]);
}

- (QStatus) methodWithOnlyOutString:(NSString **)outStr outBool:(BOOL*)outBool message:(AJNMessage *)methodCallMessage;

{
    //
    // GENERATED CODE - DO NOT EDIT
    //
    // Create a category or subclass in separate .h/.m files
    @throw([NSException exceptionWithName:@"NotImplementedException" reason:@"You must override this method in a subclass" userInfo:nil]);
}

- (QStatus)methodWithNoReturnAndNoArgs:(AJNMessage *)methodCallMessage;

{
    //
    // GENERATED CODE - DO NOT EDIT
    //
    // Create a category or subclass in separate .h/.m files
    @throw([NSException exceptionWithName:@"NotImplementedException" reason:@"You must override this method in a subclass" userInfo:nil]);
}

- (QStatus) methodWithReturnAndNoInArgs:(NSString **)outStr message:(AJNMessage *)methodCallMessage;

{
    //
    // GENERATED CODE - DO NOT EDIT
    //
    // Create a category or subclass in separate .h/.m files
    @throw([NSException exceptionWithName:@"NotImplementedException" reason:@"You must override this method in a subclass" userInfo:nil]);
}

- (QStatus)methodWithStringArray:(AJNMessageArgument *)stringArray structWithStringAndInt:(AJNMessageArgument *)aStruct outStr:(NSString **)outStr message:(AJNMessage *)methodCallMessage;

{
    //
    // GENERATED CODE - DO NOT EDIT
    //
    // Create a category or subclass in separate .h/.m files
    @throw([NSException exceptionWithName:@"NotImplementedException" reason:@"You must override this method in a subclass" userInfo:nil]);
}

- (QStatus)methodWithBoolIn:(BOOL)inBool outStr:(NSString **)outStr message:(AJNMessage *)methodCallMessage;

{
    //
    // GENERATED CODE - DO NOT EDIT
    //
    // Create a category or subclass in separate .h/.m files
    @throw([NSException exceptionWithName:@"NotImplementedException" reason:@"You must override this method in a subclass" userInfo:nil]);
}
- (QStatus)sendTestStringPropertyChangedFrom:(NSString *)oldString to:(NSString *)newString inSession:(AJNSessionId)sessionId toDestination:(NSString *)destinationPath

{

    return self.busObject->SendTestStringPropertyChanged([oldString UTF8String], [newString UTF8String], [destinationPath UTF8String], sessionId);

}
- (QStatus)sendTestSignalWithComplexArgs:(AJNMessageArgument *)oldString inSession:(AJNSessionId)sessionId toDestination:(NSString *)destinationPath

{

    return self.busObject->SendTestSignalWithComplexArgs([oldString msgArg], [destinationPath UTF8String], sessionId);

}
- (QStatus)sendTestSignalWithNoArgsInSession:(AJNSessionId)sessionId toDestination:(NSString *)destinationPath

{

    return self.busObject->SendTestSignalWithNoArgs([destinationPath UTF8String], sessionId);

}
- (QStatus)sendMessage:(NSString *)message inSession:(AJNSessionId)sessionId toDestination:(NSString *)destinationPath

{

    return self.busObject->SendChat([message UTF8String], [destinationPath UTF8String], sessionId);

}


@end

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  Objective-C Proxy Bus Object implementation for BasicObject
//
////////////////////////////////////////////////////////////////////////////////

@interface BasicObjectProxy(Private)

@property (nonatomic, strong) AJNBusAttachment *bus;

- (ProxyBusObject*)proxyBusObject;

@end

@implementation BasicObjectProxy

- (QStatus)getTestArrayProperty:(AJNMessageArgument **)prop
{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];


    MsgArg *propValue = new MsgArg();

    QStatus status = self.proxyBusObject->GetProperty("org.alljoyn.bus.sample.strings", "testArrayProperty", *propValue);

    if (status != ER_OK) {
        NSLog(@"ERROR: Failed to get property testArrayProperty on interface org.alljoyn.bus.sample.strings. %@", [AJNStatus descriptionForStatusCode:status]);
        *prop = nil;
    } else {
        *prop = [[AJNMessageArgument alloc] initWithHandle:propValue shouldDeleteHandleOnDealloc:YES];
    }
    return status;

}

- (QStatus)setTestArrayProperty:(AJNMessageArgument *)propertyValue
{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];
    QStatus status;

    status = self.proxyBusObject->SetProperty("org.alljoyn.bus.sample.strings", "testArrayProperty", *(MsgArg*)(propertyValue.handle));

    return status;
}

- (QStatus)getTestStringProperty:(NSString **)prop
{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];


    MsgArg propValue;

    QStatus status = self.proxyBusObject->GetProperty("org.alljoyn.bus.sample.strings", "testStringProperty", propValue);

    if (status != ER_OK) {
        NSLog(@"ERROR: Failed to get property testStringProperty on interface org.alljoyn.bus.sample.strings. %@", [AJNStatus descriptionForStatusCode:status]);

        *prop = nil;

    } else {

    *prop = [NSString stringWithCString:propValue.v_variant.val->v_string.str encoding:NSUTF8StringEncoding];

    }
    return status;

}

- (QStatus)setTestStringProperty:(NSString *)propertyValue
{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];
    QStatus status;

    MsgArg arg;

    status = arg.Set("s", [propertyValue UTF8String]);
    if (status != ER_OK) {
        NSLog(@"ERROR: Failed to set property testStringProperty on interface org.alljoyn.bus.sample.strings. %@", [AJNStatus descriptionForStatusCode:status]);
        return status;
    }

    status = self.proxyBusObject->SetProperty("org.alljoyn.bus.sample.strings", "testStringProperty", arg);

    return status;
}

- (QStatus)getTestBoolProperty:(BOOL*)prop
{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];


    MsgArg propValue;

    QStatus status = self.proxyBusObject->GetProperty("org.alljoyn.bus.sample.strings", "testBoolProperty", propValue);

    if (status != ER_OK) {
        NSLog(@"ERROR: Failed to get property testBoolProperty on interface org.alljoyn.bus.sample.strings. %@", [AJNStatus descriptionForStatusCode:status]);

        *prop = NO;

    } else {

    *prop = propValue.v_variant.val->v_bool;

    }
    return status;

}

- (QStatus)setTestBoolProperty:(BOOL)propertyValue
{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];
    QStatus status;

    MsgArg arg;

    status = arg.Set("b", propertyValue);
    if (status != ER_OK) {
        NSLog(@"ERROR: Failed to set property testBoolProperty on interface org.alljoyn.bus.sample.strings. %@", [AJNStatus descriptionForStatusCode:status]);
        return status;
    }

    status = self.proxyBusObject->SetProperty("org.alljoyn.bus.sample.strings", "testBoolProperty", arg);

    return status;
}

- (QStatus)getTestStringOnlyReadProperty:(NSString **)prop
{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];


    MsgArg propValue;

    QStatus status = self.proxyBusObject->GetProperty("org.alljoyn.bus.sample.strings", "testStringOnlyReadProperty", propValue);

    if (status != ER_OK) {
        NSLog(@"ERROR: Failed to get property testStringOnlyReadProperty on interface org.alljoyn.bus.sample.strings. %@", [AJNStatus descriptionForStatusCode:status]);

        *prop = nil;

    } else {

    *prop = [NSString stringWithCString:propValue.v_variant.val->v_string.str encoding:NSUTF8StringEncoding];

    }
    return status;

}

- (QStatus)setTestStringOnlyWriteProperty:(NSString *)propertyValue
{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];
    QStatus status;

    MsgArg arg;

    status = arg.Set("s", [propertyValue UTF8String]);
    if (status != ER_OK) {
        NSLog(@"ERROR: Failed to set property testStringOnlyWriteProperty on interface org.alljoyn.bus.sample.strings. %@", [AJNStatus descriptionForStatusCode:status]);
        return status;
    }

    status = self.proxyBusObject->SetProperty("org.alljoyn.bus.sample.strings", "testStringOnlyWriteProperty", arg);

    return status;
}

- (QStatus)getName:(NSString **)prop
{
    [self addInterfaceNamed:@"org.alljoyn.bus.samples.chat"];


    MsgArg propValue;

    QStatus status = self.proxyBusObject->GetProperty("org.alljoyn.bus.samples.chat", "name", propValue);

    if (status != ER_OK) {
        NSLog(@"ERROR: Failed to get property name on interface org.alljoyn.bus.samples.chat. %@", [AJNStatus descriptionForStatusCode:status]);

        *prop = nil;

    } else {

    *prop = [NSString stringWithCString:propValue.v_variant.val->v_string.str encoding:NSUTF8StringEncoding];

    }
    return status;

}

- (QStatus)concatenateString:(NSString *)str1 withString:(NSString *)str2 outString:(NSString **)outStr

{
    QStatus status;
    status = [self concatenateString:str1 withString:str2 outString:outStr replyMessage:nil];
    return status;
}

- (QStatus)concatenateString:(NSString *)str1 withString:(NSString *)str2 outString:(NSString **)outStr replyMessage:(AJNMessage **)replyMessage

{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];

    // prepare the input arguments
    //

    Message reply(*((BusAttachment*)self.bus.handle));
    MsgArg inArgs[2];

    inArgs[0].Set("s", [str1 UTF8String]);

    inArgs[1].Set("s", [str2 UTF8String]);


    // make the function call using the C++ proxy object
    //

    QStatus status = self.proxyBusObject->MethodCall("org.alljoyn.bus.sample.strings", "Concatentate", inArgs, 2, reply, 5000);
    if (ER_OK != status) {
        NSLog(@"ERROR: ProxyBusObject::MethodCall on org.alljoyn.bus.sample.strings failed. %@", [AJNStatus descriptionForStatusCode:status]);

        // pass nil as output arguments in case of an error
        //
        *outStr = nil;

    } else {

        // pass the output arguments back to the caller
        //

        *outStr = [NSString stringWithCString:reply->GetArg(0)->v_string.str encoding:NSUTF8StringEncoding];

    }

    if (replyMessage != nil) {
        *replyMessage = [[AJNMessage alloc] initWithHandle:new Message(reply)];
        }
    return status;
}

- (QStatus)methodWithInString:(NSString *)str outString1:(NSString **)outStr1 outString2:(NSString **)outStr2

{
    QStatus status;
    status = [self methodWithInString:str outString1:outStr1 outString2:outStr2 replyMessage:nil];
    return status;
}

- (QStatus)methodWithInString:(NSString *)str outString1:(NSString **)outStr1 outString2:(NSString **)outStr2 replyMessage:(AJNMessage **)replyMessage

{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];

    // prepare the input arguments
    //

    Message reply(*((BusAttachment*)self.bus.handle));
    MsgArg inArgs[1];

    inArgs[0].Set("s", [str UTF8String]);


    // make the function call using the C++ proxy object
    //

    QStatus status = self.proxyBusObject->MethodCall("org.alljoyn.bus.sample.strings", "MethodWithOneInAndMultipleOutArgs", inArgs, 1, reply, 5000);
    if (ER_OK != status) {
        NSLog(@"ERROR: ProxyBusObject::MethodCall on org.alljoyn.bus.sample.strings failed. %@", [AJNStatus descriptionForStatusCode:status]);

        // pass nil as output arguments in case of an error
        //
        *outStr1 = nil;
        *outStr2 = nil;

    } else {

        // pass the output arguments back to the caller
        //

        *outStr1 = [NSString stringWithCString:reply->GetArg(0)->v_string.str encoding:NSUTF8StringEncoding];

        *outStr2 = [NSString stringWithCString:reply->GetArg(1)->v_string.str encoding:NSUTF8StringEncoding];

    }

    if (replyMessage != nil) {
        *replyMessage = [[AJNMessage alloc] initWithHandle:new Message(reply)];
        }
    return status;
}

- (QStatus)methodWithOutString:(NSString *)str1 inString2:(NSString *)str2 outString1:(NSString **)outStr1 outString2:(NSString **)outStr2

{
    QStatus status;
    status = [self methodWithOutString:str1 inString2:str2 outString1:outStr1 outString2:outStr2 replyMessage:nil];
    return status;
}

- (QStatus)methodWithOutString:(NSString *)str1 inString2:(NSString *)str2 outString1:(NSString **)outStr1 outString2:(NSString **)outStr2 replyMessage:(AJNMessage **)replyMessage

{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];

    // prepare the input arguments
    //

    Message reply(*((BusAttachment*)self.bus.handle));
    MsgArg inArgs[2];

    inArgs[0].Set("s", [str1 UTF8String]);

    inArgs[1].Set("s", [str2 UTF8String]);


    // make the function call using the C++ proxy object
    //

    QStatus status = self.proxyBusObject->MethodCall("org.alljoyn.bus.sample.strings", "MethodWithMultipleOutArgs", inArgs, 2, reply, 5000);
    if (ER_OK != status) {
        NSLog(@"ERROR: ProxyBusObject::MethodCall on org.alljoyn.bus.sample.strings failed. %@", [AJNStatus descriptionForStatusCode:status]);

        // pass nil as output arguments in case of an error
        //
        *outStr1 = nil;
        *outStr2 = nil;

    } else {

        // pass the output arguments back to the caller
        //

        *outStr1 = [NSString stringWithCString:reply->GetArg(0)->v_string.str encoding:NSUTF8StringEncoding];

        *outStr2 = [NSString stringWithCString:reply->GetArg(1)->v_string.str encoding:NSUTF8StringEncoding];

    }

    if (replyMessage != nil) {
        *replyMessage = [[AJNMessage alloc] initWithHandle:new Message(reply)];
        }
    return status;
}

- (QStatus) methodWithOnlyOutString:(NSString **)outStr outBool:(BOOL*)outBool

{
    QStatus status;
    status = [self  methodWithOnlyOutString:outStr outBool:outBool replyMessage:nil];
    return status;
}

- (QStatus) methodWithOnlyOutString:(NSString **)outStr outBool:(BOOL*)outBool replyMessage:(AJNMessage **)replyMessage

{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];

    // prepare the input arguments
    //

    Message reply(*((BusAttachment*)self.bus.handle));
    MsgArg inArgs[0];


    // make the function call using the C++ proxy object
    //

    QStatus status = self.proxyBusObject->MethodCall("org.alljoyn.bus.sample.strings", "MethodWithOnlyOutArgs", inArgs, 0, reply, 5000);
    if (ER_OK != status) {
        NSLog(@"ERROR: ProxyBusObject::MethodCall on org.alljoyn.bus.sample.strings failed. %@", [AJNStatus descriptionForStatusCode:status]);

        // pass nil as output arguments in case of an error
        //
        *outStr = nil;


    } else {

        // pass the output arguments back to the caller
        //

        *outStr = [NSString stringWithCString:reply->GetArg(0)->v_string.str encoding:NSUTF8StringEncoding];

        *outBool = reply->GetArg(1)->v_bool;

    }

    if (replyMessage != nil) {
        *replyMessage = [[AJNMessage alloc] initWithHandle:new Message(reply)];
        }
    return status;
}

- (QStatus)methodWithNoReturnAndNoArgs

{
    QStatus status;
    status = [self methodWithNoReturnAndNoArgs:nil];
    return status;
}

- (QStatus)methodWithNoReturnAndNoArgs:(AJNMessage **) replyMessage

{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];

    // prepare the input arguments
    //

    Message reply(*((BusAttachment*)self.bus.handle));
    MsgArg inArgs[0];


    // make the function call using the C++ proxy object
    //

    QStatus status = self.proxyBusObject->MethodCall("org.alljoyn.bus.sample.strings", "MethodWithNoReturnAndNoArgs", inArgs, 0, reply, 5000);
    if (ER_OK != status) {
        NSLog(@"ERROR: ProxyBusObject::MethodCall on org.alljoyn.bus.sample.strings failed. %@", [AJNStatus descriptionForStatusCode:status]);

    } else {

    }

    if (replyMessage != nil) {
        *replyMessage = [[AJNMessage alloc] initWithHandle:new Message(reply)];
        }
    return status;
}

- (QStatus) methodWithReturnAndNoInArgs:(NSString **)outStr

{
    QStatus status;
    status = [self  methodWithReturnAndNoInArgs:outStr replyMessage:nil];
    return status;
}

- (QStatus) methodWithReturnAndNoInArgs:(NSString **)outStr replyMessage:(AJNMessage **)replyMessage

{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];

    // prepare the input arguments
    //

    Message reply(*((BusAttachment*)self.bus.handle));
    MsgArg inArgs[0];


    // make the function call using the C++ proxy object
    //

    QStatus status = self.proxyBusObject->MethodCall("org.alljoyn.bus.sample.strings", "MethodWithReturnAndNoInArgs", inArgs, 0, reply, 5000);
    if (ER_OK != status) {
        NSLog(@"ERROR: ProxyBusObject::MethodCall on org.alljoyn.bus.sample.strings failed. %@", [AJNStatus descriptionForStatusCode:status]);

        // pass nil as output arguments in case of an error
        //
        *outStr = nil;

    } else {

        // pass the output arguments back to the caller
        //

        *outStr = [NSString stringWithCString:reply->GetArg(0)->v_string.str encoding:NSUTF8StringEncoding];

    }

    if (replyMessage != nil) {
        *replyMessage = [[AJNMessage alloc] initWithHandle:new Message(reply)];
        }
    return status;
}

- (QStatus)methodWithStringArray:(AJNMessageArgument *)stringArray structWithStringAndInt:(AJNMessageArgument *)aStruct outStr:(NSString **)outStr

{
    QStatus status;
    status = [self methodWithStringArray:stringArray structWithStringAndInt:aStruct outStr:outStr replyMessage:nil];
    return status;
}

- (QStatus)methodWithStringArray:(AJNMessageArgument *)stringArray structWithStringAndInt:(AJNMessageArgument *)aStruct outStr:(NSString **)outStr replyMessage:(AJNMessage **)replyMessage

{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];

    // prepare the input arguments
    //

    Message reply(*((BusAttachment*)self.bus.handle));
    MsgArg inArgs[2];

    inArgs[0] = *[stringArray msgArg];

    inArgs[1] = *[aStruct msgArg];


    // make the function call using the C++ proxy object
    //

    QStatus status = self.proxyBusObject->MethodCall("org.alljoyn.bus.sample.strings", "MethodWithComplexTypesForArgs", inArgs, 2, reply, 5000);
    if (ER_OK != status) {
        NSLog(@"ERROR: ProxyBusObject::MethodCall on org.alljoyn.bus.sample.strings failed. %@", [AJNStatus descriptionForStatusCode:status]);

        // pass nil as output arguments in case of an error
        //
        *outStr = nil;

    } else {

        // pass the output arguments back to the caller
        //

        *outStr = [NSString stringWithCString:reply->GetArg(0)->v_string.str encoding:NSUTF8StringEncoding];

    }

    if (replyMessage != nil) {
        *replyMessage = [[AJNMessage alloc] initWithHandle:new Message(reply)];
        }
    return status;
}

- (QStatus)methodWithBoolIn:(BOOL)inBool outStr:(NSString **)outStr

{
    QStatus status;
    status = [self methodWithBoolIn:inBool outStr:outStr replyMessage:nil];
    return status;
}

- (QStatus)methodWithBoolIn:(BOOL)inBool outStr:(NSString **)outStr replyMessage:(AJNMessage **)replyMessage

{
    [self addInterfaceNamed:@"org.alljoyn.bus.sample.strings"];

    // prepare the input arguments
    //

    Message reply(*((BusAttachment*)self.bus.handle));
    MsgArg inArgs[1];

    inArgs[0].Set("b", inBool);


    // make the function call using the C++ proxy object
    //

    QStatus status = self.proxyBusObject->MethodCall("org.alljoyn.bus.sample.strings", "MethodWithBoolInAndReturnArg", inArgs, 1, reply, 5000);
    if (ER_OK != status) {
        NSLog(@"ERROR: ProxyBusObject::MethodCall on org.alljoyn.bus.sample.strings failed. %@", [AJNStatus descriptionForStatusCode:status]);

        // pass nil as output arguments in case of an error
        //
        *outStr = nil;

    } else {

        // pass the output arguments back to the caller
        //

        *outStr = [NSString stringWithCString:reply->GetArg(0)->v_string.str encoding:NSUTF8StringEncoding];

    }

    if (replyMessage != nil) {
        *replyMessage = [[AJNMessage alloc] initWithHandle:new Message(reply)];
        }
    return status;
}

@end

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  Objective-C Bus Object implementation for AJNPingObject
//
////////////////////////////////////////////////////////////////////////////////

@interface AJNPingObject()
/**
* The bus attachment this object is associated with.
*/
@property (nonatomic, weak) AJNBusAttachment *bus;

@end

@implementation AJNPingObject

@dynamic handle;
@synthesize bus = _bus;



- (PingObjectImpl*)busObject
{
    return static_cast<PingObjectImpl*>(self.handle);
}

- (QStatus)registerInterfacesWithBus:(AJNBusAttachment *)busAttachment
{
    QStatus status = [self activateInterfacesWithBus: busAttachment];

    self.busObject->AddInterfacesAndHandlers(*((ajn::BusAttachment*)busAttachment.handle));

    return status;
}

- (QStatus)activateInterfacesWithBus:(AJNBusAttachment *)busAttachment
{
    QStatus status = ER_OK;

    AJNInterfaceDescription *interfaceDescription;


    //
    // PingObjectDelegate interface (org.alljoyn.bus.samples.ping)
    //
    // create an interface description, or if that fails, get the interface as it was already created
    //

    interfaceDescription = [busAttachment createInterfaceWithName:@"org.alljoyn.bus.samples.ping" withInterfaceSecPolicy:AJN_IFC_SECURITY_OFF];

    // add the methods to the interface description
    //

    status = [interfaceDescription addMethodWithName:@"Ping" inputSignature:@"y" outputSignature:@"" argumentNames:[NSArray arrayWithObjects:@"value", nil]];

    if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
        @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add method to interface: Ping" userInfo:nil];
    }


    [interfaceDescription activate];


    self.bus = busAttachment;

    return status;
}

- (id)initWithPath:(NSString *)path
{
    self = [super initWithPath:path];
    if (self) {
    // create the internal C++ bus object
    //
        PingObjectImpl *busObject = new PingObjectImpl([path UTF8String],(id<PingObjectDelegate>)self);
        self.handle = busObject;
    }
    return self;
}

- (id)initWithBusAttachment:(AJNBusAttachment *)busAttachment onPath:(NSString *)path
{
    self = [super initWithBusAttachment:busAttachment onPath:path];
    if (self) {
        [self activateInterfacesWithBus:busAttachment];

        // create the internal C++ bus object
        //
        PingObjectImpl *busObject = new PingObjectImpl(*((ajn::BusAttachment*)busAttachment.handle), [path UTF8String], (id<PingObjectDelegate>)self);

        self.handle = busObject;


    }
    return self;
}

- (void)dealloc
{
    PingObjectImpl *busObject = [self busObject];
    delete busObject;
    self.handle = nil;
}


- (QStatus)pingWithValue:(NSNumber *)value message:(AJNMessage *)methodCallMessage;

{
    //
    // GENERATED CODE - DO NOT EDIT
    //
    // Create a category or subclass in separate .h/.m files
    @throw([NSException exceptionWithName:@"NotImplementedException" reason:@"You must override this method in a subclass" userInfo:nil]);
}


@end

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  Objective-C Proxy Bus Object implementation for PingObject
//
////////////////////////////////////////////////////////////////////////////////

@interface PingObjectProxy(Private)

@property (nonatomic, strong) AJNBusAttachment *bus;

- (ProxyBusObject*)proxyBusObject;

@end

@implementation PingObjectProxy

- (QStatus)pingWithValue:(NSNumber *)value

{
    QStatus status;
    status = [self pingWithValue:value replyMessage:nil];
    return status;
}

- (QStatus)pingWithValue:(NSNumber *)value replyMessage:(AJNMessage **)replyMessage

{
    [self addInterfaceNamed:@"org.alljoyn.bus.samples.ping"];

    // prepare the input arguments
    //

    Message reply(*((BusAttachment*)self.bus.handle));
    MsgArg inArgs[1];

    inArgs[0].Set("y", [value unsignedCharValue]);


    // make the function call using the C++ proxy object
    //

    QStatus status = self.proxyBusObject->MethodCall("org.alljoyn.bus.samples.ping", "Ping", inArgs, 1, reply, 5000);
    if (ER_OK != status) {
        NSLog(@"ERROR: ProxyBusObject::MethodCall on org.alljoyn.bus.samples.ping failed. %@", [AJNStatus descriptionForStatusCode:status]);

    } else {

    }

    if (replyMessage != nil) {
        *replyMessage = [[AJNMessage alloc] initWithHandle:new Message(reply)];
        }
    return status;
}

@end

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  C++ Signal Handler implementation for BasicStringsDelegate
//
////////////////////////////////////////////////////////////////////////////////

class BasicStringsDelegateSignalHandlerImpl : public AJNSignalHandlerImpl
{
private:

    const ajn::InterfaceDescription::Member* TestStringPropertyChangedSignalMember;
    void TestStringPropertyChangedSignalHandler(const ajn::InterfaceDescription::Member* member, const char* srcPath, ajn::Message& msg);

    const ajn::InterfaceDescription::Member* TestSignalWithComplexArgsSignalMember;
    void TestSignalWithComplexArgsSignalHandler(const ajn::InterfaceDescription::Member* member, const char* srcPath, ajn::Message& msg);

    const ajn::InterfaceDescription::Member* TestSignalWithNoArgsSignalMember;
    void TestSignalWithNoArgsSignalHandler(const ajn::InterfaceDescription::Member* member, const char* srcPath, ajn::Message& msg);


public:
    /**
     * Constructor for the AJN signal handler implementation.
     *
     * @param aDelegate         Objective C delegate called when one of the below virtual functions is called.
     */
    BasicStringsDelegateSignalHandlerImpl(id<AJNSignalHandler> aDelegate);

    virtual void RegisterSignalHandler(ajn::BusAttachment &bus);

    virtual void UnregisterSignalHandler(ajn::BusAttachment &bus);

    /**
     * Virtual destructor for derivable class.
     */
    virtual ~BasicStringsDelegateSignalHandlerImpl();
};


/**
 * Constructor for the AJN signal handler implementation.
 *
 * @param aDelegate         Objective C delegate called when one of the below virtual functions is called.
 */
BasicStringsDelegateSignalHandlerImpl::BasicStringsDelegateSignalHandlerImpl(id<AJNSignalHandler> aDelegate) : AJNSignalHandlerImpl(aDelegate)
{
	TestStringPropertyChangedSignalMember = NULL;
	TestSignalWithComplexArgsSignalMember = NULL;
	TestSignalWithNoArgsSignalMember = NULL;

}

BasicStringsDelegateSignalHandlerImpl::~BasicStringsDelegateSignalHandlerImpl()
{
    m_delegate = NULL;
}

void BasicStringsDelegateSignalHandlerImpl::RegisterSignalHandler(ajn::BusAttachment &bus)
{
    QStatus status = ER_OK;
    const ajn::InterfaceDescription* interface = NULL;

    ////////////////////////////////////////////////////////////////////////////
    // Register signal handler for signal TestStringPropertyChanged
    //
    interface = bus.GetInterface("org.alljoyn.bus.sample.strings");

    if (interface) {
        // Store the TestStringPropertyChanged signal member away so it can be quickly looked up
        TestStringPropertyChangedSignalMember = interface->GetMember("TestStringPropertyChanged");
        assert(TestStringPropertyChangedSignalMember);

        // Register signal handler for TestStringPropertyChanged
        status =  bus.RegisterSignalHandler(this,
            static_cast<MessageReceiver::SignalHandler>(&BasicStringsDelegateSignalHandlerImpl::TestStringPropertyChangedSignalHandler),
            TestStringPropertyChangedSignalMember,
            NULL);

        if (status != ER_OK) {
            NSLog(@"ERROR: Interface BasicStringsDelegateSignalHandlerImpl::RegisterSignalHandler failed. %@", [AJNStatus descriptionForStatusCode:status] );
        }
    }
    else {
        NSLog(@"ERROR: org.alljoyn.bus.sample.strings not found.");
    }
    ////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////
    // Register signal handler for signal TestSignalWithComplexArgs
    //
    interface = bus.GetInterface("org.alljoyn.bus.sample.strings");

    if (interface) {
        // Store the TestSignalWithComplexArgs signal member away so it can be quickly looked up
        TestSignalWithComplexArgsSignalMember = interface->GetMember("TestSignalWithComplexArgs");
        assert(TestSignalWithComplexArgsSignalMember);

        // Register signal handler for TestSignalWithComplexArgs
        status =  bus.RegisterSignalHandler(this,
            static_cast<MessageReceiver::SignalHandler>(&BasicStringsDelegateSignalHandlerImpl::TestSignalWithComplexArgsSignalHandler),
            TestSignalWithComplexArgsSignalMember,
            NULL);

        if (status != ER_OK) {
            NSLog(@"ERROR: Interface BasicStringsDelegateSignalHandlerImpl::RegisterSignalHandler failed. %@", [AJNStatus descriptionForStatusCode:status] );
        }
    }
    else {
        NSLog(@"ERROR: org.alljoyn.bus.sample.strings not found.");
    }
    ////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////
    // Register signal handler for signal TestSignalWithNoArgs
    //
    interface = bus.GetInterface("org.alljoyn.bus.sample.strings");

    if (interface) {
        // Store the TestSignalWithNoArgs signal member away so it can be quickly looked up
        TestSignalWithNoArgsSignalMember = interface->GetMember("TestSignalWithNoArgs");
        assert(TestSignalWithNoArgsSignalMember);

        // Register signal handler for TestSignalWithNoArgs
        status =  bus.RegisterSignalHandler(this,
            static_cast<MessageReceiver::SignalHandler>(&BasicStringsDelegateSignalHandlerImpl::TestSignalWithNoArgsSignalHandler),
            TestSignalWithNoArgsSignalMember,
            NULL);

        if (status != ER_OK) {
            NSLog(@"ERROR: Interface BasicStringsDelegateSignalHandlerImpl::RegisterSignalHandler failed. %@", [AJNStatus descriptionForStatusCode:status] );
        }
    }
    else {
        NSLog(@"ERROR: org.alljoyn.bus.sample.strings not found.");
    }
    ////////////////////////////////////////////////////////////////////////////

}

void BasicStringsDelegateSignalHandlerImpl::UnregisterSignalHandler(ajn::BusAttachment &bus)
{
    QStatus status = ER_OK;
    const ajn::InterfaceDescription* interface = NULL;

    ////////////////////////////////////////////////////////////////////////////
    // Unregister signal handler for signal TestStringPropertyChanged
    //
    interface = bus.GetInterface("org.alljoyn.bus.sample.strings");

    // Store the TestStringPropertyChanged signal member away so it can be quickly looked up
    TestStringPropertyChangedSignalMember = interface->GetMember("TestStringPropertyChanged");
    assert(TestStringPropertyChangedSignalMember);

    // Unregister signal handler for TestStringPropertyChanged
    status =  bus.UnregisterSignalHandler(this,
        static_cast<MessageReceiver::SignalHandler>(&BasicStringsDelegateSignalHandlerImpl::TestStringPropertyChangedSignalHandler),
        TestStringPropertyChangedSignalMember,
        NULL);

    if (status != ER_OK) {
        NSLog(@"ERROR:BasicStringsDelegateSignalHandlerImpl::UnregisterSignalHandler failed. %@", [AJNStatus descriptionForStatusCode:status] );
    }
    ////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////
    // Unregister signal handler for signal TestSignalWithComplexArgs
    //
    interface = bus.GetInterface("org.alljoyn.bus.sample.strings");

    // Store the TestSignalWithComplexArgs signal member away so it can be quickly looked up
    TestSignalWithComplexArgsSignalMember = interface->GetMember("TestSignalWithComplexArgs");
    assert(TestSignalWithComplexArgsSignalMember);

    // Unregister signal handler for TestSignalWithComplexArgs
    status =  bus.UnregisterSignalHandler(this,
        static_cast<MessageReceiver::SignalHandler>(&BasicStringsDelegateSignalHandlerImpl::TestSignalWithComplexArgsSignalHandler),
        TestSignalWithComplexArgsSignalMember,
        NULL);

    if (status != ER_OK) {
        NSLog(@"ERROR:BasicStringsDelegateSignalHandlerImpl::UnregisterSignalHandler failed. %@", [AJNStatus descriptionForStatusCode:status] );
    }
    ////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////
    // Unregister signal handler for signal TestSignalWithNoArgs
    //
    interface = bus.GetInterface("org.alljoyn.bus.sample.strings");

    // Store the TestSignalWithNoArgs signal member away so it can be quickly looked up
    TestSignalWithNoArgsSignalMember = interface->GetMember("TestSignalWithNoArgs");
    assert(TestSignalWithNoArgsSignalMember);

    // Unregister signal handler for TestSignalWithNoArgs
    status =  bus.UnregisterSignalHandler(this,
        static_cast<MessageReceiver::SignalHandler>(&BasicStringsDelegateSignalHandlerImpl::TestSignalWithNoArgsSignalHandler),
        TestSignalWithNoArgsSignalMember,
        NULL);

    if (status != ER_OK) {
        NSLog(@"ERROR:BasicStringsDelegateSignalHandlerImpl::UnregisterSignalHandler failed. %@", [AJNStatus descriptionForStatusCode:status] );
    }
    ////////////////////////////////////////////////////////////////////////////

}


void BasicStringsDelegateSignalHandlerImpl::TestStringPropertyChangedSignalHandler(const ajn::InterfaceDescription::Member* member, const char* srcPath, ajn::Message& msg)
{
    @autoreleasepool {

    qcc::String inArg0 = msg->GetArg(0)->v_string.str;

    qcc::String inArg1 = msg->GetArg(1)->v_string.str;

        AJNMessage *signalMessage = [[AJNMessage alloc] initWithHandle:&msg];
        NSString *objectPath = [NSString stringWithCString:msg->GetObjectPath() encoding:NSUTF8StringEncoding];
        AJNSessionId sessionId = msg->GetSessionId();
        NSLog(@"Received TestStringPropertyChanged signal from %@ on path %@ for session id %u [%s > %s]", [signalMessage senderName], objectPath, msg->GetSessionId(), msg->GetRcvEndpointName(), msg->GetDestination() ? msg->GetDestination() : "broadcast");

        dispatch_async(dispatch_get_main_queue(), ^{

            [(id<BasicStringsDelegateSignalHandler>)m_delegate didReceiveTestStringPropertyChangedFrom:[NSString stringWithCString:inArg0.c_str() encoding:NSUTF8StringEncoding] to:[NSString stringWithCString:inArg1.c_str() encoding:NSUTF8StringEncoding] inSession:sessionId message:signalMessage];

        });
    }
}

void BasicStringsDelegateSignalHandlerImpl::TestSignalWithComplexArgsSignalHandler(const ajn::InterfaceDescription::Member* member, const char* srcPath, ajn::Message& msg)
{
    @autoreleasepool {

    AJNMessageArgument* inArg0 = [[AJNMessageArgument alloc] initWithHandle:(AJNHandle)new MsgArg(*(msg->GetArg(0))) shouldDeleteHandleOnDealloc:YES];

        AJNMessage *signalMessage = [[AJNMessage alloc] initWithHandle:&msg];
        NSString *objectPath = [NSString stringWithCString:msg->GetObjectPath() encoding:NSUTF8StringEncoding];
        AJNSessionId sessionId = msg->GetSessionId();
        NSLog(@"Received TestSignalWithComplexArgs signal from %@ on path %@ for session id %u [%s > %s]", [signalMessage senderName], objectPath, msg->GetSessionId(), msg->GetRcvEndpointName(), msg->GetDestination() ? msg->GetDestination() : "broadcast");

        dispatch_async(dispatch_get_main_queue(), ^{

            [(id<BasicStringsDelegateSignalHandler>)m_delegate didReceiveTestSignalWithComplexArgs:inArg0 inSession:sessionId message:signalMessage];

        });
    }
}

void BasicStringsDelegateSignalHandlerImpl::TestSignalWithNoArgsSignalHandler(const ajn::InterfaceDescription::Member* member, const char* srcPath, ajn::Message& msg)
{
    @autoreleasepool {

        AJNMessage *signalMessage = [[AJNMessage alloc] initWithHandle:&msg];
        NSString *objectPath = [NSString stringWithCString:msg->GetObjectPath() encoding:NSUTF8StringEncoding];
        AJNSessionId sessionId = msg->GetSessionId();
        NSLog(@"Received TestSignalWithNoArgs signal from %@ on path %@ for session id %u [%s > %s]", [signalMessage senderName], objectPath, msg->GetSessionId(), msg->GetRcvEndpointName(), msg->GetDestination() ? msg->GetDestination() : "broadcast");

        dispatch_async(dispatch_get_main_queue(), ^{

            [(id<BasicStringsDelegateSignalHandler>)m_delegate didReceiveTestSignalWithNoArgsInSession:sessionId message:signalMessage];

        });
    }
}


@implementation AJNBusAttachment(BasicStringsDelegate)

- (void)registerBasicStringsDelegateSignalHandler:(id<BasicStringsDelegateSignalHandler>)signalHandler
{
    BasicStringsDelegateSignalHandlerImpl *signalHandlerImpl = new BasicStringsDelegateSignalHandlerImpl(signalHandler);
    signalHandler.handle = signalHandlerImpl;
    [self registerSignalHandler:signalHandler];
}

@end

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  C++ Signal Handler implementation for BasicChatDelegate
//
////////////////////////////////////////////////////////////////////////////////

class BasicChatDelegateSignalHandlerImpl : public AJNSignalHandlerImpl
{
private:

    const ajn::InterfaceDescription::Member* ChatSignalMember;
    void ChatSignalHandler(const ajn::InterfaceDescription::Member* member, const char* srcPath, ajn::Message& msg);


public:
    /**
     * Constructor for the AJN signal handler implementation.
     *
     * @param aDelegate         Objective C delegate called when one of the below virtual functions is called.
     */
    BasicChatDelegateSignalHandlerImpl(id<AJNSignalHandler> aDelegate);

    virtual void RegisterSignalHandler(ajn::BusAttachment &bus);

    virtual void UnregisterSignalHandler(ajn::BusAttachment &bus);

    /**
     * Virtual destructor for derivable class.
     */
    virtual ~BasicChatDelegateSignalHandlerImpl();
};


/**
 * Constructor for the AJN signal handler implementation.
 *
 * @param aDelegate         Objective C delegate called when one of the below virtual functions is called.
 */
BasicChatDelegateSignalHandlerImpl::BasicChatDelegateSignalHandlerImpl(id<AJNSignalHandler> aDelegate) : AJNSignalHandlerImpl(aDelegate)
{
	ChatSignalMember = NULL;

}

BasicChatDelegateSignalHandlerImpl::~BasicChatDelegateSignalHandlerImpl()
{
    m_delegate = NULL;
}

void BasicChatDelegateSignalHandlerImpl::RegisterSignalHandler(ajn::BusAttachment &bus)
{
    QStatus status = ER_OK;
    const ajn::InterfaceDescription* interface = NULL;

    ////////////////////////////////////////////////////////////////////////////
    // Register signal handler for signal Chat
    //
    interface = bus.GetInterface("org.alljoyn.bus.samples.chat");

    if (interface) {
        // Store the Chat signal member away so it can be quickly looked up
        ChatSignalMember = interface->GetMember("Chat");
        assert(ChatSignalMember);

        // Register signal handler for Chat
        status =  bus.RegisterSignalHandler(this,
            static_cast<MessageReceiver::SignalHandler>(&BasicChatDelegateSignalHandlerImpl::ChatSignalHandler),
            ChatSignalMember,
            NULL);

        if (status != ER_OK) {
            NSLog(@"ERROR: Interface BasicChatDelegateSignalHandlerImpl::RegisterSignalHandler failed. %@", [AJNStatus descriptionForStatusCode:status] );
        }
    }
    else {
        NSLog(@"ERROR: org.alljoyn.bus.samples.chat not found.");
    }
    ////////////////////////////////////////////////////////////////////////////

}

void BasicChatDelegateSignalHandlerImpl::UnregisterSignalHandler(ajn::BusAttachment &bus)
{
    QStatus status = ER_OK;
    const ajn::InterfaceDescription* interface = NULL;

    ////////////////////////////////////////////////////////////////////////////
    // Unregister signal handler for signal Chat
    //
    interface = bus.GetInterface("org.alljoyn.bus.samples.chat");

    // Store the Chat signal member away so it can be quickly looked up
    ChatSignalMember = interface->GetMember("Chat");
    assert(ChatSignalMember);

    // Unregister signal handler for Chat
    status =  bus.UnregisterSignalHandler(this,
        static_cast<MessageReceiver::SignalHandler>(&BasicChatDelegateSignalHandlerImpl::ChatSignalHandler),
        ChatSignalMember,
        NULL);

    if (status != ER_OK) {
        NSLog(@"ERROR:BasicChatDelegateSignalHandlerImpl::UnregisterSignalHandler failed. %@", [AJNStatus descriptionForStatusCode:status] );
    }
    ////////////////////////////////////////////////////////////////////////////

}


void BasicChatDelegateSignalHandlerImpl::ChatSignalHandler(const ajn::InterfaceDescription::Member* member, const char* srcPath, ajn::Message& msg)
{
    @autoreleasepool {

    qcc::String inArg0 = msg->GetArg(0)->v_string.str;

        AJNMessage *signalMessage = [[AJNMessage alloc] initWithHandle:&msg];
        NSString *objectPath = [NSString stringWithCString:msg->GetObjectPath() encoding:NSUTF8StringEncoding];
        AJNSessionId sessionId = msg->GetSessionId();
        NSLog(@"Received Chat signal from %@ on path %@ for session id %u [%s > %s]", [signalMessage senderName], objectPath, msg->GetSessionId(), msg->GetRcvEndpointName(), msg->GetDestination() ? msg->GetDestination() : "broadcast");

        dispatch_async(dispatch_get_main_queue(), ^{

            [(id<BasicChatDelegateSignalHandler>)m_delegate didReceiveMessage:[NSString stringWithCString:inArg0.c_str() encoding:NSUTF8StringEncoding] inSession:sessionId message:signalMessage];

        });
    }
}


@implementation AJNBusAttachment(BasicChatDelegate)

- (void)registerBasicChatDelegateSignalHandler:(id<BasicChatDelegateSignalHandler>)signalHandler
{
    BasicChatDelegateSignalHandlerImpl *signalHandlerImpl = new BasicChatDelegateSignalHandlerImpl(signalHandler);
    signalHandler.handle = signalHandlerImpl;
    [self registerSignalHandler:signalHandler];
}

@end

////////////////////////////////////////////////////////////////////////////////
