//
//  OCMockito - MKTProtocolMockTests.m
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
#import <OCHamcrest/OCHamcrest.h>


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


@interface MKTProtocolMockTests : SenTestCase
@end

@implementation MKTProtocolMockTests
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

- (void)testShouldAnswerSameMethodSignatureForRequiredSelectorAsRealImplementer
{
    PartialImplementer *realImplementer = [[PartialImplementer alloc] init];
    SEL sel = @selector(required);

    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:sel];

    assertThat(signature, equalTo([realImplementer methodSignatureForSelector:sel]));
}

- (void)testShouldAnswerSameMethodSignatureForOptionalSelectorAsRealImplementer
{
    FullImplementer *realImplementer = [[FullImplementer alloc] init];
    SEL sel = @selector(optional);

    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:sel];

    assertThat(signature, equalTo([realImplementer methodSignatureForSelector:sel]));
}

- (void)testMethodSignatureForSelectorNotInProtocol_ShouldAnswerNil
{
    SEL sel = @selector(objectAtIndex:);

    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:sel];

    assertThat(signature, is(nilValue()));
}

- (void)testShouldConformToItsOwnProtocol
{
    STAssertTrue([mockImplementer conformsToProtocol:@protocol(TestingProtocol)], nil);
}

- (void)testShouldConformToParentProtocol
{
    STAssertTrue([mockImplementer conformsToProtocol:@protocol(NSObject)], nil);
}

- (void)testShouldNotConformToUnrelatedProtocol
{
    STAssertFalse([mockImplementer conformsToProtocol:@protocol(NSCoding)], nil);
}

- (void)testShouldRespondToRequiredSelector
{
    STAssertTrue([mockImplementer respondsToSelector:@selector(required)], nil);
}

- (void)testShouldRespondToOptionalSelector
{
    STAssertTrue([mockImplementer respondsToSelector:@selector(optional)], nil);
}

- (void)testShouldNotRespondToUnrelatedSelector
{
    STAssertFalse([mockImplementer respondsToSelector:@selector(objectAtIndex:)], nil);
}

@end
