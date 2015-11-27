//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTNumberOfInvocationsChecker.h"

#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTInvocationsFinder.h"
#import "MKTVerificationData.h"

#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>


@interface MockInvocationsFinder : MKTInvocationsFinder
@property (nonatomic, copy) NSArray *invocations;
@property (nonatomic, strong) MKTInvocationMatcher *wanted;
@property (nonatomic, assign) NSUInteger stubbedCount;
@property (nonatomic, assign) NSUInteger invocationIndex;
@property (nonatomic, copy) NSArray *stubbedCallStackOfInvocationAtIndex;
@property (nonatomic, copy) NSArray *stubbedCallStackOfLastInvocation;
@end

@implementation MockInvocationsFinder

+ (instancetype)findInvocationsInList:(NSArray *)invocations matching:(MKTInvocationMatcher *)wanted
{
    MockInvocationsFinder *finder = [[MockInvocationsFinder alloc] init];
    finder.invocations = invocations;
    finder.wanted = wanted;
    return finder;
}

- (NSUInteger)count
{
    return self.stubbedCount;
}

- (NSArray *)callStackOfInvocationAtIndex:(NSUInteger)index
{
    self.invocationIndex = index;
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

- (void)testShouldReportTooLittleActual
{
    MKTInvocationContainer *invocationContainer = [[MKTInvocationContainer alloc] init];
    MKTInvocationMatcher *invocationMatcher = [[MKTInvocationMatcher alloc] init];
    MKTVerificationData *data = [[MKTVerificationData alloc] initWithInvocationContainer:invocationContainer invocationMatcher:invocationMatcher];
    MockInvocationsFinder *mockInvocationsFinder = [[MockInvocationsFinder alloc] init];

    MKTNumberOfInvocationsChecker *sut = [[MKTNumberOfInvocationsChecker alloc] init];
    sut.invocationsFinder = mockInvocationsFinder;
}

@end
