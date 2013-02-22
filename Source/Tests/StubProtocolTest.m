//
//  OCMockito - StubProtocolTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
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


@protocol ReturningProtocol <NSObject>

- (id)methodReturningObject;
- (id)methodReturningObjectWithArg:(id)arg;
- (id)methodReturningObjectWithIntArg:(int)arg;
- (short)methodReturningShort;

@end


#pragma mark -

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

- (void)testStubbedMethodShouldReturnGivenObject
{
    // when
    [given([mockProtocol methodReturningObject]) willReturn:@"STUBBED"];
    
    // then
    assertThat([mockProtocol methodReturningObject], is(@"STUBBED"));
}

- (void)testUnstubbedMethodReturningObjectShouldReturnNil
{
    assertThat([mockProtocol methodReturningObject], is(nilValue()));
}

- (void)testStubsWithDifferentArgsShouldHaveDifferentReturnValues
{
    // when
    [given([mockProtocol methodReturningObjectWithArg:@"foo"]) willReturn:@"FOO"];
    [given([mockProtocol methodReturningObjectWithArg:@"bar"]) willReturn:@"BAR"];
    
    // then
    assertThat([mockProtocol methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}

- (void)testStubShouldAcceptArgumentMatchers
{
    // when
    [given([mockProtocol methodReturningObjectWithArg:equalTo(@"foo")]) willReturn:@"FOO"];
    
    // then
    assertThat([mockProtocol methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}

- (void)testStubShouldReturnValueForMatchingNumericArgument
{
    // when
    [given([mockProtocol methodReturningObjectWithIntArg:1]) willReturn:@"FOO"];
    [given([mockProtocol methodReturningObjectWithIntArg:2]) willReturn:@"BAR"];
    
    // then
    assertThat([mockProtocol methodReturningObjectWithIntArg:1], is(@"FOO"));
}

- (void)testStubShouldAcceptMatcherForNumericArgument
{
    // when
    [[given([mockProtocol methodReturningObjectWithIntArg:0])
      withMatcher:greaterThan(@1) forArgument:0] willReturn:@"FOO"];
    
    // then
    assertThat([mockProtocol methodReturningObjectWithIntArg:2], is(@"FOO"));
}

- (void)testShouldSupportShortcutForSpecifyingMatcherForFirstArgument
{
    // when
    [[given([mockProtocol methodReturningObjectWithIntArg:0])
      withMatcher:greaterThan(@1)] willReturn:@"FOO"];
    
    // then
    assertThat([mockProtocol methodReturningObjectWithIntArg:2], is(@"FOO"));
}

- (void)testStubbedMethodShouldReturnGivenShort
{
    // when
    [given([mockProtocol methodReturningShort]) willReturnShort:42];
    
    // then
    assertThatShort([mockProtocol methodReturningShort], equalToShort(42));
}

@end
