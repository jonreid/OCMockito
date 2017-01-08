//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "MKTMatchingInvocationsFinder.h"

#import "MKTInvocation.h"
#import "MKTInvocationMatcher.h"

#import "DummyObject.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTMatchingInvocationsFinder (Testing)
@property (nonatomic, copy) NSArray *invocations;
@end


@interface MKTInvocationsFinderTests : XCTestCase
@end

@implementation MKTInvocationsFinderTests
{
    MKTInvocation *simpleMethodInvocation;
    MKTInvocation *simpleMethodInvocationTwo;
    MKTInvocation *differentMethodInvocation;
    NSArray *invocations;
    MKTInvocationMatcher *wanted;
    MKTMatchingInvocationsFinder *sut;
}

- (void)setUp
{
    [super setUp];
    simpleMethodInvocation = wrappedInvocation([DummyObject invocationWithNoArgs]);
    simpleMethodInvocationTwo = wrappedInvocation([DummyObject invocationWithNoArgs]);
    differentMethodInvocation = wrappedInvocation([DummyObject differentInvocationWithNoArgs]);
    invocations = @[
            simpleMethodInvocation,
            simpleMethodInvocationTwo,
            differentMethodInvocation,
    ];
    wanted = matcherForInvocation([DummyObject invocationWithNoArgs]);
    sut = [[MKTMatchingInvocationsFinder alloc] init];
}

- (void)tearDown
{
    simpleMethodInvocation = nil;
    simpleMethodInvocationTwo = nil;
    differentMethodInvocation = nil;
    invocations = nil;
    wanted = nil;
    sut = nil;
    [super tearDown];
}

- (void)testFindInvocationsInList_ShouldCreateFinderWithMatchingInvocations
{
    [sut findInvocationsInList:invocations matching:wanted];

    NSArray *found = sut.invocations;
    
    assertThat(found, containsIn(@[
            sameInstance(simpleMethodInvocation), sameInstance(simpleMethodInvocationTwo) ]));
}

- (void)testFindInvocationsInList_ShouldExcludeVerifiedInvocations
{
    simpleMethodInvocation.verified = YES;
    [sut findInvocationsInList:invocations matching:wanted];
    
    NSArray *found = sut.invocations;
    
    assertThat(found, containsIn(@[ sameInstance(simpleMethodInvocationTwo) ]));
}

- (void)testCount_ShouldReturnNumberOfMatchingInvocations
{
    [sut findInvocationsInList:invocations matching:wanted];

    NSUInteger count = sut.count;
    
    assertThat(@(count), is(@2));
}

- (void)testLocationOfInvocationAtIndex_WithIndex0
{
    [sut findInvocationsInList:invocations matching:wanted];

    MKTLocation *location = [sut locationOfInvocationAtIndex:0];

    assertThat(location, is(sameInstance(simpleMethodInvocation.location)));
}

- (void)testLocationOfInvocationAtIndex_WithIndex1
{
    [sut findInvocationsInList:invocations matching:wanted];

    MKTLocation *location = [sut locationOfInvocationAtIndex:1];

    assertThat(location, is(sameInstance(simpleMethodInvocationTwo.location)));
}

- (void)testLocationOfLastInvocation
{
    [sut findInvocationsInList:invocations matching:wanted];

    MKTLocation *location = [sut locationOfLastInvocation];

    assertThat(location, is(sameInstance(simpleMethodInvocationTwo.location)));
}

@end
