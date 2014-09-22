//
//  OCMockito - MKTObjectMockTests.m
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
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface MKTObjectMockTests : SenTestCase
@end

@implementation MKTObjectMockTests
{
    NSString *mockString;
}

- (void)setUp
{
    [super setUp];
    mockString = mock([NSString class]);
}

- (void)testDescription
{
    assertThat([mockString description], is(@"mock object of NSString"));
}

- (void)testMock_ShouldAnswerSameMethodSignatureForSelectorAsRealObject
{
    NSString *realString = [NSString string];
    SEL selector = @selector(rangeOfString:options:);
    NSMethodSignature *signature = [mockString methodSignatureForSelector:selector];
    assertThat(signature, is(equalTo([realString methodSignatureForSelector:selector])));
}

- (void)testMethodSignatureForSelectorNotInObject_ShouldAnswerNil
{
    SEL selector = @selector(objectAtIndex:);
    NSMethodSignature *signature = [mockString methodSignatureForSelector:selector];
    assertThat(signature, is(nilValue()));
}

- (void)testMock_ShouldBeKindOfSameClass
{
    STAssertTrue([mockString isKindOfClass:[NSString class]], nil);
}

- (void)testMock_ShouldBeKindOfSubclass
{
    NSString *mockMutableString = mock([NSMutableString class]);
    STAssertTrue([mockMutableString isKindOfClass:[NSString class]], nil);
}

- (void)testMock_ShouldNotBeKindOfDifferentClass
{
    STAssertFalse([mockString isKindOfClass:[NSArray class]], nil);
}

- (void)testMock_ShouldRespondToKnownSelector
{
    STAssertTrue([mockString respondsToSelector:@selector(substringFromIndex:)], nil);
}

- (void)testMock_ShouldNotRespondToUnknownSelector
{
    STAssertFalse([mockString respondsToSelector:@selector(removeAllObjects)], nil);
}

@end


@interface DynamicPropertyHolderSuperclass: NSObject
@property (nonatomic, readonly) id superclassProperty;
@end

@implementation DynamicPropertyHolderSuperclass
@dynamic superclassProperty;
@end


@interface DynamicPropertyHolder : DynamicPropertyHolderSuperclass
@property (nonatomic, copy) id objectProperty;
@property (nonatomic) int intProperty;
@property (nonatomic, readonly) id readonlyProperty;
@property (nonatomic, getter=customPropertyGetter, setter=customPropertySetter:) int customProperty;
@end

@implementation DynamicPropertyHolder
@dynamic objectProperty;
@dynamic intProperty;
@dynamic readonlyProperty;
@dynamic customProperty;
@end


@interface DynamicPropertyHolderWithMethods : DynamicPropertyHolder
@end

@implementation DynamicPropertyHolderWithMethods
- (NSString *)objectProperty  { return nil; }
- (void)setObjectProperty:(id)objectProperty  {}
- (int)intProperty  { return 0; }
- (void)setIntProperty:(int)intProperty  {}
@end


@interface MKTObjectMockDynamicPropertyTests : SenTestCase
@end

@implementation MKTObjectMockDynamicPropertyTests
{
    DynamicPropertyHolder *mockDynamicPropertyHolder;
    DynamicPropertyHolder *realDynamicPropertyHolder;
}

- (void)setUp
{
    [super setUp];
    mockDynamicPropertyHolder = mock([DynamicPropertyHolder class]);
    realDynamicPropertyHolder = [[DynamicPropertyHolderWithMethods alloc] init];
}

- (void)testShouldRespondToDynamicGetter
{
    STAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(objectProperty)], nil);
}

- (void)testShouldRespondToDynamicSetter
{
    STAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(setObjectProperty:)], nil);
}

- (void)testShouldRespondToSecondDynamicGetterInSameClass
{
    STAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(intProperty)], nil);
}

- (void)testShouldNotRespondToGetterForReadonlyProperty
{
    STAssertFalse([mockDynamicPropertyHolder respondsToSelector:@selector(setReadonlyProperty:)], nil);
}

- (void)testShouldRespondToDynamicGetterInSuperclass
{
    STAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(superclassProperty)], nil);
}

- (void)testShouldRespondToDynamicGetterWithCustomizedName
{
    STAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(customPropertyGetter)], nil);
}

- (void)testShouldRespondToDynamicSetterWithCustomizedName
{
    STAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(customPropertySetter:)], nil);
}

- (NSMethodSignature *)realSignatureForSelector:(SEL)sel
{
    NSMethodSignature *signature = [realDynamicPropertyHolder methodSignatureForSelector:sel];
    assertThat(signature, is(notNilValue()));
    return signature;
}

- (void)testMethodSignature_ForDynamicObjectPropertyGetter_ShouldBeSameAsRealObject
{
    SEL sel = @selector(objectProperty);
    NSMethodSignature *realSignature = [self realSignatureForSelector:sel];

    NSMethodSignature *mockSignature = [mockDynamicPropertyHolder methodSignatureForSelector:sel];

    assertThat(mockSignature, is(equalTo(realSignature)));
}

- (void)testMethodSignature_ForDynamicIntGetterSelector_ShouldBeSameAsRealObject
{
    SEL sel = @selector(intProperty);
    NSMethodSignature *realSignature = [self realSignatureForSelector:sel];

    NSMethodSignature *mockSignature = [mockDynamicPropertyHolder methodSignatureForSelector:sel];

    assertThat(mockSignature, is(equalTo(realSignature)));
}

- (void)testMethodSignature_ForDynamicObjectPropertySetter_ShouldBeSameAsRealObject
{
    SEL sel = @selector(setObjectProperty:);
    NSMethodSignature *realSignature = [self realSignatureForSelector:sel];

    NSMethodSignature *mockSignature = [mockDynamicPropertyHolder methodSignatureForSelector:sel];

    assertThat(mockSignature, is(equalTo(realSignature)));
}

- (void)testMethodSignature_ForDynamicIntPropertySetter_ShouldBeSameAsRealObject
{
    SEL sel = @selector(setIntProperty:);
    NSMethodSignature *realSignature = [self realSignatureForSelector:sel];

    NSMethodSignature *mockSignature = [mockDynamicPropertyHolder methodSignatureForSelector:sel];

    assertThat(mockSignature, is(equalTo(realSignature)));
}

@end
