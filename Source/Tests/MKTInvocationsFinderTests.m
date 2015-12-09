//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTMatchingInvocationsFinder.h"

#import "MKTInvocation.h"
#import "MKTInvocationMatcher.h"
#import "MKTLocation.h"

#import "MKTInvocationBuilder.h"
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
    simpleMethodInvocation = [[[MKTInvocationBuilder invocationBuilder] simpleMethod] buildMKTInvocation];
    simpleMethodInvocationTwo = [[[MKTInvocationBuilder invocationBuilder] simpleMethod] buildMKTInvocation];
    differentMethodInvocation = [[[MKTInvocationBuilder invocationBuilder] differentMethod] buildMKTInvocation];
    invocations = @[
            simpleMethodInvocation,
            simpleMethodInvocationTwo,
            differentMethodInvocation,
    ];
    wanted = [[[MKTInvocationBuilder invocationBuilder] simpleMethod] buildInvocationMatcher];
    sut = [[MKTMatchingInvocationsFinder alloc] init];
}

- (void)testFindInvocationsInList_ShouldCreateFinderWithMatchingInvocations
{
    [sut findInvocationsInList:invocations matching:wanted];

    NSArray *found = sut.invocations;
    
    assertThat(found, containsIn(@[
            sameInstance(simpleMethodInvocation), sameInstance(simpleMethodInvocationTwo) ]));
}

- (void)testCount_ShouldReturnNumberOfMatchingInvocations
{
    [sut findInvocationsInList:invocations matching:wanted];

    NSUInteger count = sut.count;
    
    assertThat(@(count), is(@2));
}

- (void)testCallStackOfInvocationAtIndex_WithIndex0
{
    [sut findInvocationsInList:invocations matching:wanted];

    NSArray *callStack = [sut callStackOfInvocationAtIndex:0];

    assertThat(callStack, is(sameInstance(simpleMethodInvocation.location.callStackSymbols)));
}

- (void)testLocationOfInvocationAtIndex_WithIndex0
{
    [sut findInvocationsInList:invocations matching:wanted];

    MKTLocation *location = [sut locationOfInvocationAtIndex:0];

    assertThat(location, is(sameInstance(simpleMethodInvocation.location)));
}

- (void)testCallStackOfInvocationAtIndex_WithIndex1
{
    [sut findInvocationsInList:invocations matching:wanted];

    NSArray *callStack = [sut callStackOfInvocationAtIndex:1];

    assertThat(callStack, is(sameInstance(simpleMethodInvocationTwo.location.callStackSymbols)));
}

- (void)testLocationOfInvocationAtIndex_WithIndex1
{
    [sut findInvocationsInList:invocations matching:wanted];

    MKTLocation *location = [sut locationOfInvocationAtIndex:1];

    assertThat(location, is(sameInstance(simpleMethodInvocationTwo.location)));
}

- (void)testCallStackOfLastInvocation
{
    [sut findInvocationsInList:invocations matching:wanted];

    NSArray *callStack = [sut callStackOfLastInvocation];

    assertThat(callStack, is(sameInstance(simpleMethodInvocationTwo.location.callStackSymbols)));
}

- (void)testLocationOfLastInvocation
{
    [sut findInvocationsInList:invocations matching:wanted];

    MKTLocation *location = [sut locationOfLastInvocation];

    assertThat(location, is(sameInstance(simpleMethodInvocationTwo.location)));
}

@end
