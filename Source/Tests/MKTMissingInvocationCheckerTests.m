//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTMissingInvocationChecker.h"

#import "MKTInvocation.h"
#import "MKTInvocationBuilder.h"

#import "MockInvocationsFinder.h"
#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>


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
    MKTInvocation *invocation = [[[MKTInvocationBuilder invocationBuilder] simpleMethod] buildMKTInvocation];
    MKTInvocationMatcher *invocationMatcher = [[[MKTInvocationBuilder invocationBuilder] differentMethod] buildInvocationMatcher];
    
    MKTInvocation *(^findSimilar)(NSArray *, MKTInvocationMatcher *) = sut.findSimilarInvocation;
    MKTInvocation *similar = findSimilar(@[ invocation ], invocationMatcher);

    assertThat(similar, is(nilValue()));
}

- (void)testFindSimilarInvocationBlock_WithSameSelectorsButDifferentArgs_ShouldReturnFirstMatch
{
    MKTInvocation *otherInvocation = [[[MKTInvocationBuilder invocationBuilder] simpleMethod] buildMKTInvocation];
    MKTInvocation *invocationSimilar = [[[MKTInvocationBuilder invocationBuilder] methodWithArg:@"FOO"] buildMKTInvocation];
    MKTInvocationMatcher *invocationMatcher = [[[MKTInvocationBuilder invocationBuilder] methodWithArg:@"BAR"] buildInvocationMatcher];

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
    NSArray *invocations = @[ [[MKTInvocationBuilder invocationBuilder] buildMKTInvocation] ];
    MKTInvocationMatcher *wanted = [[MKTInvocationBuilder invocationBuilder] buildInvocationMatcher];

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

@end
