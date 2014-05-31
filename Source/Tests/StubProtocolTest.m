//
//  OCMockito - StubProtocolTest.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


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


@interface StubProtocolTest : SenTestCase
{
    id <ReturningProtocol> mockProtocol;
}
@end

@implementation StubProtocolTest

- (void)setUp
{
    [super setUp];
    mockProtocol = mockProtocol(@protocol(ReturningProtocol));
}

- (void)testStubbedMethod_ShouldReturnGivenObject
{
    [given([mockProtocol methodReturningObject]) willReturn:@"STUBBED"];
    assertThat([mockProtocol methodReturningObject], is(@"STUBBED"));
}

- (void)testUnstubbedMethodReturningObject_ShouldReturnNil
{
    assertThat([mockProtocol methodReturningObject], is(nilValue()));
}

- (void)testStubsWithDifferentArgs_ShouldHaveDifferentReturnValues
{
    [given([mockProtocol methodReturningObjectWithArg:@"foo"]) willReturn:@"FOO"];
    [given([mockProtocol methodReturningObjectWithArg:@"bar"]) willReturn:@"BAR"];
    assertThat([mockProtocol methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}

- (void)testStub_ShouldAcceptArgumentMatchers
{
    [given([mockProtocol methodReturningObjectWithArg:equalTo(@"foo")]) willReturn:@"FOO"];
    assertThat([mockProtocol methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}

- (void)testStub_ShouldReturnValueForMatchingNumericArgument
{
    [given([mockProtocol methodReturningObjectWithIntArg:1]) willReturn:@"FOO"];
    [given([mockProtocol methodReturningObjectWithIntArg:2]) willReturn:@"BAR"];
    assertThat([mockProtocol methodReturningObjectWithIntArg:1], is(@"FOO"));
}

- (void)testStub_ShouldAcceptMatcherForNumericArgument
{
    [[given([mockProtocol methodReturningObjectWithIntArg:0])
            withMatcher:greaterThan(@1) forArgument:0] willReturn:@"FOO"];
    assertThat([mockProtocol methodReturningObjectWithIntArg:2], is(@"FOO"));
}

- (void)testShouldSupportShortcutForSpecifyingMatcherForFirstArgument
{
    [[given([mockProtocol methodReturningObjectWithIntArg:0])
            withMatcher:greaterThan(@1)] willReturn:@"FOO"];
    assertThat([mockProtocol methodReturningObjectWithIntArg:2], is(@"FOO"));
}

- (void)testStubbedMethod_ShouldReturnGivenStruct
{
    SimpleStruct someStruct = { 123 };

    [given([mockProtocol methodReturningStruct]) willReturnStruct:&someStruct
                                                         objCType:@encode(SimpleStruct)];
    SimpleStruct otherStruct = [mockProtocol methodReturningStruct];

    assertThat(@(otherStruct.aMember), is(@123));
}

- (void)testStubbedMethod_ShouldReturnGivenBool
{
    [given([mockProtocol methodReturningBOOL]) willReturn:@YES];
    assertThat(@([mockProtocol methodReturningBOOL]), is(@YES));
}

- (void)testStubbedMethod_ShouldReturnGivenShort
{
    [given([mockProtocol methodReturningShort]) willReturn:@42];
    assertThat(@([mockProtocol methodReturningShort]), is(@42));
}

@end
