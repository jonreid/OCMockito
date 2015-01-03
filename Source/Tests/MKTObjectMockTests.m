//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


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

- (void)testShouldAnswerSameMethodSignatureForSelectorAsRealObject
{
    NSString *realString = [NSString string];
    SEL sel = @selector(rangeOfString:options:);

    NSMethodSignature *signature = [mockString methodSignatureForSelector:sel];

    assertThat(signature, is(equalTo([realString methodSignatureForSelector:sel])));
}

- (void)testMethodSignatureForSelectorNotInObject_ShouldAnswerNil
{
    SEL sel = @selector(objectAtIndex:);

    NSMethodSignature *signature = [mockString methodSignatureForSelector:sel];

    assertThat(signature, is(nilValue()));
}

- (void)testShouldBeKindOfSameClass
{
    STAssertTrue([mockString isKindOfClass:[NSString class]], nil);
}

- (void)testShouldBeKindOfSubclass
{
    NSString *mockMutableString = mock([NSMutableString class]);
    STAssertTrue([mockMutableString isKindOfClass:[NSString class]], nil);
}

- (void)testShouldNotBeKindOfDifferentClass
{
    STAssertFalse([mockString isKindOfClass:[NSArray class]], nil);
}

- (void)testShouldRespondToKnownSelector
{
    STAssertTrue([mockString respondsToSelector:@selector(substringFromIndex:)], nil);
}

- (void)testShouldNotRespondToUnknownSelector
{
    SEL sel = @selector(removeAllObjects);

    STAssertFalse([mockString respondsToSelector:sel], nil);
}

@end


@interface DynamicPropertyHolderSuperclass: NSObject
@property (readonly, nonatomic, strong) id superclassProperty;
@end

@implementation DynamicPropertyHolderSuperclass
@dynamic superclassProperty;
@end


@interface DynamicPropertyHolder : DynamicPropertyHolderSuperclass
@property (nonatomic, copy) id objectProperty;
@property (nonatomic, assign) int intProperty;
@property (readonly, nonatomic, strong) id readonlyProperty;
@property (nonatomic, getter=customPropertyGetter, setter=customPropertySetter:, assign) int customProperty;
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
}

- (void)setUp
{
    [super setUp];
    mockDynamicPropertyHolder = mock([DynamicPropertyHolder class]);
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
    SEL sel = NSSelectorFromString(@"setReadonlyProperty:");

    STAssertFalse([mockDynamicPropertyHolder respondsToSelector:sel], nil);
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
    DynamicPropertyHolderWithMethods *realObjectWithMethods = [[DynamicPropertyHolderWithMethods alloc] init];
    NSMethodSignature *signature = [realObjectWithMethods methodSignatureForSelector:sel];
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
