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
    MockInvocationsFinder *mockInvocationsFinder = [[MockInvocationsFinder alloc] init];
    MKTNumberOfInvocationsChecker *sut = [[MKTNumberOfInvocationsChecker alloc] init];
    sut.invocationsFinder = mockInvocationsFinder;

    [sut checkInvocations:invocations wanted:wanted wantedCount:100];

    XCTAssertEqual(mockInvocationsFinder.capturedInvocations, invocations);
    XCTAssertEqual(mockInvocationsFinder.capturedWanted, wanted);
}

@end
