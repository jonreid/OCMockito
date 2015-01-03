//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTCapturingMatcher.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface MKTCapturingMatcherTests : SenTestCase
@end

@implementation MKTCapturingMatcherTests
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

- (void)testAllValues_ShouldCaptureArgumentsInOrder
{
    [sut captureArgument:@"FOO"];
    [sut captureArgument:@"BAR"];

    assertThat([sut allValues], contains(@"FOO", @"BAR", nil));
}

- (void)testNilArgument_ShouldBeConvertedToNSNull
{
    [sut captureArgument:@"FOO"];
    [sut captureArgument:nil];

    assertThat([sut allValues], contains(@"FOO", [NSNull null], nil));
}

- (void)testMatcher_ShouldKnowLastCapturedValue
{
    [sut captureArgument:@"FOO"];
    [sut captureArgument:@"BAR"];

    assertThat([sut lastValue], is(@"BAR"));
}

- (void)testLastValue_ShouldHandleNilArgument
{
    [sut captureArgument:@"FOO"];
    [sut captureArgument:nil];

    assertThat([sut lastValue], is(nilValue()));
}

- (void)testMatcher_ShouldComplainWhenNothingYetCaptured
{
    STAssertThrows([sut lastValue], @"lastValue should fail when no argument value was captured");
}

@end
