//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


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


@interface StubProtocolTests : SenTestCase
{
    id <ReturningProtocol> mockProtocol;
}
@end

@implementation StubProtocolTests

- (void)setUp
{
    [super setUp];
    mockProtocol = mockProtocol(@protocol(ReturningProtocol));
}

- (void)testStubbedMethodReturningObject_ShouldReturnGivenObject
{
    [given([self->mockProtocol methodReturningObject]) willReturn:@"STUBBED"];

    assertThat([mockProtocol methodReturningObject], is(@"STUBBED"));
}

- (void)testUnstubbedMethodReturningObject_ShouldReturnNil
{
    assertThat([mockProtocol methodReturningObject], is(nilValue()));
}

- (void)testStubbedMethodReturningObject_WithDifferentArgs_ShouldReturnValueForMatchingArgument
{
    [given([self->mockProtocol methodReturningObjectWithArg:@"foo"]) willReturn:@"FOO"];
    [given([self->mockProtocol methodReturningObjectWithArg:@"bar"]) willReturn:@"BAR"];

    assertThat([mockProtocol methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}

- (void)testStub_ShouldAcceptArgumentMatchers
{
    [given([self->mockProtocol methodReturningObjectWithArg:equalTo(@"foo")]) willReturn:@"FOO"];
    assertThat([mockProtocol methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}

- (void)testStubbedMethodWithPrimitiveNumericArg_ShouldReturnValueForMatchingArgument
{
    [given([self->mockProtocol methodReturningObjectWithIntArg:1]) willReturn:@"FOO"];
    [given([self->mockProtocol methodReturningObjectWithIntArg:2]) willReturn:@"BAR"];

    assertThat([mockProtocol methodReturningObjectWithIntArg:1], is(@"FOO"));
}

- (void)testStub_ShouldAcceptMatcherForNumericArgument
{
    [[given([self->mockProtocol methodReturningObjectWithIntArg:0])
            withMatcher:greaterThan(@1) forArgument:0] willReturn:@"FOO"];

    assertThat([mockProtocol methodReturningObjectWithIntArg:2], is(@"FOO"));
}

- (void)testShouldSupportShortcutForSpecifyingMatcherForFirstArgument
{
    [[given([self->mockProtocol methodReturningObjectWithIntArg:0])
            withMatcher:greaterThan(@1)]
            willReturn:@"FOO"];

    assertThat([mockProtocol methodReturningObjectWithIntArg:2], is(@"FOO"));
}

- (void)testStubbedMethodReturningBool_ShouldReturnGivenValue
{
    [given([self->mockProtocol methodReturningBOOL]) willReturn:@YES];
    assertThat(@([mockProtocol methodReturningBOOL]), is(@YES));
}

- (void)testStubbedMethodReturningShort_ShouldReturnGivenValue
{
    [given([self->mockProtocol methodReturningShort]) willReturn:@42];
    assertThat(@([mockProtocol methodReturningShort]), is(@42));
}

- (void)testStubbedMethodReturningStruct_ShouldReturnGivenValue
{
    SimpleStruct someStruct = { 123 };
    [given([self->mockProtocol methodReturningStruct]) willReturnStruct:&someStruct
                                                         objCType:@encode(SimpleStruct)];

    SimpleStruct otherStruct = [mockProtocol methodReturningStruct];

    assertThat(@(otherStruct.aMember), is(@123));
}

@end
