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
{
    MKTMissingInvocationChecker *sut;
}

- (void)setUp
{
    [super setUp];
    sut = [[MKTMissingInvocationChecker alloc] init];
}

- (void)tearDown
{
    sut = nil;
    [super tearDown];
}

- (void)testInvocationsFinder_ShouldDefaultToMKTInvocationsFinder
{
    MKTMatchingInvocationsFinder *finder = sut.invocationsFinder;

    assertThat(finder, isA([MKTMatchingInvocationsFinder class]));
}

- (void)testFindSimilarInvocationBlock_WithNoMatchingSelectors_ShouldReturnNil
{
    MKTInvocation *invocation = wrappedInvocation([DummyObject invocationWithNoArgs]);
    MKTInvocationMatcher *invocationMatcher = matcherForInvocation([DummyObject differentInvocationWithNoArgs]);

    MKTInvocation *(^findSimilar)(NSArray *, MKTInvocationMatcher *) = sut.findSimilarInvocation;
    MKTInvocation *similar = findSimilar(@[ invocation ], invocationMatcher);

    assertThat(similar, is(nilValue()));
}

- (void)testFindSimilarInvocationBlock_WithSameSelectorsButDifferentArgs_ShouldReturnFirstMatch
{
    MKTInvocation *otherInvocation = wrappedInvocation([DummyObject invocationWithNoArgs]);
    MKTInvocation *invocationSimilar = wrappedInvocation([DummyObject invocationWithObjectArg:@"FOO"]);
    MKTInvocationMatcher *invocationMatcher = matcherForInvocation([DummyObject invocationWithObjectArg:@"BAR"]);

    MKTInvocation *(^findSimilar)(NSArray *, MKTInvocationMatcher *) = sut.findSimilarInvocation;
    MKTInvocation *similar = findSimilar(@[ otherInvocation, invocationSimilar ], invocationMatcher);

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
            wrappedInvocation([DummyObject differentInvocationWithObjectArg:@"IRRELEVANT"]);
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
            "Mismatch in 1st argument. Expected \"WANTED\", but was \"ACTUAL\"\n"
            "Call stack:\n"
            "FAKE CALL STACK"));
}

@end
