//
//  OCMockito - VerifyProtocolTest.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
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

- (void)testInvokingMethodShouldPassVerify
{
    // given
    id <NSLocking> mockLock = mockProtocol(@protocol(NSLocking));
    
    // when
    [mockLock lock];
    
    // then
    [verify(mockLock) lock];
}

- (void)testNotInvokingMethodShouldFailVerify
{
    // given
    id <NSLocking> mockLock = mockProtocol(@protocol(NSLocking));
    MockTestCase *mockTestCase = [[MockTestCase alloc] init];
    
    // then
    [verifyWithMockTestCase(mockLock) lock];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testInvokingWithEqualObjectArgumentsShouldPassVerify
{
    // given
    id <NSKeyedArchiverDelegate> mockDelegate = mockProtocol(@protocol(NSKeyedArchiverDelegate));
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                  initForWritingWithMutableData:[NSMutableData data]];
    
    // when
    [mockDelegate archiver:archiver willEncodeObject:@"same"];
    
    // then
    [verify(mockDelegate) archiver:archiver willEncodeObject:@"same"];
}

- (void)testInvokingWithDifferentObjectArgumentsShouldFailVerify
{
    // given
    id <NSKeyedArchiverDelegate> mockDelegate = mockProtocol(@protocol(NSKeyedArchiverDelegate));
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                  initForWritingWithMutableData:[NSMutableData data]];
    
    MockTestCase *mockTestCase = [[MockTestCase alloc] init];
    
    // when
    [mockDelegate archiver:archiver willEncodeObject:@"same"];
    
    // then
    [verifyWithMockTestCase(mockDelegate) archiver:archiver willEncodeObject:@"different"];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testInvokingWithArgumentMatcherSatisfiedShouldPassVerify
{
    // given
    id <NSKeyedArchiverDelegate> mockDelegate = mockProtocol(@protocol(NSKeyedArchiverDelegate));
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                  initForWritingWithMutableData:[NSMutableData data]];
    
    // when
    [mockDelegate archiver:archiver willEncodeObject:@"same"];

    // then
    [verify(mockDelegate) archiver:archiver willEncodeObject:equalTo(@"same")];
}

@end
