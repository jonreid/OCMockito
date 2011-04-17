//
//  OCMockito - InvocationMatcherTest.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

    // Class under test
#import "MTInvocationMatcher.h"

    // Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface InvocationMatcherTest : SenTestCase
@end


@implementation InvocationMatcherTest

- (NSInvocation *)invocationWithSingleObjectArgument:(id)argument
{
    SEL selector = @selector(removeObject:);
    NSMethodSignature *methodSignature = [[NSMutableArray class]
                                          instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setArgument:&argument atIndex:2];
    return invocation;
}


- (NSInvocation *)noArgumentInvocationWithSelector:(SEL)selector
{
    SEL noArgumentSelector = @selector(removeAllObjects);
    NSMethodSignature *methodSignature = [[NSMutableArray class]
                                          instanceMethodSignatureForSelector:noArgumentSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setSelector:selector];
    return invocation;
}


- (void)testShouldMatchIfActualArgumentMatchesArgumentExpectation
{
    // given
    id <HCMatcher> argumentExpectation = equalTo(@"something");
    NSInvocation *expected = [self invocationWithSingleObjectArgument:argumentExpectation];
    NSInvocation *actual = [self invocationWithSingleObjectArgument:@"something"];

    // when
    MTInvocationMatcher *invocationMatcher = [[[MTInvocationMatcher alloc]
                                               initWithExpectedInvocation:expected] autorelease];

    // then
    STAssertTrue([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchIfActualArgumentMatchesArgumentExpectation
{
    // given
    id <HCMatcher> argumentExpectation = equalTo(@"something");
    NSInvocation *expected = [self invocationWithSingleObjectArgument:argumentExpectation];
    NSInvocation *actual = [self invocationWithSingleObjectArgument:@"different"];
    
    // when
    MTInvocationMatcher *invocationMatcher = [[[MTInvocationMatcher alloc]
                                               initWithExpectedInvocation:expected] autorelease];
    
    // then
    STAssertFalse([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchIfArgumentsMatchButSelectorsDiffer
{
    // given
    id <HCMatcher> argumentExpectation = equalTo(@"something");
    NSInvocation *expected = [self invocationWithSingleObjectArgument:argumentExpectation];
    NSInvocation *actual = [self invocationWithSingleObjectArgument:@"something"];
    [actual setSelector:@selector(removeObject:)];
    [expected setSelector:@selector(removeObjectForKey:)];
    
    // when
    MTInvocationMatcher *invocationMatcher = [[[MTInvocationMatcher alloc]
                                               initWithExpectedInvocation:expected] autorelease];
    
    // then
    STAssertFalse([invocationMatcher matches:actual], nil);
}


- (void)testShouldMatchNoArgumentInvocationsIfSelectorsMatch
{
    // given
    NSInvocation *expected = [self noArgumentInvocationWithSelector:@selector(removeAllObjects)];
    NSInvocation *actual = [self noArgumentInvocationWithSelector:@selector(removeAllObjects)];
    
    // when
    MTInvocationMatcher *invocationMatcher = [[[MTInvocationMatcher alloc]
                                               initWithExpectedInvocation:expected] autorelease];
    
    // then
    STAssertTrue([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchNoArgumentInvocationsIfSelectorsDiffer
{
    // given
    NSInvocation *expected = [self noArgumentInvocationWithSelector:@selector(removeAllObjects)];
    NSInvocation *actual = [self noArgumentInvocationWithSelector:@selector(hash)];
    
    // when
    MTInvocationMatcher *invocationMatcher = [[[MTInvocationMatcher alloc]
                                               initWithExpectedInvocation:expected] autorelease];
    
    // then
    STAssertFalse([invocationMatcher matches:actual], nil);
}


@end
