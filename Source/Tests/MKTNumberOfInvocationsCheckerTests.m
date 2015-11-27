//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTNumberOfInvocationsChecker.h"

#import "MKTInvocationsFinder.h"

#import "MKTInvocationBuilder.h"
#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>


@interface MockInvocationsFinder : MKTInvocationsFinder
@property (nonatomic, copy) NSArray *capturedInvocations;
@property (nonatomic, strong) MKTInvocationMatcher *capturedWanted;
@property (nonatomic, assign) NSUInteger stubbedCount;
@property (nonatomic, assign) NSUInteger capturedInvocationIndex;
@property (nonatomic, copy) NSArray *stubbedCallStackOfInvocationAtIndex;
@property (nonatomic, copy) NSArray *stubbedCallStackOfLastInvocation;
@end

@implementation MockInvocationsFinder

- (void)findInvocationsInList:(NSArray *)invocations matching:(MKTInvocationMatcher *)wanted
{
    self.capturedInvocations = invocations;
    self.capturedWanted = wanted;
}

- (NSUInteger)count
{
    return self.stubbedCount;
}

- (NSArray *)callStackOfInvocationAtIndex:(NSUInteger)index
{
    self.capturedInvocationIndex = index;
    return self.stubbedCallStackOfInvocationAtIndex;
}

- (NSArray *)callStackOfLastInvocation
{
    return self.stubbedCallStackOfLastInvocation;
}

@end


@interface MKTNumberOfInvocationsCheckerTests : XCTestCase
@end

@implementation MKTNumberOfInvocationsCheckerTests
{
    MockInvocationsFinder *mockInvocationsFinder;
    MKTNumberOfInvocationsChecker *sut;
}

- (void)setUp
{
    [super setUp];
    mockInvocationsFinder = [[MockInvocationsFinder alloc] init];
    sut = [[MKTNumberOfInvocationsChecker alloc] init];
    sut.invocationsFinder = mockInvocationsFinder;
}

- (void)tearDown
{
    sut = nil;
    [super tearDown];
}

- (void)testInvocationsFinder_Default
{
    MKTNumberOfInvocationsChecker *sut = [[MKTNumberOfInvocationsChecker alloc] init];

    MKTInvocationsFinder *finder = sut.invocationsFinder;

    assertThat(finder, isA([MKTInvocationsFinder class]));
}

- (void)testCheckInvocations_ShouldAskInvocationsFinderToFindMatchingInvocationsInList
{
    NSArray *invocations = @[ [[MKTInvocationBuilder invocationBuilder] buildMKTInvocation] ];
    MKTInvocationMatcher *wanted = [[MKTInvocationBuilder invocationBuilder] buildInvocationMatcher];

    [sut checkInvocations:invocations wanted:wanted wantedCount:1];

    assertThat(mockInvocationsFinder.capturedInvocations, is(sameInstance(invocations)));
    assertThat(mockInvocationsFinder.capturedWanted, is(sameInstance(wanted)));
}

- (void)testCheckInvocations_WithMatchingCount_ShouldReturnNil
{
    mockInvocationsFinder.stubbedCount = 100;

    NSString *description = [sut checkInvocations:nil wanted:nil wantedCount:100];

    assertThat(description, is(nilValue()));
}

- (void)testCheckInvocations_ShouldReportTooLittleActual
{
    mockInvocationsFinder.stubbedCount = 1;

    NSString *description = [sut checkInvocations:nil wanted:nil wantedCount:100];

    assertThat(description, is(@"Wanted 100 times but was called 1 time"));
}

- (void)testCheckInvocations_ShouldReportTooManyActual
{
    mockInvocationsFinder.stubbedCount = 100;

    NSString *description = [sut checkInvocations:nil wanted:nil wantedCount:1];

    assertThat(description, is(@"Wanted 1 time but was called 100 times"));
}

@end
