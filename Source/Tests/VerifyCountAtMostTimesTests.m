//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Emile Cantin

#import "OCMockito.h"

#import "MockTestCase.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


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
