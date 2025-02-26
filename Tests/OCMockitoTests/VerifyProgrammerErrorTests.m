// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <OCMockito/OCMockito.h>
#import <OCHamcrest/OCHamcrest.h>

#import "MockTestCase.h"
@import XCTest;


@interface VerifyProgrammerErrorTests : XCTestCase
@end

@implementation VerifyProgrammerErrorTests
{
    MockTestCase *mockTestCase;
}

- (void)setUp
{
    [super setUp];
    mockTestCase = [[MockTestCase alloc] init];
}

- (void)tearDown
{
    mockTestCase = nil;
    [super tearDown];
}

- (void)testVerify_WithNil_ShouldGiveError
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    [verifyWithMockTestCase(nil, mockTestCase) removeAllObjects];
#pragma clang diagnostic pop

    assertThat(mockTestCase.failureDescription,
               is(@"Argument passed to verify() should be a mock, but was nil"));
}

- (void)testVerifyCount_WithNil_ShouldGiveError
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    [verifyCountWithMockTestCase(nil, times(1), mockTestCase) removeAllObjects];
#pragma clang diagnostic pop

    assertThat(mockTestCase.failureDescription,
               is(@"Argument passed to verifyCount() should be a mock, but was nil"));
}

- (void)testVerify_WithNonMock_ShouldGiveError
{
    NSMutableArray *realArray = [NSMutableArray array];

    [verifyWithMockTestCase(realArray, mockTestCase) removeAllObjects];

    assertThat(mockTestCase.failureDescription,
               startsWith(@"Argument passed to verify() should be a mock, but was type "));
}

- (void)testVerifyCount_WithNonMock_ShouldGiveError
{
    NSMutableArray *realArray = [NSMutableArray array];

    [verifyCountWithMockTestCase(realArray, times(1), mockTestCase) removeAllObjects];

    assertThat(mockTestCase.failureDescription,
               startsWith(@"Argument passed to verifyCount() should be a mock, but was type "));
}

@end
