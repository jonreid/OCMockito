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

- (void)testInvokingMethodShouldPassVerify
{
    // when
    [mockLock lock];
    
    // then
    [verify(mockLock) lock];
}

- (void)testNotInvokingMethodShouldFailVerify
{
    // when
    [verifyWithMockTestCase(mockLock) lock];

    // then
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testInvokingWithEqualObjectArgumentsShouldPassVerify
{
    // when
    [mockDelegate archiver:archiver willEncodeObject:@"same"];
    
    // then
    [verify(mockDelegate) archiver:archiver willEncodeObject:@"same"];
}

- (void)testInvokingWithDifferentObjectArgumentsShouldFailVerify
{
    // when
    [mockDelegate archiver:archiver willEncodeObject:@"same"];
    
    // then
    [verifyWithMockTestCase(mockDelegate) archiver:archiver willEncodeObject:@"different"];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testInvokingWithArgumentMatcherSatisfiedShouldPassVerify
{
    // when
    [mockDelegate archiver:archiver willEncodeObject:@"same"];

    // then
    [verify(mockDelegate) archiver:archiver willEncodeObject:equalTo(@"same")];
}

@end
