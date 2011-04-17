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
{
    MTInvocationMatcher *invocationMatcher;
}
@end


@implementation InvocationMatcherTest

- (void)setUp
{
    [super setUp];
    invocationMatcher = [[MTInvocationMatcher alloc] init];
}


- (void)tearDown
{
    [invocationMatcher release];
    [super tearDown];
}


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
    
    [invocationMatcher setExpected:expected];
    
    STAssertTrue([invocationMatcher matches:actual], nil);
}


- (void)testShouldMatchIfActualArgumentEqualsExpectedArgument
{
    NSInvocation *expected = [self invocationWithSingleObjectArgument:@"something"];
    NSInvocation *actual = [self invocationWithSingleObjectArgument:@"something"];
    
    [invocationMatcher setExpected:expected];
    
    STAssertTrue([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchIfActualArgumentMatchesArgumentExpectation
{
    id <HCMatcher> argumentExpectation = equalTo(@"something");
    NSInvocation *expected = [self invocationWithSingleObjectArgument:argumentExpectation];
    NSInvocation *actual = [self invocationWithSingleObjectArgument:@"different"];
    
    [invocationMatcher setExpected:expected];
    
    STAssertFalse([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchIfActualArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [self invocationWithSingleObjectArgument:@"something"];
    NSInvocation *actual = [self invocationWithSingleObjectArgument:@"different"];
    
    [invocationMatcher setExpected:expected];
    
    STAssertFalse([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchIfArgumentsMatchButSelectorsDiffer
{
    id <HCMatcher> argumentExpectation = equalTo(@"something");
    NSInvocation *expected = [self invocationWithSingleObjectArgument:argumentExpectation];
    NSInvocation *actual = [self invocationWithSingleObjectArgument:@"something"];
    [actual setSelector:@selector(removeObject:)];
    [expected setSelector:@selector(removeObjectForKey:)];
    
    [invocationMatcher setExpected:expected];
    
    STAssertFalse([invocationMatcher matches:actual], nil);
}


- (void)testShouldMatchNoArgumentInvocationsIfSelectorsMatch
{
    NSInvocation *expected = [self noArgumentInvocationWithSelector:@selector(removeAllObjects)];
    NSInvocation *actual = [self noArgumentInvocationWithSelector:@selector(removeAllObjects)];
    
    [invocationMatcher setExpected:expected];
    
    STAssertTrue([invocationMatcher matches:actual], nil);
}


@end
