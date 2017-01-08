//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


typedef struct {
  int aMember;
} SimpleStruct;

@protocol ReturningProtocol <NSObject>

- (id)methodReturningObject;
- (id)methodReturningObjectWithArg:(id)arg;
- (id)methodReturningObjectWithIntArg:(int)arg;
- (BOOL)methodReturningBOOL;
- (short)methodReturningShort;
- (SimpleStruct)methodReturningStruct;

@end


@interface StubProtocolTests : XCTestCase
{
    id <ReturningProtocol> myMockProtocol;
}
@end

@implementation StubProtocolTests

- (void)setUp
{
    [super setUp];
    myMockProtocol = mockProtocol(@protocol(ReturningProtocol));
}

- (void)tearDown
{
    myMockProtocol = nil;
    [super tearDown];
}

- (void)testStubbedMethodReturningObject_ShouldReturnGivenObject
{
    [given([myMockProtocol methodReturningObject]) willReturn:@"STUBBED"];

    assertThat([myMockProtocol methodReturningObject], is(@"STUBBED"));
}

- (void)testUnstubbedMethodReturningObject_ShouldReturnNil
{
    assertThat([myMockProtocol methodReturningObject], is(nilValue()));
}

- (void)testStubbedMethodReturningObject_WithDifferentArgs_ShouldReturnValueForMatchingArgument
{
    [given([myMockProtocol methodReturningObjectWithArg:@"foo"]) willReturn:@"FOO"];
    [given([myMockProtocol methodReturningObjectWithArg:@"bar"]) willReturn:@"BAR"];

    assertThat([myMockProtocol methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}

- (void)testStub_ShouldAcceptArgumentMatchers
{
    [given([myMockProtocol methodReturningObjectWithArg:equalTo(@"foo")]) willReturn:@"FOO"];
    assertThat([myMockProtocol methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}

- (void)testStubbedMethodWithPrimitiveNumericArg_ShouldReturnValueForMatchingArgument
{
    [given([myMockProtocol methodReturningObjectWithIntArg:1]) willReturn:@"FOO"];
    [given([myMockProtocol methodReturningObjectWithIntArg:2]) willReturn:@"BAR"];

    assertThat([myMockProtocol methodReturningObjectWithIntArg:1], is(@"FOO"));
}

- (void)testStub_ShouldAcceptMatcherForNumericArgument
{
    [[given([myMockProtocol methodReturningObjectWithIntArg:0])
            withMatcher:greaterThan(@1) forArgument:0] willReturn:@"FOO"];

    assertThat([myMockProtocol methodReturningObjectWithIntArg:2], is(@"FOO"));
}

- (void)testShouldSupportShortcutForSpecifyingMatcherForFirstArgument
{
    [[given([myMockProtocol methodReturningObjectWithIntArg:0])
            withMatcher:greaterThan(@1)]
            willReturn:@"FOO"];

    assertThat([myMockProtocol methodReturningObjectWithIntArg:2], is(@"FOO"));
}

- (void)testStubbedMethodReturningBool_ShouldReturnGivenValue
{
    [given([myMockProtocol methodReturningBOOL]) willReturn:@YES];
    assertThat(@([myMockProtocol methodReturningBOOL]), is(@YES));
}

- (void)testStubbedMethodReturningShort_ShouldReturnGivenValue
{
    [given([myMockProtocol methodReturningShort]) willReturn:@42];
    assertThat(@([myMockProtocol methodReturningShort]), is(@42));
}

- (void)testStubbedMethodReturningStruct_ShouldReturnGivenValue
{
    SimpleStruct someStruct = { 123 };
    [given([myMockProtocol methodReturningStruct]) willReturnStruct:&someStruct
                                                           objCType:@encode(SimpleStruct)];

    SimpleStruct otherStruct = [myMockProtocol methodReturningStruct];

    assertThat(@(otherStruct.aMember), is(@123));
}

@end
