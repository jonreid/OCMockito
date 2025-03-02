// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "OCMockito.h"

#import "MKTAtLeastTimes.h"
#import "MKTAtMostTimes.h"
#import "MKTExactTimes.h"
#import "MKTMockitoCore.h"


static NSString *actualTypeName(id mock)
{
    NSString *className = NSStringFromClass([mock class]);
    if (!className)
        return @"nil";
    return [@"type " stringByAppendingString:className];
}

static BOOL reportedInvalidMock(id mock, id testCase, const char *fileName, int lineNumber, NSString *functionName)
{
    if ([MKTBaseMockObject isMockObject:mock])
        return NO;
    NSString *description = [NSString stringWithFormat:
            @"Argument passed to %@ should be a mock, but was %@",
            functionName, actualTypeName(mock)];
    MKTFailTest(testCase, fileName, lineNumber, description);
    return YES;
}

static BOOL reportedInvalidClassMock(id classMock, id testCase, const char *fileName, int lineNumber, NSString *functionName)
{
    NSString *className = NSStringFromClass([classMock class]);
    if ([className isEqualToString:@"MKTClassObjectMock"])
        return NO;
    NSString *description = [NSString stringWithFormat:
            @"Argument passed to %@ should be a class mock, but was %@",
            functionName, actualTypeName(classMock)];
    MKTFailTest(testCase, fileName, lineNumber, description);
    return YES;
}

static BOOL reportedInvalidClassMethod(MKTClassObjectMock *theMock, SEL aSelector, id testCase, const char *fileName, int lineNumber, NSString *functionName)
{
    if ([theMock respondsToSelector:aSelector])
        return NO;
    NSString *description = [NSString stringWithFormat:
            @"Method name passed to %@ should be a class method of %@, but was %@",
            functionName, theMock.mockedClass, NSStringFromSelector(aSelector)];
    MKTFailTest(testCase, fileName, lineNumber, description);
    return YES;
}

id MKTMock(Class classToMock)
{
    return [[MKTObjectMock alloc] initWithClass:classToMock];
}

id MKTMockClass(Class classToMock)
{
    return [[MKTClassObjectMock alloc] initWithClass:classToMock];
}

id MKTMockProtocol(Protocol *protocolToMock)
{
    return [[MKTProtocolMock alloc] initWithProtocol:protocolToMock includeOptionalMethods:YES];
}

id MKTMockProtocolWithoutOptionals(Protocol *protocolToMock)
{
    return [[MKTProtocolMock alloc] initWithProtocol:protocolToMock includeOptionalMethods:NO];
}

id MKTMockObjectAndProtocol(Class classToMock, Protocol *protocolToMock)
{
    return [[MKTObjectAndProtocolMock alloc] initWithClass:classToMock protocol:protocolToMock];
}

MKTOngoingStubbing *MKTGivenWithLocation(id testCase, const char *fileName, int lineNumber, ...)
{
    return [[MKTMockitoCore sharedCore] stubAtLocation:MKTTestLocationMake(testCase, fileName, lineNumber)];
}

MKTOngoingStubbing *MKTGivenVoidWithLocation(id testCase, const char *fileName, int lineNumber, void(^methodCallWrapper)(void))
{
    methodCallWrapper();
    return [[MKTMockitoCore sharedCore] stubAtLocation:MKTTestLocationMake(testCase, fileName, lineNumber)];
}

void MKTStubSingletonWithLocation(id mockClass, SEL aSelector, id testCase, const char *fileName, int lineNumber)
{
    if (reportedInvalidClassMock(mockClass, testCase, fileName, lineNumber, @"stubSingleton()"))
        return;
    MKTClassObjectMock *theMock = (MKTClassObjectMock *)mockClass;
    if (reportedInvalidClassMethod(theMock, aSelector, testCase, fileName, lineNumber, @"stubSingleton()"))
        return;
    [theMock swizzleSingletonAtSelector:aSelector];
}

_Nullable id MKTVerifyWithLocation(id mock, id testCase, const char *fileName, int lineNumber)
{
    if (reportedInvalidMock(mock, testCase, fileName, lineNumber, @"verify()"))
        return nil;
    
    return MKTVerifyCountWithLocation(mock, MKTTimes(1), testCase, fileName, lineNumber);
}

id MKTVerifyCountWithLocation(id mock, id mode, id testCase, const char *fileName, int lineNumber)
{
    if (reportedInvalidMock(mock, testCase, fileName, lineNumber, @"verifyCount()"))
        return nil;
    
    return [[MKTMockitoCore sharedCore] verifyMock:mock
                                          withMode:mode
                                        atLocation:MKTTestLocationMake(testCase, fileName, lineNumber)];
}

id <MKTVerificationMode> MKTTimes(NSUInteger wantedNumberOfInvocations)
{
    return [[MKTExactTimes alloc] initWithCount:wantedNumberOfInvocations];
}

id <MKTVerificationMode> MKTNever(void)
{
    return MKTTimes(0);
}

id <MKTVerificationMode> MKTAtLeast(NSUInteger minNumberOfInvocations)
{
    return [[MKTAtLeastTimes alloc] initWithMinimumCount:minNumberOfInvocations];
}

id <MKTVerificationMode> MKTAtLeastOnce(void)
{
    return MKTAtLeast(1);
}

id <MKTVerificationMode> MKTAtMost(NSUInteger maxNumberOfInvocations)
{
    return [[MKTAtMostTimes alloc] initWithMaximumCount:maxNumberOfInvocations];
}

void MKTStopMockingWithLocation(id mock, id testCase, const char *fileName, int lineNumber)
{
    if (reportedInvalidMock(mock, testCase, fileName, lineNumber, @"stopMocking()"))
        return;
    [mock stopMocking];
}
