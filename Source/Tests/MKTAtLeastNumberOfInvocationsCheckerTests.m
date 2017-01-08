//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "MKTAtLeastNumberOfInvocationsChecker.h"

#import "MKTInvocation.h"
#import "MKTInvocationMatcher.h"
#import "MKTLocation.h"

#import "DummyObject.h"
#import "MockInvocationsFinder.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTAtLeastNumberOfInvocationsCheckerDefaultsTests : XCTestCase
@end

@implementation MKTAtLeastNumberOfInvocationsCheckerDefaultsTests

- (void)testInvocationsFinder_ShouldDefaultToMKTInvocationsFinder
{
    MKTAtLeastNumberOfInvocationsChecker *sut = [[MKTAtLeastNumberOfInvocationsChecker alloc] init];

    MKTMatchingInvocationsFinder *finder = sut.invocationsFinder;

    assertThat(finder, isA([MKTMatchingInvocationsFinder class]));
}

@end


@interface MKTAtLeastNumberOfInvocationsCheckerTests : XCTestCase
@end

@implementation MKTAtLeastNumberOfInvocationsCheckerTests
{
    MockInvocationsFinder *mockInvocationsFinder;
    MKTAtLeastNumberOfInvocationsChecker *sut;
    NSArray *dummyInvocations;
    MKTInvocationMatcher *dummyWanted;
}

- (void)setUp
{
    [super setUp];
    mockInvocationsFinder = [[MockInvocationsFinder alloc] init];
    sut = [[MKTAtLeastNumberOfInvocationsChecker alloc] init];
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

- (void)testCheckInvocations_WithGreaterCount_ShouldReturnNil
{
    mockInvocationsFinder.stubbedCount = 10;

    NSString *description = [sut checkInvocations:dummyInvocations wanted:dummyWanted wantedCount:5];

    assertThat(description, is(nilValue()));
}

- (void)testCheckInvocations_WithMatchingCount_ShouldReturnNil
{
    mockInvocationsFinder.stubbedCount = 5;

    NSString *description = [sut checkInvocations:dummyInvocations wanted:dummyWanted wantedCount:5];

    assertThat(description, is(nilValue()));
}

- (void)testCheckInvocations_ShouldReportTooLittleActual
{
    mockInvocationsFinder.stubbedCount = 1;

    NSString *description = [sut checkInvocations:dummyInvocations wanted:dummyWanted wantedCount:100];

    assertThat(description, containsSubstring(@"Wanted at least 100 times but was called 1 time."));
}

- (NSArray *)generateCallStack:(NSArray *)callStack
{
    NSArray *callStackPreamble = @[
            @"3   ExampleTests                        0x0000000118446bee -[MKTBaseMockObject forwardInvocation:] + 91",
            @"4   CoreFoundation                      0x000000010e9f9d07 ___forwarding___ + 487",
            @"5   CoreFoundation                      0x000000010e9f9a98 _CF_forwarding_prep_0 + 120" ];
    return [callStackPreamble arrayByAddingObjectsFromArray:callStack];
}

- (void)testCheckInvocations_WithTooLittleActual_ShouldIncludeFilteredStackTraceOfLastInvocation
{
    mockInvocationsFinder.stubbedCount = 2;
    mockInvocationsFinder.stubbedLocationOfLastInvocation = [[MKTLocation alloc] initWithCallStack:
            [self generateCallStack:@[
                    @"6   ExampleTests                        0x0000000118430edc CALLER",
                    @"7   ExampleTests                        0x0000000118430edc PREVIOUS",
                    @"8   XCTest                              0x0000000118430edc IRRELEVANT",
            ]]];

    NSString *description = [sut checkInvocations:dummyInvocations wanted:dummyWanted wantedCount:100];

    assertThat(description, containsSubstring(
            @"Last invocation:\n"
                    "ExampleTests CALLER\n"
                    "ExampleTests PREVIOUS"));
}

@end
