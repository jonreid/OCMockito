//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "MKTAtMostNumberOfInvocationsChecker.h"

#import "MKTInvocation.h"
#import "MKTInvocationMatcher.h"
#import "MKTLocation.h"
#import "MockInvocationsFinder.h"

#import "DummyObject.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTAtMostNumberOfInvocationsCheckerDefaultsTests : XCTestCase
@end

@implementation MKTAtMostNumberOfInvocationsCheckerDefaultsTests

- (void)testInvocationsFinder_ShouldDefaultToMKTInvocationsFinder
{
    MKTAtMostNumberOfInvocationsChecker *sut = [[MKTAtMostNumberOfInvocationsChecker alloc] init];

    MKTMatchingInvocationsFinder *finder = sut.invocationsFinder;

    assertThat(finder, isA([MKTMatchingInvocationsFinder class]));
}

@end


@interface MKTAtMostNumberOfInvocationsCheckerTests : XCTestCase
@end

@implementation MKTAtMostNumberOfInvocationsCheckerTests
{
    MockInvocationsFinder *mockInvocationsFinder;
    MKTAtMostNumberOfInvocationsChecker *sut;
    NSArray *dummyInvocations;
    MKTInvocationMatcher *dummyWanted;
}

- (void)setUp
{
    [super setUp];
    mockInvocationsFinder = [[MockInvocationsFinder alloc] init];
    sut = [[MKTAtMostNumberOfInvocationsChecker alloc] init];
    sut.invocationsFinder = mockInvocationsFinder;
    dummyInvocations = [[NSArray alloc] init];
    dummyWanted = [[MKTInvocationMatcher alloc] init];
}

- (void)tearDown
{
    mockInvocationsFinder = nil;
    sut = nil;
    dummyInvocations = nil;
    dummyWanted = nil;
    [super tearDown];
}

- (void)testCheckInvocations_ShouldAskInvocationsFinderToFindMatchingInvocationsInList
{
    NSArray *invocations = @[ wrappedInvocation([DummyObject invocationWithNoArgs]) ];
    MKTInvocationMatcher *wanted = matcherForInvocation([DummyObject invocationWithNoArgs]);

    [sut checkInvocations:invocations wanted:wanted wantedCount:1];

    assertThat(mockInvocationsFinder.capturedInvocations, is(sameInstance(invocations)));
    assertThat(mockInvocationsFinder.capturedWanted, is(sameInstance(wanted)));
}

- (void)testCheckInvocations_WithLesserCount_ShouldReturnNil
{
    mockInvocationsFinder.stubbedCount = 5;

    NSString *description = [sut checkInvocations:dummyInvocations wanted:dummyWanted wantedCount:10];

    assertThat(description, is(nilValue()));
}

- (void)testCheckInvocations_WithMatchingCount_ShouldReturnNil
{
    mockInvocationsFinder.stubbedCount = 10;

    NSString *description = [sut checkInvocations:dummyInvocations wanted:dummyWanted wantedCount:10];

    assertThat(description, is(nilValue()));
}

- (void)testCheckInvocations_ShouldReportTooManyActual
{
    mockInvocationsFinder.stubbedCount = 100;

    NSString *description = [sut checkInvocations:dummyInvocations wanted:dummyWanted wantedCount:1];

    assertThat(description, containsSubstring(@"Wanted at most 1 time but was called 100 times."));
}

- (NSArray *)generateCallStack:(NSArray *)callStack
{
    NSArray *callStackPreamble = @[
            @"3   ExampleTests                        0x0000000118446bee -[MKTBaseMockObject forwardInvocation:] + 91",
            @"4   CoreFoundation                      0x000000010e9f9d07 ___forwarding___ + 487",
            @"5   CoreFoundation                      0x000000010e9f9a98 _CF_forwarding_prep_0 + 120" ];
    return [callStackPreamble arrayByAddingObjectsFromArray:callStack];
}

- (void)testCheckInvocations_WithTooManyActual_ShouldAskInvocationsFinderForCallStackOfFirstUndesiredInvocation
{
    mockInvocationsFinder.stubbedCount = 2;

    [sut checkInvocations:dummyInvocations wanted:dummyWanted wantedCount:1];

    assertThat(@(mockInvocationsFinder.capturedInvocationIndex), is(@1));
}

- (void)testCheckInvocations_WithTooManyActual_ShouldIncludeFilteredStackTraceOfUndesiredInvocation
{
    mockInvocationsFinder.stubbedCount = 2;
    mockInvocationsFinder.stubbedLocationOfInvocationAtIndex = [[MKTLocation alloc] initWithCallStack:
            [self generateCallStack:@[
                    @"6   ExampleTests                        0x0000000118430edc CALLER",
                    @"7   ExampleTests                        0x0000000118430edc PREVIOUS",
                    @"8   XCTest                              0x0000000118430edc IRRELEVANT",
            ]]];

    NSString *description = [sut checkInvocations:dummyInvocations wanted:dummyWanted wantedCount:1];

    assertThat(description, containsSubstring(
            @"Undesired invocation:\n"
                    "ExampleTests CALLER\n"
                    "ExampleTests PREVIOUS"));
}

- (void)testCheckInvocations_ShouldReportNeverWanted
{
    mockInvocationsFinder.stubbedCount = 100;

    NSString *description = [sut checkInvocations:dummyInvocations wanted:dummyWanted wantedCount:0];

    assertThat(description, containsSubstring(@"Never wanted but was called 100 times."));
}

@end
