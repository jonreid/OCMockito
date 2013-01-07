//
//  OCMockito - MKTProtocolMockTest.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

    // Test support
#import <SenTestingKit/SenTestingKit.h>

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


@interface PartialImplementer : NSObject <TestingProtocol>
@end

@implementation PartialImplementer

- (NSString *)required
{
    return nil;
}

@end


@interface FullImplementer : NSObject <TestingProtocol>
@end

@implementation FullImplementer

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

- (void)testMockShouldAnswerSameMethodSignatureForRequiredSelectorAsrealImplementer
{
    // given
    id <TestingProtocol> mockImplementer = mockProtocol(@protocol(TestingProtocol));
    PartialImplementer *realImplementer = [[PartialImplementer alloc] init];
    SEL selector = @selector(required);
    
    // when
    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:selector];
    
    // then
    HC_assertThat(signature, HC_equalTo([realImplementer methodSignatureForSelector:selector]));
}

- (void)testMockShouldAnswerSameMethodSignatureForOptionalSelectorAsRealImplementer
{
    // given
    id <TestingProtocol> mockImplementer = mockProtocol(@protocol(TestingProtocol));
    FullImplementer *realImplementer = [[FullImplementer alloc] init];
    SEL selector = @selector(optional);
    
    // when
    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:selector];
    
    // then
    HC_assertThat(signature, HC_equalTo([realImplementer methodSignatureForSelector:selector]));
}

- (void)testMethodSignatureForSelectorNotInProtocolShouldAnswerNil
{
    // given
    id <TestingProtocol> mockImplementer = mockProtocol(@protocol(TestingProtocol));
    SEL selector = @selector(objectAtIndex:);
    
    // when
    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:selector];
    
    // then
    HC_assertThat(signature, HC_nilValue());
}

- (void)testMockShouldConformToItsOwnProtocol
{
    // given
    id <TestingProtocol> mockImplementer = mockProtocol(@protocol(TestingProtocol));
    
    // then
    STAssertTrue([mockImplementer conformsToProtocol:@protocol(TestingProtocol)], nil);
}

- (void)testMockShouldConformToParentProtocol
{
    // given
    id <TestingProtocol> mockImplementer = mockProtocol(@protocol(TestingProtocol));
    
    // then
    STAssertTrue([mockImplementer conformsToProtocol:@protocol(NSObject)], nil);
}

- (void)testMockShouldNotConformToUnrelatedProtocol
{
    // given
    id <TestingProtocol> mockImplementer = mockProtocol(@protocol(TestingProtocol));
    
    // then
    STAssertFalse([mockImplementer conformsToProtocol:@protocol(NSCoding)], nil);
}

- (void)testMockShouldRespondToRequiredSelector
{
    // given
    id <TestingProtocol> mockImplementer = mockProtocol(@protocol(TestingProtocol));
    
    // then
    STAssertTrue([mockImplementer respondsToSelector:@selector(required)], nil);
}

- (void)testMockShouldRespondToOptionalSelector
{
    // given
    id <TestingProtocol> mockImplementer = mockProtocol(@protocol(TestingProtocol));
    
    // then
    STAssertTrue([mockImplementer respondsToSelector:@selector(optional)], nil);
}

- (void)testMockShouldNotRespondToUnrelatedSelector
{
    // given
    id <TestingProtocol> mockImplementer = mockProtocol(@protocol(TestingProtocol));
    
    // then
    STAssertFalse([mockImplementer respondsToSelector:@selector(objectAtIndex:)], nil);
}

@end
