//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTCapturingMatcher.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTCapturingMatcherTests : XCTestCase
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
    XCTAssertTrue([sut matches:nil]);
    XCTAssertTrue([sut matches:[[NSObject alloc] init]]);
}

- (void)testMatcherDescription
{
    assertThat([sut description], is(@"<Capturing argument>"));
}

- (void)testAllValues_ShouldCaptureArgumentsInOrder
{
    [sut matches:@"FOO"];
    [sut matches:@"BAR"];

    assertThat([sut allValues], contains(@"FOO", @"BAR", nil));
}

- (void)testNilArgument_ShouldBeConvertedToNSNull
{
    [sut matches:@"FOO"];
    [sut matches:nil];

    assertThat([sut allValues], contains(@"FOO", [NSNull null], nil));
}

- (void)testMatcher_ShouldKnowLastCapturedValue
{
    [sut matches:@"FOO"];
    [sut matches:@"BAR"];

    assertThat([sut lastValue], is(@"BAR"));
}

- (void)testLastValue_ShouldHandleNilArgument
{
    [sut matches:@"FOO"];
    [sut matches:nil];

    assertThat([sut lastValue], is(nilValue()));
}

- (void)testMatcher_ShouldComplainWhenNothingYetCaptured
{
    XCTAssertThrows([sut lastValue], @"lastValue should fail when no argument value was captured");
}

@end
