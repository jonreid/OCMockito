//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTMissingInvocationChecker.h"

#import "MKTLocation.h"
#import "MKTInvocation.h"

#import "DummyObject.h"
#import "MockInvocationsFinder.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface FakeLocation : NSObject
@end

@implementation FakeLocation

- (NSString *)description
{
    return @"FAKE CALL STACK";
}

@end


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

    NSString *description = [sut checkInvocations:nil wanted:nil];

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
            "Call stack:\n"
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
            "However, there were other interactions with this mock:\n"
            "\n"
            "differentMethodWithNoArgs\n"
            "FAKE CALL STACK\n"
            "\n"
            "methodWithIntArg:123\n"
            "FAKE CALL STACK"));
}

@end
