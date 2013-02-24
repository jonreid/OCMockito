//
//  OCMockito - MKTProtocolMockTest.m
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
{
    id <TestingProtocol> mockImplementer;
}

- (void)setUp
{
    [super setUp];
    mockImplementer = mockProtocol(@protocol(TestingProtocol));
}

- (void)testDescription
{
    assertThat([mockImplementer description], is(@"mock implementer of TestingProtocol protocol"));
}

- (void)testMockShouldAnswerSameMethodSignatureForRequiredSelectorAsrealImplementer
{
    // given
    PartialImplementer *realImplementer = [[PartialImplementer alloc] init];
    SEL selector = @selector(required);
    
    // when
    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:selector];
    
    // then
    assertThat(signature, equalTo([realImplementer methodSignatureForSelector:selector]));
}

- (void)testMockShouldAnswerSameMethodSignatureForOptionalSelectorAsRealImplementer
{
    // given
    FullImplementer *realImplementer = [[FullImplementer alloc] init];
    SEL selector = @selector(optional);
    
    // when
    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:selector];
    
    // then
    assertThat(signature, equalTo([realImplementer methodSignatureForSelector:selector]));
}

- (void)testMethodSignatureForSelectorNotInProtocolShouldAnswerNil
{
    // given
    SEL selector = @selector(objectAtIndex:);
    
    // when
    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:selector];
    
    // then
    assertThat(signature, is(nilValue()));
}

- (void)testMockShouldConformToItsOwnProtocol
{
    STAssertTrue([mockImplementer conformsToProtocol:@protocol(TestingProtocol)], nil);
}

- (void)testMockShouldConformToParentProtocol
{
    STAssertTrue([mockImplementer conformsToProtocol:@protocol(NSObject)], nil);
}

- (void)testMockShouldNotConformToUnrelatedProtocol
{
    STAssertFalse([mockImplementer conformsToProtocol:@protocol(NSCoding)], nil);
}

- (void)testMockShouldRespondToRequiredSelector
{
    STAssertTrue([mockImplementer respondsToSelector:@selector(required)], nil);
}

- (void)testMockShouldRespondToOptionalSelector
{
    STAssertTrue([mockImplementer respondsToSelector:@selector(optional)], nil);
}

- (void)testMockShouldNotRespondToUnrelatedSelector
{
    STAssertFalse([mockImplementer respondsToSelector:@selector(objectAtIndex:)], nil);
}

@end
