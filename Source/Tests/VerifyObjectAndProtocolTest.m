//
//  OCMockito - VerifyObjectAndProtocolTest.m
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


@interface VerifyObjectAndProtocolTest : SenTestCase
@end

@implementation VerifyObjectAndProtocolTest
{
    NSMutableArray <NSLocking> *mockLockingArray;
}

- (void)setUp
{
    [super setUp];
    mockLockingArray = mockObjectAndProtocol([NSMutableArray class], @protocol(NSLocking));
}

- (void)testInvokingClassInstanceMethod_ShouldPassVerify
{
    [mockLockingArray removeAllObjects];
    [verify(mockLockingArray) removeAllObjects];
}

- (void)testNotInvokingClassInstanceMethod_ShouldFailVerify
{
    MockTestCase *mockTestCase = [[MockTestCase alloc] init];
    [verifyWithMockTestCase(mockLockingArray) removeAllObjects];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

- (void)testInvokingProtocolMethod_ShouldPassVerify
{
    [mockLockingArray lock];
    [verify(mockLockingArray) lock];
}

- (void)testNotInvokingProtocolMethod_ShouldFailVerify
{
    MockTestCase *mockTestCase = [[MockTestCase alloc] init];
    [verifyWithMockTestCase(mockLockingArray) lock];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

@end
