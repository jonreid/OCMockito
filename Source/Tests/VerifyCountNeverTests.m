//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import "OCMockito.h"

#import "MockTestCase.h"
#import <OCHamcrest/OCHamcrest.h>
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
