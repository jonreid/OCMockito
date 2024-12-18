// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "NSInvocation+OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
@import XCTest;


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

- (void)tearDown
{
    target = nil;
    invocation = nil;
    [super tearDown];
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

- (void)testArguments_ShouldCopyStackBlocks
{
    assertThat(@(invocation.argumentsRetained), isFalse());
    [invocation mkt_arguments];
    assertThat(@(invocation.argumentsRetained), isTrue());
}

@end
