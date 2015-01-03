//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Markus Gasser

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import "MockTestCase.h"
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface VerifyCountAtLeastTimesTests : SenTestCase
@end

@implementation VerifyCountAtLeastTimesTests
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

- (void)callRemoveAllObjectsTimes:(int)count
{
    for (int i = 0; i < count; ++i)
        [mockArray removeAllObjects];
}

- (void)testAtLeast_WithTooFewInvocations_ShouldFail
{
    [self callRemoveAllObjectsTimes:1];

    [verifyCountWithMockTestCase(mockArray, atLeast(2)) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testAtLeast_WithExactCount_ShouldPass
{
    [self callRemoveAllObjectsTimes:1];

    [verifyCount(mockArray, atLeast(1)) removeAllObjects];
}

- (void)testAtLeast_WithMoreInvocations_ShouldPass
{
    [self callRemoveAllObjectsTimes:3];

    [verifyCount(mockArray, atLeast(2)) removeAllObjects];
}

- (void)testAtLeastOnce_WithTooFewInvocations_ShouldFail
{
    [self callRemoveAllObjectsTimes:0];

    [verifyCountWithMockTestCase(mockArray, atLeastOnce()) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testAtLeastOnce_WithExactCount_ShouldPass
{
    [self callRemoveAllObjectsTimes:1];

    [verifyCount(mockArray, atLeastOnce()) removeAllObjects];
}

- (void)testAtLeastOnce_WithMoreInvocations_ShouldPass
{
    [self callRemoveAllObjectsTimes:2];

    [verifyCount(mockArray, atLeastOnce()) removeAllObjects];
}

@end
