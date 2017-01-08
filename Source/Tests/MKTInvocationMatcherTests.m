//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationMatcher.h"

#import "DummyObject.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


#pragma mark -

@interface MKTInvocationMatcherTests : XCTestCase
{
    MKTInvocationMatcher *sut;
}
@end

@implementation MKTInvocationMatcherTests

- (void)setUp
{
    [super setUp];
    sut = [[MKTInvocationMatcher alloc] init];
}

- (void)tearDown
{
    sut = nil;
    [super tearDown];
}

- (void)testInvocationWithNoArgs_WithSameSelectors_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithNoArgs]];

    XCTAssertTrue([sut matches:[DummyObject invocationWithNoArgs]]);
}

- (void)testInvocationWithNoArgs_WithDifferentSelectors_ShouldNotMatch
{
    NSInvocation *expected = [DummyObject invocationWithNoArgs];
    NSInvocation *actual = [DummyObject differentInvocationWithNoArgs];

    [sut setExpectedInvocation:expected];

    XCTAssertFalse([sut matches:actual]);
}

- (void)testInvocationWithObjectArg_WithEqualArgs_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithObjectArg:@"something"]];

    XCTAssertTrue([sut matches:[DummyObject invocationWithObjectArg:@"something"]]);
}

- (void)testInvocationWithObjectArg_WithNilArgs_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithObjectArg:nil]];

    XCTAssertTrue([sut matches:[DummyObject invocationWithObjectArg:nil]]);
}

- (void)testInvocationWithObjectArg_WithDifferentArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithObjectArg:@"something"]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithObjectArg:@"different"]]);
}

- (void)testInvocationWithObjectArg_WithEqualArgsButDifferentSelectors_ShouldNotMatch
{
    NSInvocation *expected = [DummyObject invocationWithObjectArg:@"something"];
    NSInvocation *actual = [DummyObject differentInvocationWithObjectArg:@"something"];

    [sut setExpectedInvocation:expected];

    XCTAssertFalse([sut matches:actual]);
}

- (void)testInvocationWithObjectArg_WithArgumentSatisfyingMatcher_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithObjectArg:equalTo(@"something")]];

    XCTAssertTrue([sut matches:[DummyObject invocationWithObjectArg:@"something"]]);
}

- (void)testInvocationWithObjectArg_WithOverrideMatcherNotSatisfied_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithObjectArg:equalTo(@"something")]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithObjectArg:@"different"]]);
}

- (void)testInvocationWithBoolArg_WithEqualArgs_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithBoolArg:YES]];

    XCTAssertTrue([sut matches:[DummyObject invocationWithBoolArg:YES]]);
}

- (void)testInvocationWithBoolArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithBoolArg:NO]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithBoolArg:YES]]);
}

- (void)testInvocationWithCharArg_WithEqualArgs_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithCharArg:'a']];

    XCTAssertTrue([sut matches:[DummyObject invocationWithCharArg:'a']]);
}

- (void)testInvocationWithCharArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithCharArg:'a']];

    XCTAssertFalse([sut matches:[DummyObject invocationWithCharArg:'z']]);
}

- (void)testInvocationWithCharArg_WithOverrideMatcherNotSatisfied_ShouldNotMatch
{
    [sut setMatcher:lessThan(@'n') atIndex:0];
    [sut setExpectedInvocation:[DummyObject invocationWithCharArg:0]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithCharArg:'z']]);
}

- (void)testInvocationWithIntArg_WithEqualArgs_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithIntArg:42]];

    XCTAssertTrue([sut matches:[DummyObject invocationWithIntArg:42]]);
}

- (void)testInvocationWithIntArg_WithOverrideMatcherNotSatisfied_ShouldNotMatch
{
    [sut setMatcher:lessThan(@50) atIndex:0];
    [sut setExpectedInvocation:[DummyObject invocationWithCharArg:0]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithCharArg:51]]);
}

- (void)testInvocationWithIntArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithShortArg:42]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithShortArg:99]]);
}

- (void)testInvocationWithLongArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithLongArg:42]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithLongArg:99]]);
}

- (void)testInvocationWithLongLongArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithLongLongArg:42]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithLongLongArg:99]]);
}

- (void)testInvocationWithIntegerArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithIntegerArg:42]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithIntegerArg:99]]);
}

- (void)testInvocationWithUnsignedCharArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithUnsignedCharArg:42]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithUnsignedCharArg:99]]);
}

- (void)testInvocationWithUnsignedIntArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithUnsignedIntArg:42]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithUnsignedIntArg:99]]);
}

- (void)testInvocationWithUnsignedShortArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithUnsignedShortArg:42]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithUnsignedShortArg:99]]);
}

- (void)testShouldNotMatchIfUnsignedLongArgumentDoesNotEqualExpectedArgument
{
    [sut setExpectedInvocation:[DummyObject invocationWithUnsignedLongArg:42]];
    XCTAssertFalse([sut matches:[DummyObject invocationWithUnsignedLongArg:99]]);
}

- (void)testInvocationWithUnsignedLongLongArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithUnsignedLongLongArg:42]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithUnsignedLongLongArg:99]]);
}

- (void)testInvocationWithUnsignedIntegerArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithUnsignedIntegerArg:42]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithUnsignedIntegerArg:99]]);
}

- (void)testInvocationWithFloatArg_WithOverrideMatcherNotSatisfied_ShouldNotMatch
{
    [sut setMatcher:closeTo(3.5, 0.1) atIndex:0];
    [sut setExpectedInvocation:[DummyObject invocationWithFloatArg:0]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithFloatArg:3.14f]]);
}

- (void)testInvocationWithDoubleArg_WithOverrideMatcherNotSatisfied_ShouldNotMatch
{
    [sut setMatcher:closeTo(3.5, 0.1) atIndex:0];
    [sut setExpectedInvocation:[DummyObject invocationWithDoubleArg:0]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithDoubleArg:3.14]]);
}

- (void)testInvocation_WithOverrideMatcherForSecondArgumentSatisfied_ShouldMatch
{
    [sut setMatcher:greaterThan(@50) atIndex:1];
    [sut setExpectedInvocation:[DummyObject invocationWithObjectArg:@"something" intArg:0]];

    XCTAssertTrue([sut matches:[DummyObject invocationWithObjectArg:@"something" intArg:51]]);
}

- (void)testInvocationWithMultiplePrimitiveArgs_WithAllArgsEqual_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithIntArg:0 floatArg:3.14f]];

    XCTAssertTrue([sut matches:[DummyObject invocationWithIntArg:0 floatArg:3.14f]]);
}

- (void)testInvocationWithMultiplePrimitiveArgs_WithFirstArgsUnequal_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithIntArg:0 floatArg:3.14f]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithIntArg:99 floatArg:3.14f]]);
}

- (void)testInvocationWithMultiplePrimitiveArgs_WithSecondArgsUnequal_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithIntArg:0 floatArg:3.14f]];

    XCTAssertFalse([sut matches:[DummyObject invocationWithIntArg:0 floatArg:2.718f]]);
}

- (void)testArgumentMatchersCount_ShouldReflectLargestSetMatcherIndex
{
    [sut setMatcher:equalTo(@"IRRELEVANT") atIndex:1];
    [sut setMatcher:equalTo(@"IRRELEVANT") atIndex:0];

    assertThat(sut.matchers, hasCountOf(2));
}

@end
