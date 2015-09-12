//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "NSInvocation+OCMockito.h"

// Test support
#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface NSInvocation_OCMockitoTests : XCTestCase
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

    XCTAssertTrue([invocation argumentsRetained]);
}

- (void)testRetainArgumentsWithWeakTarget_ShouldReplaceTargetWithWeakProxy
{
    [invocation setTarget:target];

    [invocation mkt_retainArgumentsWithWeakTarget];

    assertThat([invocation target], hasDescription(containsSubstring(@"WeakProxy")));
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
