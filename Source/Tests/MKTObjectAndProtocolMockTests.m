//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Kevin Lundberg

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@protocol TestProtocol <NSObject>
@required
- (void)requiredMethod;
@end


@interface TestClass : NSObject
@property (readonly, nonatomic, strong) id dynamicProperty;
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

- (void)testShouldHandleInstanceMethod
{
    STAssertNoThrow([mock instanceMethod],nil);
}

- (void)testShouldHandleRequiredProtocolMethod
{
    STAssertNoThrow([mock requiredMethod],nil);
}

- (void)testShouldAnswerSameMethodSignatureForSelectorAsRealObject
{
    TestClass<TestProtocol> *obj = [[TestSubclass alloc] init];
    SEL sel = @selector(instanceMethod);

    NSMethodSignature *mockSig = [mock methodSignatureForSelector:sel];

    assertThat(mockSig, equalTo([obj methodSignatureForSelector:sel]));
}

- (void)testMethodSignatureForSelectorNotInObjectOrProtocol_ShouldAnswerNil
{
    SEL bogusSelector = @selector(objectAtIndex:);

    NSMethodSignature *signature = [mock methodSignatureForSelector:bogusSelector];

    assertThat(signature, is(nilValue()));
}

- (void)testShouldRespondToKnownSelector
{
    assertThatBool([mock respondsToSelector:@selector(instanceMethod)], isTrue());
}

- (void)testShouldNotRespondToUnknownSelector
{
    SEL sel = @selector(objectAtIndex:);

    assertThatBool([mock respondsToSelector:sel], isFalse());
}

- (void)testShouldAnswerSameMethodSignatureForRequiredSelectorAsRealImplementer
{
    TestClass<TestProtocol> *obj = [[TestSubclass alloc] init];
    SEL sel = @selector(requiredMethod);

    NSMethodSignature *signature = [mock methodSignatureForSelector:sel];

    assertThat(signature, equalTo([obj methodSignatureForSelector:sel]));
}

- (void)testShouldConformToItsOwnProtocol
{
    STAssertTrue([mock conformsToProtocol:@protocol(TestProtocol)],nil);
}

- (void)testShouldConformToParentProtocol
{
    STAssertTrue([mock conformsToProtocol:@protocol(NSObject)], nil);
}

- (void)testShouldNotConformToUnrelatedProtocol
{
    STAssertFalse([mock conformsToProtocol:@protocol(NSCoding)], nil);
}

- (void)testShouldRespondToRequiredSelector
{
    STAssertTrue([mock respondsToSelector:@selector(requiredMethod)], nil);
}

- (void)testShouldRespondToDynamicPropertySelector
{
    STAssertTrue([mock respondsToSelector:@selector(dynamicProperty)], nil);
}

- (NSMethodSignature *)realSignatureForSelector:(SEL)sel
{
    TestClassWithMethods *realObjectWithMethods = [[TestClassWithMethods alloc] init];
    NSMethodSignature *signature = [realObjectWithMethods methodSignatureForSelector:sel];
    assertThat(signature, is(notNilValue()));
    return signature;
}

- (void)testMethodSignature_ForDynamicProperty_ShouldBeSameAsRealObject
{
    SEL sel = @selector(dynamicProperty);
    NSMethodSignature *realSignature = [self realSignatureForSelector:sel];

    NSMethodSignature *mockSignature = [mock methodSignatureForSelector:sel];

    assertThat(mockSignature, is(equalTo(realSignature)));
}

@end
