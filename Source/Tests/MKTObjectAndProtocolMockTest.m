//
//  OCMockito - MKTObjectAndProtocolMockTest.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//  
//  Created by: Kevin Lundberg
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


@protocol TestProtocol <NSObject>
@required
- (void)requiredMethod;
@end


@interface TestClass : NSObject 
- (void)instanceMethod;
@end

@implementation TestClass
- (void)instanceMethod {}
@end


@interface TestSubclass : TestClass <TestProtocol>
@end

@implementation TestSubclass
- (void)requiredMethod {}
@end


#pragma mark -

@interface MKTObjectAndProtocolMockTest : SenTestCase
@end

@implementation MKTObjectAndProtocolMockTest
{
    TestClass<TestProtocol> *mock;
}

- (void)setUp
{
    [super setUp];
    mock = mockObjectAndProtocol([TestClass class], @protocol(TestProtocol));
}
- (void)testClassProtocolMockCanCallMethodFromClass
{
    STAssertNoThrow([mock instanceMethod],nil);
}

- (void)testClassProtocolMockCanCallMethodFromProtocol
{
    STAssertNoThrow([mock requiredMethod],nil);
}

- (void)testMockShouldAnswerSameMethodSignatureForSelectorAsRealObject
{
    // given
    TestClass<TestProtocol> *obj = [[TestSubclass alloc] init];
    SEL selector = @selector(instanceMethod);
    
    // when
    NSMethodSignature *mockSig = [mock methodSignatureForSelector:selector];
    
    // then
    HC_assertThat(mockSig, HC_equalTo([obj methodSignatureForSelector:selector]));
}

- (void)testMethodSignatureForSelectorNotInClassOrProtocolShouldAnswerNil
{
    // given
    SEL bogusSelector = @selector(objectAtIndex:);
    
    // when
    NSMethodSignature *signature = [mock methodSignatureForSelector:bogusSelector];
    
    // then
    HC_assertThat(signature, HC_nilValue());
}

- (void)testMockShouldRespondToKnownSelector
{
    HC_assertThatBool([mock respondsToSelector:@selector(instanceMethod)], HC_equalToBool(YES));
}

- (void)testMockShouldNotRespondToUnknownSelector
{
    HC_assertThatBool([mock respondsToSelector:@selector(objectAtIndex:)], HC_equalToBool(NO));
}

- (void)testMockShouldAnswerSameMethodSignatureForRequiredSelectorAsRealImplementer
{
    // given
    TestClass<TestProtocol> *obj = [[TestSubclass alloc] init];
    SEL selector = @selector(requiredMethod);
    
    // when
    NSMethodSignature *signature = [mock methodSignatureForSelector:selector];
    
    // then
    HC_assertThat(signature, HC_equalTo([obj methodSignatureForSelector:selector]));
}

- (void)testMockShouldConformToItsOwnProtocol
{
    STAssertTrue([mock conformsToProtocol:@protocol(TestProtocol)],nil);
}

- (void)testMockShouldConformToParentProtocol
{
    STAssertTrue([mock conformsToProtocol:@protocol(NSObject)], nil);
}

- (void)testMockShouldNotConformToUnrelatedProtocol
{
    STAssertFalse([mock conformsToProtocol:@protocol(NSCoding)], nil);
}

- (void)testMockShouldRespondToRequiredSelector
{
    STAssertTrue([mock respondsToSelector:@selector(requiredMethod)], nil);
}

@end
