//
//  OCMockito - MKTObjectAndProtocolMockTests.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
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
@property (nonatomic, readonly) id dynamicProperty;
- (void)instanceMethod;
@end

@implementation TestClass
@dynamic dynamicProperty;
- (void)instanceMethod {}
@end


@interface TestClassWithMethods : TestClass
@end

@implementation TestClassWithMethods
- (id)dynamicProperty { return nil; }
@end


@interface TestSubclass : TestClass <TestProtocol>
@end

@implementation TestSubclass
- (void)requiredMethod {}
@end


@interface MKTObjectAndProtocolMockTests : SenTestCase
@end

@implementation MKTObjectAndProtocolMockTests
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

- (void)testMock_ShouldHandleInstanceMethod
{
    STAssertNoThrow([mock instanceMethod],nil);
}

- (void)testMock_ShouldHandleRequiredProtocolMethod
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

- (void)testMethodSignatureForSelectorNotInObjectOrProtocol_ShouldAnswerNil
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

- (NSMethodSignature *)realSignatureForSelector:(SEL)sel
{
    TestClassWithMethods *realDynamicPropertyHolder = [[TestClassWithMethods alloc] init];
    NSMethodSignature *signature = [realDynamicPropertyHolder methodSignatureForSelector:sel];
    assertThat(signature, is(notNilValue()));
    return signature;
}

- (void)testShouldRespondToDynamicPropertySelector
{
    STAssertTrue([mock respondsToSelector:@selector(dynamicProperty)], nil);
}

- (void)testMethodSignature_ForDynamicProperty_ShouldBeSameAsRealObject
{
    SEL sel = @selector(dynamicProperty);
    NSMethodSignature *realSignature = [self realSignatureForSelector:sel];

    NSMethodSignature *mockSignature = [mock methodSignatureForSelector:sel];

    assertThat(mockSignature, is(equalTo(realSignature)));
}

@end
