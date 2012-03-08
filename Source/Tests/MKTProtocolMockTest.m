//
//  OCMockito - MKTProtocolMockTest.m
//  Copyright 2012 eBay Inc. All rights reserved.
//
//  Created by: Jon Reid
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


@protocol TestingProtocol <NSObject>

@required
- (NSString *)required;

@optional
- (NSString *)optional;

@end


@interface PartialImplementor : NSObject <TestingProtocol>
@end

@implementation PartialImplementor

- (NSString *)required
{
    return nil;
}

@end


@interface FullImplementor : NSObject <TestingProtocol>
@end

@implementation FullImplementor

- (NSString *)required
{
    return nil;
}

- (NSString *)optional
{
    return nil;
}

@end


#pragma mark -

@interface MKTProtocolMockTest : SenTestCase
@end


@implementation MKTProtocolMockTest

- (void)testMockShouldAnswerSameMethodSignatureForRequiredSelectorAsRealImplementor
{
    // given
    id <TestingProtocol> mockImplementor = mockProtocol(@protocol(TestingProtocol));
    PartialImplementor *realImplementor = [[[PartialImplementor alloc] init] autorelease];
    SEL selector = @selector(required);
    
    // when
    NSMethodSignature *signature = [(id)mockImplementor methodSignatureForSelector:selector];
    
    // then
    assertThat(signature, is(equalTo([realImplementor methodSignatureForSelector:selector])));
}

- (void)testMockShouldAnswerSameMethodSignatureForOptionalSelectorAsRealImplementor
{
    // given
    id <TestingProtocol> mockImplementor = mockProtocol(@protocol(TestingProtocol));
    FullImplementor *realImplementor = [[[FullImplementor alloc] init] autorelease];
    SEL selector = @selector(optional);
    
    // when
    NSMethodSignature *signature = [(id)mockImplementor methodSignatureForSelector:selector];
    
    // then
    assertThat(signature, is(equalTo([realImplementor methodSignatureForSelector:selector])));
}

@end
