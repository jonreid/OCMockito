//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "MKTMissingInvocationChecker.h"

#import "MKTInvocation.h"
#import "MKTInvocationMatcher.h"
#import "MKTLocation.h"

#import "DummyObject.h"
#import "FakeLocation.h"
#import "MockInvocationsFinder.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTMissingInvocationCheckerDefaultsTests : XCTestCase
@end

@implementation MKTMissingInvocationCheckerDefaultsTests

- (void)testInvocationsFinder_ShouldDefaultToMKTInvocationsFinder
{
    MKTMissingInvocationChecker *sut = [[MKTMissingInvocationChecker alloc] init];

    MKTMatchingInvocationsFinder *finder = sut.invocationsFinder;

    assertThat(finder, isA([MKTMatchingInvocationsFinder class]));
}

@end


@interface MKTFindSimilarInvocationTests : XCTestCase
@end

@implementation MKTFindSimilarInvocationTests

- (void)testFindSimilar_WithNoMatchingSelectors_ShouldReturnNil
{
    MKTInvocation *invocation = wrappedInvocation([DummyObject invocationWithNoArgs]);
    MKTInvocationMatcher *invocationMatcher = matcherForInvocation([DummyObject differentInvocationWithNoArgs]);

    MKTInvocation *similar = MKTFindSimilarInvocation(@[ invocation ], invocationMatcher);

    assertThat(similar, is(nilValue()));
}

- (void)testFindSimilar_WithSameSelectorsButDifferentArgs_ShouldReturnFirstMatch
{
    MKTInvocation *otherInvocation = wrappedInvocation([DummyObject invocationWithNoArgs]);
    MKTInvocation *invocationSimilar = wrappedInvocation([DummyObject invocationWithObjectArg:@"FOO"]);
    MKTInvocationMatcher *invocationMatcher = matcherForInvocation([DummyObject invocationWithObjectArg:@"BAR"]);

    MKTInvocation *similar = MKTFindSimilarInvocation(@[ otherInvocation, invocationSimilar ], invocationMatcher);

    assertThat(similar, is(sameInstance(invocationSimilar)));
}

- (void)testFindSimilar_WithSameSelectorsButSomeAlreadyVerified_ShouldReturnFirstUnverifiedMatch
{
    MKTInvocation *invocationVerified = wrappedInvocation([DummyObject invocationWithNoArgs]);
    invocationVerified.verified = YES;
    MKTInvocation *invocationUnverified = wrappedInvocation([DummyObject invocationWithNoArgs]);
    MKTInvocation *invocationUnverified2 = wrappedInvocation([DummyObject invocationWithNoArgs]);
    MKTInvocationMatcher *invocationMatcher = matcherForInvocation([DummyObject invocationWithNoArgs]);

    MKTInvocation *similar = MKTFindSimilarInvocation(
            @[ invocationVerified, invocationUnverified, invocationUnverified2 ], invocationMatcher);

    assertThat(similar, is(sameInstance(invocationUnverified)));
}

@end


@interface MKTMissingInvocationCheckerTests : XCTestCase
@end

@implementation MKTMissingInvocationCheckerTests
{
    MockInvocationsFinder *mockInvocationsFinder;
    MKTMissingInvocationChecker *sut;
}

- (void)setUp
{
    [super setUp];
    mockInvocationsFinder = [[MockInvocationsFinder alloc] init];
    sut = [[MKTMissingInvocationChecker alloc] init];
    sut.invocationsFinder = mockInvocationsFinder;
}

- (void)tearDown
{
    mockInvocationsFinder = nil;
    sut = nil;
    [super tearDown];
}

- (void)testCheckInvocations_ShouldAskInvocationsFinderToFindMatchingInvocationsInList
{
    NSArray *invocations = @[ wrappedInvocation([DummyObject invocationWithNoArgs]) ];
    MKTInvocationMatcher *wanted = matcherForInvocation([DummyObject invocationWithNoArgs]);
    mockInvocationsFinder.stubbedCount = 1;

    [sut checkInvocations:invocations wanted:wanted];

    assertThat(mockInvocationsFinder.capturedInvocations, is(sameInstance(invocations)));
    assertThat(mockInvocationsFinder.capturedWanted, is(sameInstance(wanted)));
}

- (void)testCheckInvocations_WithEvenOneMatchingInvocation_ShouldReturnNil
{
    mockInvocationsFinder.stubbedCount = 1;
    NSArray *dummyInvocations = [[NSArray alloc] init];
    MKTInvocationMatcher *dummyWanted = [[MKTInvocationMatcher alloc] init];

    NSString *description = [sut checkInvocations:dummyInvocations wanted:dummyWanted];

    assertThat(description, is(nilValue()));
}

