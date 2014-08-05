//
//  OCMockito - MKTObjectMockTests.m
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


@interface MKTObjectMockTests : SenTestCase
@end

@implementation MKTObjectMockTests
{
    NSString *mockString;
}

- (void)setUp
{
    [super setUp];
    mockString = mock([NSString class]);
}

- (void)testDescription
{
    assertThat([mockString description], is(@"mock object of NSString"));
}

- (void)testMock_ShouldAnswerSameMethodSignatureForSelectorAsRealObject
{
    NSString *realString = [NSString string];
    SEL selector = @selector(rangeOfString:options:);
    NSMethodSignature *signature = [mockString methodSignatureForSelector:selector];
    assertThat(signature, is(equalTo([realString methodSignatureForSelector:selector])));
}

- (void)testMethodSignatureForSelectorNotInObject_ShouldAnswerNil
{
    SEL selector = @selector(objectAtIndex:);
    NSMethodSignature *signature = [mockString methodSignatureForSelector:selector];
    assertThat(signature, is(nilValue()));
}

- (void)testMock_ShouldBeKindOfSameClass
{
    STAssertTrue([mockString isKindOfClass:[NSString class]], nil);
}

- (void)testMock_ShouldBeKindOfSubclass
{
    NSString *mockMutableString = mock([NSMutableString class]);
    STAssertTrue([mockMutableString isKindOfClass:[NSString class]], nil);
}

- (void)testMock_ShouldNotBeKindOfDifferentClass
{
    STAssertFalse([mockString isKindOfClass:[NSArray class]], nil);
}

- (void)testMock_ShouldRespondToKnownSelector
{
    STAssertTrue([mockString respondsToSelector:@selector(substringFromIndex:)], nil);
}

- (void)testMock_ShouldNotRespondToUnknownSelector
{
    STAssertFalse([mockString respondsToSelector:@selector(removeAllObjects)], nil);
}

@end
