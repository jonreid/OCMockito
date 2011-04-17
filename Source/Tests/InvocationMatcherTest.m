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


@interface DummyObject : NSObject
@end

@implementation DummyObject

- (void)methodWithNoArgs {}
- (void)differentMethodWithNoArgs {}

- (void)methodWithObjectArg:(id)arg {}
- (void)differentMethodWithObjectArg:(id)arg {}

- (void)methodWithBoolArg:(BOOL)arg {}

@end


#pragma mark -

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


- (NSInvocation *)invocationWithNoArgsWithSelector:(SEL)selector
{
    SEL noArgumentSelector = @selector(methodWithNoArgs);
    NSMethodSignature *methodSignature = [[DummyObject class]
                                          instanceMethodSignatureForSelector:noArgumentSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setSelector:selector];
    return invocation;
}


- (NSInvocation *)invocationWithObjectArg:(id)argument
{
    SEL selector = @selector(methodWithObjectArg:);
    NSMethodSignature *methodSignature = [[DummyObject class]
                                          instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setArgument:&argument atIndex:2];
    return invocation;
}


- (NSInvocation *)invocationWithBoolArg:(BOOL)argument
{
    SEL selector = @selector(methodWithBoolArg:);
    NSMethodSignature *methodSignature = [[DummyObject class]
                                          instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setArgument:&argument atIndex:2];
    return invocation;
}


- (void)testShouldMatchNoArgumentInvocationsIfSelectorsMatch
{
    NSInvocation *expected = [self invocationWithNoArgsWithSelector:@selector(methodWithNoArgs)];
    NSInvocation *actual = [self invocationWithNoArgsWithSelector:@selector(methodWithNoArgs)];
    
    [invocationMatcher setExpectedInvocation:expected];
    
    STAssertTrue([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchNoArgumentInvocationsIfSelectorsDiffer
{
    NSInvocation *expected = [self invocationWithNoArgsWithSelector:@selector(methodWithNoArgs)];
    NSInvocation *actual = [self invocationWithNoArgsWithSelector:@selector(differentMethodWithNoArgs)];
    
    [invocationMatcher setExpectedInvocation:expected];
    
    STAssertFalse([invocationMatcher matches:actual], nil);
}


- (void)testShouldMatchIfObjectArgumentEqualsExpectedArgument
{
    NSInvocation *expected = [self invocationWithObjectArg:@"something"];
    NSInvocation *actual = [self invocationWithObjectArg:@"something"];
    
    [invocationMatcher setExpectedInvocation:expected];
    
    STAssertTrue([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchIfObjectArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [self invocationWithObjectArg:@"something"];
    NSInvocation *actual = [self invocationWithObjectArg:@"different"];
    
    [invocationMatcher setExpectedInvocation:expected];
    
    STAssertFalse([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchIfArgumentsMatchButSelectorsDiffer
{
    NSInvocation *expected = [self invocationWithObjectArg:@"something"];
    NSInvocation *actual = [self invocationWithObjectArg:@"something"];
    [actual setSelector:@selector(methodWithObjectArg:)];
    [expected setSelector:@selector(differentMethodWithObjectArg:)];
    
    [invocationMatcher setExpectedInvocation:expected];
    
    STAssertFalse([invocationMatcher matches:actual], nil);
}


- (void)testShouldMatchIfObjectArgumentSatisfiesArgumentExpectation
{
    id <HCMatcher> argumentExpectation = equalTo(@"something");
    NSInvocation *expected = [self invocationWithObjectArg:argumentExpectation];
    NSInvocation *actual = [self invocationWithObjectArg:@"something"];
    
    [invocationMatcher setExpectedInvocation:expected];
    
    STAssertTrue([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchIfObjectArgumentDoesNotSatisfyArgumentExpectation
{
    id <HCMatcher> argumentExpectation = equalTo(@"something");
    NSInvocation *expected = [self invocationWithObjectArg:argumentExpectation];
    NSInvocation *actual = [self invocationWithObjectArg:@"different"];
    
    [invocationMatcher setExpectedInvocation:expected];
    
    STAssertFalse([invocationMatcher matches:actual], nil);
}


- (void)testShouldMatchIfBoolArgumentEqualsExpectedArgument
{
    NSInvocation *expected = [self invocationWithBoolArg:YES];
    NSInvocation *actual = [self invocationWithBoolArg:YES];
    
    [invocationMatcher setExpectedInvocation:expected];
    
    STAssertTrue([invocationMatcher matches:actual], nil);
}


- (void)testShouldNotMatchIfBoolArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [self invocationWithBoolArg:NO];
    NSInvocation *actual = [self invocationWithBoolArg:YES];
    
    [invocationMatcher setExpectedInvocation:expected];
    
    STAssertFalse([invocationMatcher matches:actual], nil);
}


@end
