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
}

- (void)setUp
{
    [super setUp];
    simpleMethodInvocation = [MKTInvocationBuilder simpleMethod];
    simpleMethodInvocationTwo = [MKTInvocationBuilder simpleMethod];
    differentMethodInvocation = [MKTInvocationBuilder differentMethod];
    invocations = @[
            simpleMethodInvocation,
            simpleMethodInvocationTwo,
            differentMethodInvocation,
    ];
    wanted = [[MKTInvocationMatcher alloc] init];
    [wanted setExpectedInvocation:simpleMethodInvocation.invocation];
}

- (void)testFindInvocationsInList_ShouldCreateFinderWithMatchingInvocations
{
    MKTInvocationsFinder *sut = [MKTInvocationsFinder findInvocationsInList:invocations matching:wanted];

    NSArray *found = sut.invocations;
    
    assertThat(found, containsIn(@[
            sameInstance(simpleMethodInvocation), sameInstance(simpleMethodInvocationTwo) ]));
}

- (void)testCount_ShouldReturnNumberOfMatchingInvocations
{
    MKTInvocationsFinder *sut = [MKTInvocationsFinder findInvocationsInList:invocations matching:wanted];

    NSUInteger count = sut.count;
    
    assertThat(@(count), is(@2));
}

- (void)testCallStackOfInvocationAtIndex_WithIndex0
{
    MKTInvocationsFinder *sut = [MKTInvocationsFinder findInvocationsInList:invocations matching:wanted];

    NSArray *callStack = [sut callStackOfInvocationAtIndex:0];

    assertThat(callStack, is(sameInstance(simpleMethodInvocation.callStackSymbols)));
}

- (void)testCallStackOfInvocationAtIndex_WithIndex1
{
    MKTInvocationsFinder *sut = [MKTInvocationsFinder findInvocationsInList:invocations matching:wanted];

    NSArray *callStack = [sut callStackOfInvocationAtIndex:1];

    assertThat(callStack, is(sameInstance(simpleMethodInvocationTwo.callStackSymbols)));
}

- (void)testCallStackOfLastInvocation
{
    MKTInvocationsFinder *sut = [MKTInvocationsFinder findInvocationsInList:invocations matching:wanted];

    NSArray *callStack = [sut callStackOfLastInvocation];

    assertThat(callStack, is(sameInstance(simpleMethodInvocationTwo.callStackSymbols)));
}

@end
