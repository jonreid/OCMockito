//
//  OCMockito - MKTClassObjectMockTest.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: David Hart
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


@interface MKTClassObjectMockTest : SenTestCase
@end

@implementation MKTClassObjectMockTest
{
    Class mockStringClass;
}

- (void)setUp
{
    [super setUp];
    mockStringClass = mockClass([NSString class]);
}

- (void)testMockShouldAnswerSameMethodSignatureForSelectorAsRealObject
{
    // given
    Class realStringClass = [NSString class];
    SEL selector = @selector(string);
    
    // when
    NSMethodSignature *signature = [mockStringClass methodSignatureForSelector:selector];
    
    // then
    assertThat(signature, is(equalTo([realStringClass methodSignatureForSelector:selector])));
}

- (void)testMethodSignatureForSelectorNotInClassShouldAnswerNil
{
    // given
    SEL selector = @selector(rangeOfString:options:);
    
    // when
    NSMethodSignature *signature = [mockStringClass methodSignatureForSelector:selector];
    
    // then
    assertThat(signature, is(nilValue()));
}

- (void)testMockShouldRespondToKnownSelector
{
    STAssertTrue([mockStringClass respondsToSelector:@selector(pathWithComponents:)], nil);
}

- (void)testMockShouldNotRespondToUnknownSelector
{
    STAssertFalse([mockStringClass respondsToSelector:@selector(pathExtension)], nil);
}

@end
