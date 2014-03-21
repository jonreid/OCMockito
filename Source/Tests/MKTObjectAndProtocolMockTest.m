//
//  OCMockito - MKTObjectAndProtocolMockTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//  
//  Created by: Kevin Lundberg
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


@protocol TestProtocol <NSObject>
@required
- (void)requiredMethod;
@end


@interface TestClass : NSObject
@property (nonatomic) NSString* stringProperty;
- (void)instanceMethod;
@end

@implementation TestClass
@dynamic stringProperty;
- (void)instanceMethod {}
@end


@interface TestSubclass : TestClass <TestProtocol>
@property (nonatomic) NSString* nonDynamicStringProperty;
@end

@implementation TestSubclass
@synthesize nonDynamicStringProperty;
- (void)requiredMethod {}
@end


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

- (void)testDescription
{
    assertThat([mock description], is(@"mock object of TestClass implementing TestProtocol protocol"));
}

- (void)testClassProtocolMockCanCallMethodFromClass
{
    STAssertNoThrow([mock instanceMethod],nil);
}

- (void)testClassProtocolMockCanCallMethodFromProtocol
{
    STAssertNoThrow([mock requiredMethod],nil);
}

- (void)testMock_ShouldAnswerSameMethodSignatureForSelectorAsRealObject
{
    TestClass<TestProtocol> *obj = [[TestSubclass alloc] init];
    SEL selector = @selector(instanceMethod);
    NSMethodSignature *mockSig = [mock methodSignatureForSelector:selector];
    assertThat(mockSig, equalTo([obj methodSignatureForSelector:selector]));
}

- (void)testMethodSignatureForSelectorNotInClassOrProtocol_ShouldAnswerNil
{
    SEL bogusSelector = @selector(objectAtIndex:);
    NSMethodSignature *signature = [mock methodSignatureForSelector:bogusSelector];
    assertThat(signature, is(nilValue()));
}

- (void)testMock_ShouldRespondToKnownSelector
{
    assertThatBool([mock respondsToSelector:@selector(instanceMethod)], equalToBool(YES));
}

- (void)testMock_ShouldNotRespondToUnknownSelector
{
    assertThatBool([mock respondsToSelector:@selector(objectAtIndex:)], equalToBool(NO));
}

- (void)testMock_ShouldAnswerSameMethodSignatureForRequiredSelectorAsRealImplementer
{
    TestClass<TestProtocol> *obj = [[TestSubclass alloc] init];
    SEL selector = @selector(requiredMethod);
    NSMethodSignature *signature = [mock methodSignatureForSelector:selector];
    assertThat(signature, equalTo([obj methodSignatureForSelector:selector]));
}

- (void)testMock_ShouldConformToItsOwnProtocol
{
    STAssertTrue([mock conformsToProtocol:@protocol(TestProtocol)],nil);
}

- (void)testMock_ShouldConformToParentProtocol
{
    STAssertTrue([mock conformsToProtocol:@protocol(NSObject)], nil);
}

- (void)testMock_ShouldNotConformToUnrelatedProtocol
{
    STAssertFalse([mock conformsToProtocol:@protocol(NSCoding)], nil);
}

- (void)testMock_ShouldRespondToRequiredSelector
{
    STAssertTrue([mock respondsToSelector:@selector(requiredMethod)], nil);
}

- (void)testMock_ShouldRespondToDynamicSetterSelector
{
    STAssertTrue([mock respondsToSelector:@selector(setStringProperty:)], nil);
}

- (void)testMock_ShouldRespondToDynamicGetterSelector
{
    STAssertTrue([mock respondsToSelector:@selector(stringProperty)], nil);
}

- (void)testMock_ShouldAnswerSameMethodSignatureForRequiredSelectorForGetter
{
    TestClass<TestProtocol> *obj = [[TestSubclass alloc] init];
    SEL selector = @selector(nonDynamicStringProperty);

    NSMethodSignature *signature = [mock methodSignatureForSelector:@selector(stringProperty)];
    assertThat(signature, equalTo([obj methodSignatureForSelector:selector]));
}

- (void)testMock_ShouldAnswerSameMethodSignatureForRequiredSelectorForSetter
{
    TestClass<TestProtocol> *obj = [[TestSubclass alloc] init];
    SEL selector = @selector(setNonDynamicStringProperty:);

    NSMethodSignature *signature = [mock methodSignatureForSelector:@selector(setStringProperty:)];
    assertThat(signature, equalTo([obj methodSignatureForSelector:selector]));
}

@end
