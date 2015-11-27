//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationsFinder.h"

#import "MKTInvocation.h"
#import "MKTInvocationMatcher.h"

#import "MKTInvocationBuilder.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTInvocationsFinder (Testing)
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
    MKTInvocationsFinder *sut;
}

- (void)setUp
{
    [super setUp];
    simpleMethodInvocation = [[MKTInvocationBuilder invocationBuilder].simpleMethod buildMKTInvocation];
    simpleMethodInvocationTwo = [[MKTInvocationBuilder invocationBuilder].simpleMethod buildMKTInvocation];
    differentMethodInvocation = [[MKTInvocationBuilder invocationBuilder].differentMethod buildMKTInvocation];
    invocations = @[
            simpleMethodInvocation,
            simpleMethodInvocationTwo,
            differentMethodInvocation,
    ];
    wanted = [[MKTInvocationBuilder invocationBuilder].simpleMethod buildInvocationMatcher];
    sut = [[MKTInvocationsFinder alloc] init];
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

    assertThat(callStack, is(sameInstance(simpleMethodInvocation.callStackSymbols)));
}

- (void)testCallStackOfInvocationAtIndex_WithIndex1
{
    [sut findInvocationsInList:invocations matching:wanted];

    NSArray *callStack = [sut callStackOfInvocationAtIndex:1];

    assertThat(callStack, is(sameInstance(simpleMethodInvocationTwo.callStackSymbols)));
}

- (void)testCallStackOfLastInvocation
{
    [sut findInvocationsInList:invocations matching:wanted];

    NSArray *callStack = [sut callStackOfLastInvocation];

    assertThat(callStack, is(sameInstance(simpleMethodInvocationTwo.callStackSymbols)));
}

@end
