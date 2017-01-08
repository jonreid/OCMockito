//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import "MockTestCase.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface VerifyCountTimesTest : XCTestCase
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

- (void)testTimesOne_WithMethodNotInvoked_ShouldFail
{
    [self callRemoveAllObjectsTimes:0];

    [verifyCountWithMockTestCase(mockArray, times(1), mockTestCase) removeAllObjects];

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

    [verifyCountWithMockTestCase(mockArray, times(1), mockTestCase) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testTimesTwo_WithMethodInvokedOnce_ShouldFail
{
    [self callRemoveAllObjectsTimes:1];

    [verifyCountWithMockTestCase(mockArray, times(2), mockTestCase) removeAllObjects];

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

    [verifyCountWithMockTestCase(mockArray, times(2), mockTestCase) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testExpectNoInvocations_WithMethodInvokedOnce_FailureMessage
{
    [self callRemoveAllObjectsTimes:1];

    [verifyCountWithMockTestCase(mockArray, times(0), mockTestCase) removeAllObjects];

    assertThat(mockTestCase.failureDescription,
            startsWith(@"Never wanted but was called 1 time."));
}

- (void)testExpectTwice_WithMethodInvokedOnce_FailureMessage
{
    [self callRemoveAllObjectsTimes:1];

    [verifyCountWithMockTestCase(mockArray, times(2), mockTestCase) removeAllObjects];

    assertThat(mockTestCase.failureDescription,
            startsWith(@"Wanted 2 times but was called 1 time."));
}

- (void)testExpectOnce_WithNoMethodsEverInvoked_FailureMessage
{
    [self callRemoveAllObjectsTimes:0];

    [verifyCountWithMockTestCase(mockArray, times(1), mockTestCase) removeAllObjects];

    assertThat(mockTestCase.failureDescription,
            is(@"Wanted but not invoked:\n"
                    "removeAllObjects\n"
                    "Actually, there were zero interactions with this mock."));
}

@end
