//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import "MockTestCase.h"
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface VerifyCountTimesTest : SenTestCase
@end

@implementation VerifyCountTimesTest
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

- (void)testTimesOne_WithMethodNotInvoked_ShouldFail
{
    [self callRemoveAllObjectsTimes:0];

    [verifyCountWithMockTestCase(mockArray, times(1)) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testTimesOne_WithMethodInvokedOnce_ShouldPass
{
    [self callRemoveAllObjectsTimes:1];

    [verifyCount(mockArray, times(1)) removeAllObjects];
}

- (void)testTimesOne_WithMethodInvokedTwice_ShouldFail
{
    [self callRemoveAllObjectsTimes:2];

    [verifyCountWithMockTestCase(mockArray, times(1)) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testTimesTwo_WithMethodInvokedOnce_ShouldFail
{
    [self callRemoveAllObjectsTimes:1];

    [verifyCountWithMockTestCase(mockArray, times(2)) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testTimesTwo_WithMethodInvokedTwice_ShouldPass
{
    [self callRemoveAllObjectsTimes:2];

    [verifyCount(mockArray, times(2)) removeAllObjects];
}

- (void)testTimesTwo_WithMethodInvokedThreeTimes_ShouldFail
{
    [self callRemoveAllObjectsTimes:3];

    [verifyCountWithMockTestCase(mockArray, times(2)) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testTimesOneFailure_ShouldStateExpectedNumberOfInvocations
{
    [self callRemoveAllObjectsTimes:0];

    [verifyCountWithMockTestCase(mockArray, times(1)) removeAllObjects];

    assertThat([mockTestCase.failureException description],
               is(@"Expected 1 matching invocation, but received 0"));
}

- (void)testTimesTwoFailure_ShouldStateExpectedNumberOfInvocations
{
    [self callRemoveAllObjectsTimes:1];

    [verifyCountWithMockTestCase(mockArray, times(2)) removeAllObjects];

    assertThat([mockTestCase.failureException description],
               is(@"Expected 2 matching invocations, but received 1"));
}

@end
