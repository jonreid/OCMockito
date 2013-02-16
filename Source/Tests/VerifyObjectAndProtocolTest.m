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

- (void)testInvokingClassInstanceMethodShouldPassVerify
{
    // when
    [mockLockingArray removeAllObjects];
    
    // then
    [verify(mockLockingArray) removeAllObjects];
}

- (void)testNotInvokingClassInstanceMethodShouldFailVerify
{
    // given
    MockTestCase *mockTestCase = [[MockTestCase alloc] init];

    // when nothing

    // then
    [verifyWithMockTestCase(mockLockingArray) removeAllObjects];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testInvokingProtocolMethodShouldPassVerify
{
    // given
    [mockLockingArray lock];
    
    // then
    [verify(mockLockingArray) lock];
}

- (void)testNotInvokingProtocolMethodShouldFailVerify
{
    // given
    MockTestCase *mockTestCase = [[MockTestCase alloc] init];

    // when
    [verifyWithMockTestCase(mockLockingArray) lock];

    // then
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

@end
