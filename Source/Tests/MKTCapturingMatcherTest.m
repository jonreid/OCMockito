//
//  OCMockito - MKTCapturingMatcherTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by Markus Gasser on 18.04.12.
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTCapturingMatcher.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface MKTCapturingMatcherTest : SenTestCase
@end

@implementation MKTCapturingMatcherTest
{
    MKTCapturingMatcher *sut;
}

- (void)setUp
{
    [super setUp];
    sut = [[MKTCapturingMatcher alloc] init];
}

- (void)tearDown
{
    sut = nil;
    [super tearDown];
}

- (void)testMatcher_ShouldAlwaysEvaluateToTrue
{
    STAssertTrue([sut matches:nil], nil);
    STAssertTrue([sut matches:[[NSObject alloc] init]], nil);
}

- (void)testMatcherDescription
{
    assertThat([sut description], is(@"<Capturing argument>"));
}

- (void)testMatcher_ShouldCaptureArguments
{
    [sut captureArgument:@"foo"];
    [sut captureArgument:@"bar"];
    assertThat([sut allValues], contains(@"foo", @"bar", nil));
}

- (void)testCaptureArguments_ShouldHandleNilArgument
{
    [sut captureArgument:@"foo"];
    [sut captureArgument:nil];
    assertThat([sut allValues], contains(@"foo", [NSNull null], nil));
}

- (void)testMatcher_ShouldKnowLastCapturedValue
{
    [sut captureArgument:@"foo"];
    [sut captureArgument:@"bar"];
    assertThat([sut lastValue], is(@"bar"));
}

- (void)testLastValue_ShouldHandleNilArgument
{
    [sut captureArgument:@"foo"];
    [sut captureArgument:nil];
    assertThat([sut lastValue], is(nilValue()));
}

- (void)testMatcher_ShouldComplainWhenNothingYetCaptured
{
    STAssertThrows([sut lastValue], @"lastValue should fail when no argument value was captured");
}

@end
