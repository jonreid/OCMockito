//
//  OCMockito - VerifyProtocolTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import "MockTestCase.h"
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface VerifyProtocolTest : SenTestCase
@end

@implementation VerifyProtocolTest
{
    id <NSLocking> mockLock;
    id <NSKeyedArchiverDelegate> mockDelegate;
    MockTestCase *mockTestCase;
    NSKeyedArchiver *archiver;
}

- (void)setUp
{
    [super setUp];
    mockLock = mockProtocol(@protocol(NSLocking));
    mockDelegate = mockProtocol(@protocol(NSKeyedArchiverDelegate));
    mockTestCase = [[MockTestCase alloc] init];
    archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:[NSMutableData data]];
}

- (void)tearDown
{
    mockTestCase = nil;
    [archiver finishEncoding];
    archiver = nil;
    [super tearDown];
}

- (void)testInvokingMethod_ShouldPassVerify
{
    [mockLock lock];
    [verify(mockLock) lock];
}

- (void)testNotInvokingMethod_ShouldFailVerify
{
    [verifyWithMockTestCase(mockLock) lock];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

- (void)testInvokingWithEqualObjectArguments_ShouldPassVerify
{
    [mockDelegate archiver:archiver willEncodeObject:@"same"];
    [verify(mockDelegate) archiver:archiver willEncodeObject:@"same"];
}

- (void)testInvokingWithDifferentObjectArguments_ShouldFailVerify
{
    [mockDelegate archiver:archiver willEncodeObject:@"same"];
    [verifyWithMockTestCase(mockDelegate) archiver:archiver willEncodeObject:@"different"];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

- (void)testInvokingWithArgumentMatcherSatisfied_ShouldPassVerify
{
    [mockDelegate archiver:archiver willEncodeObject:@"same"];
    [verify(mockDelegate) archiver:archiver willEncodeObject:equalTo(@"same")];
}

@end
