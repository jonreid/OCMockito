// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "OCMockito.h"

#import "MockTestCase.h"
#import <OCHamcrest/OCHamcrest.h>
@import XCTest;


@interface VerifyProtocolTests : XCTestCase
@end

@implementation VerifyProtocolTests
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
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:[NSMutableData data]];
#pragma clang diagnostic pop
}

- (void)tearDown
{
    [archiver finishEncoding];
    mockLock = nil;
    mockDelegate = nil;
    mockTestCase = nil;
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
    [verifyWithMockTestCase(mockLock, mockTestCase) lock];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testInvokingWithEqualObjectArguments_ShouldPassVerify
{
    [mockDelegate archiver:archiver willEncodeObject:@"same"];

    [verify(mockDelegate) archiver:archiver willEncodeObject:@"same"];
}

- (void)testInvokingWithDifferentObjectArguments_ShouldFailVerify
{
    [mockDelegate archiver:archiver willEncodeObject:@"same"];

    [verifyWithMockTestCase(mockDelegate, mockTestCase) archiver:archiver willEncodeObject:@"different"];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testInvokingWithArgumentMatcherSatisfied_ShouldPassVerify
{
    [mockDelegate archiver:archiver willEncodeObject:@"same"];

    [verify(mockDelegate) archiver:archiver willEncodeObject:equalTo(@"same")];
}

@end
