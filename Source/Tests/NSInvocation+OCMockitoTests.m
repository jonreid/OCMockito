//
//  OCMockito - NSInvocation_OCMockitoTests.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "NSInvocation+OCMockito.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface NSInvocation_OCMockitoTests : SenTestCase
@end

@implementation NSInvocation_OCMockitoTests
{
    NSMutableArray *target;
    NSInvocation *invocation;
}

- (void)setUp
{
    [super setUp];
    target = [[NSMutableArray alloc] init];
    SEL selector = @selector(count);
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
}

- (void)testRetainArgumentsWithWeakTarget_ShouldRetainArguments
{
    [invocation setTarget:target];

    [invocation mkt_retainArgumentsWithWeakTarget];

    STAssertTrue([invocation argumentsRetained], nil);
}

- (void)testRetainArgumentsWithWeakTarget_ShouldReplaceTargetWithWeakProxy
{
    [invocation setTarget:target];

    [invocation mkt_retainArgumentsWithWeakTarget];

    assertThat([invocation target], hasDescription(containsString(@"WeakProxy")));
}

- (void)testRetainArgumentsWithWeakTarget_ShouldNotReplaceTargetOnSecondCall
{
    [invocation setTarget:target];
    [invocation mkt_retainArgumentsWithWeakTarget];
    id weakProxy = [invocation target];

    [invocation mkt_retainArgumentsWithWeakTarget];

    assertThat([invocation target], is(sameInstance(weakProxy)));
}

@end
