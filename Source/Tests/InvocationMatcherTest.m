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
    id <HCMatcher> argumentExpectation = equalTo(@"something");
    NSInvocation *expected = [self invocationWithSingleObjectArgument:argumentExpectation];
    NSInvocation *actual = [self invocationWithSingleObjectArgument:@"something"];
    
    MTInvocationMatcher *invocationMatcher = [[[MTInvocationMatcher alloc]
                                               initWithExpectedInvocation:expected] autorelease];
    
    STAssertTrue([invocationMatcher matches:actual], nil);
}


- (void)testShouldMatchIfActualArgumentEqualsExpectedArgument
{
    NSInvocation *expected = [self invocationWithSingleObjectArgument:@"something"];
    NSInvocation *actual = [self invocationWithSingleObjectArgument:@"something"];
    
    MTInvocationMatcher *invocationMatcher = [[[MTInvocationMatcher alloc]
                                               initWithExpectedInvocation:expected] autorelease];
    
    STAssertTrue([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchIfActualArgumentMatchesArgumentExpectation
{
    id <HCMatcher> argumentExpectation = equalTo(@"something");
    NSInvocation *expected = [self invocationWithSingleObjectArgument:argumentExpectation];
    NSInvocation *actual = [self invocationWithSingleObjectArgument:@"different"];
    
    MTInvocationMatcher *invocationMatcher = [[[MTInvocationMatcher alloc]
                                               initWithExpectedInvocation:expected] autorelease];
    
    STAssertFalse([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchIfActualArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [self invocationWithSingleObjectArgument:@"something"];
    NSInvocation *actual = [self invocationWithSingleObjectArgument:@"different"];
    
    MTInvocationMatcher *invocationMatcher = [[[MTInvocationMatcher alloc]
                                               initWithExpectedInvocation:expected] autorelease];
    
    STAssertFalse([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchIfArgumentsMatchButSelectorsDiffer
{
    id <HCMatcher> argumentExpectation = equalTo(@"something");
    NSInvocation *expected = [self invocationWithSingleObjectArgument:argumentExpectation];
    NSInvocation *actual = [self invocationWithSingleObjectArgument:@"something"];
    [actual setSelector:@selector(removeObject:)];
    [expected setSelector:@selector(removeObjectForKey:)];
    
    MTInvocationMatcher *invocationMatcher = [[[MTInvocationMatcher alloc]
                                               initWithExpectedInvocation:expected] autorelease];
    
    STAssertFalse([invocationMatcher matches:actual], nil);
}


- (void)testShouldMatchNoArgumentInvocationsIfSelectorsMatch
{
    NSInvocation *expected = [self noArgumentInvocationWithSelector:@selector(removeAllObjects)];
    NSInvocation *actual = [self noArgumentInvocationWithSelector:@selector(removeAllObjects)];
    
    MTInvocationMatcher *invocationMatcher = [[[MTInvocationMatcher alloc]
                                               initWithExpectedInvocation:expected] autorelease];
    
    STAssertTrue([invocationMatcher matches:actual], nil);
}


@end
