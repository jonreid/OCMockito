//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationsFinder.h"

#import "MKTInvocation.h"
#import "MKTInvocationMatcher.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTInvocationsFinder (Testing)
@property (nonatomic, copy) NSArray *invocations;
@end


@interface MKTInvocationsFinderTests : XCTestCase
@end

@implementation MKTInvocationsFinderTests
{
    NSArray *target;
    MKTInvocation *simpleMethodInvocation;
    MKTInvocation *simpleMethodInvocationTwo;
    MKTInvocation *differentMethodInvocation;
    MKTInvocationMatcher *wanted;
}

- (void)setUp
{
    [super setUp];
    target = [[NSArray alloc] init];
    simpleMethodInvocation = [self invocationWithSelector:@selector(count)];
    simpleMethodInvocationTwo = [self invocationWithSelector:@selector(count)];
    differentMethodInvocation = [self invocationWithSelector:@selector(lastObject)];
    wanted = [[MKTInvocationMatcher alloc] init];
}

- (MKTInvocation *)invocationWithSelector:(SEL)selector
{
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
    return [[MKTInvocation alloc] initWithInvocation:invocation];
}

- (void)testFindInvocationsInList_ShouldCreateFinderWithMatchingInvocations
{
    NSArray *invocations = @[
            simpleMethodInvocation,
            simpleMethodInvocationTwo,
            differentMethodInvocation,
    ];
    [wanted setExpectedInvocation:simpleMethodInvocation.invocation];
    
    MKTInvocationsFinder *sut = [MKTInvocationsFinder findInvocationsInList:invocations
                                                                   matching:wanted];
    NSArray *found = sut.invocations;
    
    assertThat(found, containsIn(@[
            sameInstance(simpleMethodInvocation), sameInstance(simpleMethodInvocationTwo) ]));
}

- (void)testCount_ShouldReturnNumberOfMatchingInvocations
{
    NSArray *invocations = @[
            simpleMethodInvocation,
            simpleMethodInvocationTwo,
            differentMethodInvocation,
    ];
    [wanted setExpectedInvocation:simpleMethodInvocation.invocation];

    MKTInvocationsFinder *sut = [MKTInvocationsFinder findInvocationsInList:invocations
                                                                   matching:wanted];
    NSUInteger count = sut.count;
    
    assertThat(@(count), is(@2));
}

@end
