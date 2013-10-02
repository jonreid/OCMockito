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

- (void)testMock_ShouldAnswerSameMethodSignatureForRequiredSelectorAsrealImplementer
{
    PartialImplementer *realImplementer = [[PartialImplementer alloc] init];
    SEL selector = @selector(required);
    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:selector];
    assertThat(signature, equalTo([realImplementer methodSignatureForSelector:selector]));
}

- (void)testMock_ShouldAnswerSameMethodSignatureForOptionalSelectorAsRealImplementer
{
    FullImplementer *realImplementer = [[FullImplementer alloc] init];
    SEL selector = @selector(optional);
    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:selector];
    assertThat(signature, equalTo([realImplementer methodSignatureForSelector:selector]));
}

- (void)testMethodSignatureForSelectorNotInProtocol_ShouldAnswerNil
{
    SEL selector = @selector(objectAtIndex:);
    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:selector];
    assertThat(signature, is(nilValue()));
}

- (void)testMock_ShouldConformToItsOwnProtocol
{
    STAssertTrue([mockImplementer conformsToProtocol:@protocol(TestingProtocol)], nil);
}

- (void)testMock_ShouldConformToParentProtocol
{
    STAssertTrue([mockImplementer conformsToProtocol:@protocol(NSObject)], nil);
}

- (void)testMock_ShouldNotConformToUnrelatedProtocol
{
    STAssertFalse([mockImplementer conformsToProtocol:@protocol(NSCoding)], nil);
}

- (void)testMock_ShouldRespondToRequiredSelector
{
    STAssertTrue([mockImplementer respondsToSelector:@selector(required)], nil);
}

- (void)testMock_ShouldRespondToOptionalSelector
{
    STAssertTrue([mockImplementer respondsToSelector:@selector(optional)], nil);
}

- (void)testMock_ShouldNotRespondToUnrelatedSelector
{
    STAssertFalse([mockImplementer respondsToSelector:@selector(objectAtIndex:)], nil);
}

@end