- (void)testCheckInvocations_WithNoMatchingOneDifferentOneSimilar_ShouldReportSimilarInvocation
{
    mockInvocationsFinder.stubbedCount = 0;
    MKTInvocation *differentInvocation =
            wrappedInvocation([DummyObject differentInvocationWithObjectArg:@"DUMMY"]);
    id fakeLocation = [[FakeLocation alloc] init];
    MKTInvocation *similarInvocation =
            wrappedInvocationWithLocation([DummyObject invocationWithObjectArg:@"ACTUAL"], fakeLocation);
    NSArray *invocations = @[ differentInvocation, similarInvocation ];
    MKTInvocationMatcher *wanted = matcherForInvocation([DummyObject invocationWithObjectArg:@"WANTED"]);

    NSString *description = [sut checkInvocations:invocations wanted:wanted];

    assertThat(description, is(@"Argument(s) are different!\n"
            "Wanted: methodWithObjectArg:\"WANTED\"\n"
            "Actual invocation has different arguments:\n"
            "methodWithObjectArg:@\"ACTUAL\"\n"
            "\n"
            "Mismatch in 1st argument. Expected \"WANTED\", but was \"ACTUAL\"\n"
            "\n"
            "FAKE CALL STACK"));
}

- (void)testCheckInvocations_WithMultipleArgumentMismatches_ShouldReportAllArgumentMismatches
{
    mockInvocationsFinder.stubbedCount = 0;
    id fakeLocation = [[FakeLocation alloc] init];
    MKTInvocation *similarInvocation =
            wrappedInvocationWithLocation([DummyObject invocationWithObjectArg1:@"ACTUAL1" objectArg2:@"ACTUAL2"], fakeLocation);
    NSArray *invocations = @[ similarInvocation ];
    MKTInvocationMatcher *wanted = matcherForInvocation([DummyObject invocationWithObjectArg1:@"WANTED1" objectArg2:@"WANTED2"]);

    NSString *description = [sut checkInvocations:invocations wanted:wanted];

    assertThat(description, is(@"Argument(s) are different!\n"
            "Wanted: methodWithObjectArg1:\"WANTED1\" objectArg2:\"WANTED2\"\n"
            "Actual invocation has different arguments:\n"
            "methodWithObjectArg1:@\"ACTUAL1\" objectArg2:@\"ACTUAL2\"\n"
            "\n"
            "Mismatch in 1st argument. Expected \"WANTED1\", but was \"ACTUAL1\"\n"
            "Mismatch in 2nd argument. Expected \"WANTED2\", but was \"ACTUAL2\"\n"
            "\n"
            "FAKE CALL STACK"));
}

- (void)testCheckInvocations_WithNoInvocations_ShouldReportThereWereNoInvocations
{
    mockInvocationsFinder.stubbedCount = 0;
    MKTInvocationMatcher *wanted = matcherForInvocation([DummyObject invocationWithNoArgs]);

    NSString *description = [sut checkInvocations:@[] wanted:wanted];

    assertThat(description, is(@"Wanted but not invoked:\n"
            "methodWithNoArgs\n"
            "Actually, there were zero interactions with this mock."));
}

- (void)testCheckInvocations_WithNoSimilarInvocations_ShouldReportAllInvocations
{
    mockInvocationsFinder.stubbedCount = 0;
    id fakeLocation = [[FakeLocation alloc] init];
    MKTInvocation *differentInvocation1 =
            wrappedInvocationWithLocation([DummyObject differentInvocationWithNoArgs], fakeLocation);
    MKTInvocation *differentInvocation2 =
            wrappedInvocationWithLocation([DummyObject invocationWithIntArg:123], fakeLocation);
    NSArray *invocations = @[ differentInvocation1, differentInvocation2 ];
    MKTInvocationMatcher *wanted = matcherForInvocation([DummyObject invocationWithNoArgs]);

    NSString *description = [sut checkInvocations:invocations wanted:wanted];

    assertThat(description, is(@"Wanted but not invoked:\n"
            "methodWithNoArgs\n"
            "However, there were other interactions with this mock (✓ means already verified):\n"
            "\n"
            "differentMethodWithNoArgs\n"
            "FAKE CALL STACK\n"
            "\n"
            "methodWithIntArg:123\n"
            "FAKE CALL STACK"));
}

- (void)testCheckInvocations_WithNoSimilarUnverifiedInvocations_ShouldReportAllInvocationsMarkingAlreadyVerifiedWithCheckMarks
{
    mockInvocationsFinder.stubbedCount = 0;
    id fakeLocation = [[FakeLocation alloc] init];
    MKTInvocation *differentInvocation1 =
            wrappedInvocationWithLocation([DummyObject differentInvocationWithNoArgs], fakeLocation);
    MKTInvocation *matchingInvocationAlreadyVerified =
            wrappedInvocationWithLocation([DummyObject invocationWithNoArgs], fakeLocation);
    matchingInvocationAlreadyVerified.verified = YES;
    NSArray *invocations = @[ matchingInvocationAlreadyVerified, differentInvocation1 ];
    MKTInvocationMatcher *wanted = matcherForInvocation([DummyObject invocationWithNoArgs]);

    NSString *description = [sut checkInvocations:invocations wanted:wanted];

    assertThat(description, is(@"Wanted but not invoked:\n"
            "methodWithNoArgs\n"
            "However, there were other interactions with this mock (✓ means already verified):\n"
            "\n"
            "✓ methodWithNoArgs\n"
            "FAKE CALL STACK\n"
            "\n"
            "differentMethodWithNoArgs\n"
            "FAKE CALL STACK"));
}

@end
