//
//  OCMockito - MKTClassMockTest.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
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


@interface MKTClassMockTest : SenTestCase
@end

@implementation MKTClassMockTest

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
