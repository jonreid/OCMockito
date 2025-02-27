// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <OCMockito/OCMockito.h>
#import <OCHamcrest/OCHamcrest.h>

#import "MockTestCase.h"
@import XCTest;


@interface VerifyCountNeverTests : XCTestCase
@end

@implementation VerifyCountNeverTests
{
    NSMutableArray *mockArray;
}

- (void)setUp
{
    [super setUp];
    mockArray = mock([NSMutableArray class]);
}

- (void)tearDown
{
    mockArray = nil;
    [super tearDown];
}

- (void)testVerifyNever_WithMethodNotInvoked_ShouldPass
{
    [verifyCount(mockArray, never()) removeAllObjects];
}

- (void)testVerifyNever_WithMethodInvoked_ShouldFail
{
    MockTestCase *mockTestCase = [[MockTestCase alloc] init];
    [mockArray removeAllObjects];

    [verifyCountWithMockTestCase(mockArray, never(), mockTestCase) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

@end
