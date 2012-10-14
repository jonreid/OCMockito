//
//  OCMockito - MKTObjectMockTest.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
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


@interface MKTObjectMockTest : SenTestCase
@end

@implementation MKTObjectMockTest

- (void)testMockShouldAnswerSameMethodSignatureForSelectorAsRealObject
{
    // given
    NSString *mockString = mock([NSString class]);
    NSString *realString = [NSString string];
    SEL selector = @selector(rangeOfString:options:);
    
    // when
    NSMethodSignature *signature = [mockString methodSignatureForSelector:selector];
    
    // then
    assertThat(signature, is(equalTo([realString methodSignatureForSelector:selector])));
}

- (void)testMethodSignatureForSelectorNotInClassShouldAnswerNil
{
    // given
    NSString *mockString = mock([NSString class]);
    SEL selector = @selector(objectAtIndex:);
    
    // when
    NSMethodSignature *signature = [mockString methodSignatureForSelector:selector];
    
    // then
    assertThat(signature, is(nilValue()));
}

- (void)testMockShouldBeKindOfSameClass
{
    // given
    NSString *mockString = mock([NSString class]);
    
    //then
    STAssertTrue([mockString isKindOfClass:[NSString class]], nil);
}

- (void)testMockShouldBeKindOfSubclass
{
    // given
    NSString *mockString = mock([NSMutableString class]);
    
    //then
    STAssertTrue([mockString isKindOfClass:[NSString class]], nil);
}

- (void)testMockShouldNotBeKindOfDifferentClass
{
    // given
    NSString *mockString = mock([NSString class]);
    
    //then
    STAssertFalse([mockString isKindOfClass:[NSArray class]], nil);
}

- (void)testMockShouldRespondToKnownSelector
{
    // given
    NSString *mockString = mock([NSString class]);
    
    // then
    STAssertTrue([mockString respondsToSelector:@selector(substringFromIndex:)], nil);
}

- (void)testMockShouldNotRespondToUnknownSelector
{
    // given
    NSString *mockString = mock([NSString class]);
    
    // then
    STAssertFalse([mockString respondsToSelector:@selector(removeAllObjects)], nil);
}

@end
