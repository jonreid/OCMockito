// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT
//  Contribution by Emile Cantin

#import <OCMockito/OCMockito.h>
#import <OCHamcrest/OCHamcrest.h>

#import "MockTestCase.h"
@import XCTest;


@interface VerifyCountAtMostTimesTests : XCTestCase
@end

@implementation VerifyCountAtMostTimesTests
{
    NSMutableArray *mockArray;
    MockTestCase *mockTestCase;
}

- (void)setUp
{
    [super setUp];
    mockArray = mock([NSMutableArray class]);
    mockTestCase = [[MockTestCase alloc] init];
}

- (void)tearDown
{
    mockArray = nil;
    mockTestCase = nil;
    [super tearDown];
}

- (void)callRemoveAllObjectsTimes:(int)count
{
    for (int i = 0; i < count; ++i)
        [mockArray removeAllObjects];
}

- (void)testAtMost_WithTooManyInvocations_ShouldFail
{
    [self callRemoveAllObjectsTimes:3];
    
    [verifyCountWithMockTestCase(mockArray, atMost(2), mockTestCase) removeAllObjects];
    
    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testAtMost_WithExactCount_ShouldPass
{
    [self callRemoveAllObjectsTimes:1];
    
    [verifyCount(mockArray, atMost(1)) removeAllObjects];
}

- (void)testAtMost_WithFewerInvocations_ShouldPass
{
    [self callRemoveAllObjectsTimes:2];
    
    [verifyCount(mockArray, atMost(3)) removeAllObjects];
}

- (void)testAtMostOneFailure_ShouldStateExpectedNumberOfInvocations
{
    [self callRemoveAllObjectsTimes:3];

    [verifyCountWithMockTestCase(mockArray, atMost(1), mockTestCase) removeAllObjects];

    assertThat(mockTestCase.failureDescription,
            startsWith(@"Wanted at most 1 time but was called 3 times."));
}

@end
