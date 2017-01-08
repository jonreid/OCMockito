//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTObjectMockTests : XCTestCase
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

- (void)tearDown
{
    mockString = nil;
    [super tearDown];
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
    XCTAssertTrue([mockString isKindOfClass:[NSString class]]);
}

- (void)testShouldBeKindOfSubclass
{
    NSString *mockMutableString = mock([NSMutableString class]);
    XCTAssertTrue([mockMutableString isKindOfClass:[NSString class]]);
}

- (void)testShouldNotBeKindOfDifferentClass
{
    XCTAssertFalse([mockString isKindOfClass:[NSArray class]]);
}

- (void)testShouldRespondToKnownSelector
{
    XCTAssertTrue([mockString respondsToSelector:@selector(substringFromIndex:)]);
}

- (void)testShouldNotRespondToUnknownSelector
{
    SEL sel = @selector(removeAllObjects);

    XCTAssertFalse([mockString respondsToSelector:sel]);
}

@end


@interface DynamicPropertyHolderSuperclass: NSObject
@property (nonatomic, strong, readonly) id superclassProperty;
@end

@implementation DynamicPropertyHolderSuperclass
@dynamic superclassProperty;
@end


@interface DynamicPropertyHolder : DynamicPropertyHolderSuperclass
@property (nonatomic, copy) id objectProperty;
@property (nonatomic, assign) int intProperty;
@property (nonatomic, strong, readonly) id readonlyProperty;
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


@interface MKTObjectMockDynamicPropertyTests : XCTestCase
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

- (void)tearDown
{
    mockDynamicPropertyHolder = nil;
    [super tearDown];
}

- (void)testShouldRespondToDynamicGetter
{
    XCTAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(objectProperty)]);
}

- (void)testShouldRespondToDynamicSetter
{
    XCTAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(setObjectProperty:)]);
}

- (void)testShouldRespondToSecondDynamicGetterInSameClass
{
    XCTAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(intProperty)]);
}

- (void)testShouldNotRespondToGetterForReadonlyProperty
{
    SEL sel = NSSelectorFromString(@"setReadonlyProperty:");

    XCTAssertFalse([mockDynamicPropertyHolder respondsToSelector:sel]);
}

- (void)testShouldRespondToDynamicGetterInSuperclass
{
    XCTAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(superclassProperty)]);
}

- (void)testShouldRespondToDynamicGetterWithCustomizedName
{
    XCTAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(customPropertyGetter)]);
}

- (void)testShouldRespondToDynamicSetterWithCustomizedName
{
    XCTAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(customPropertySetter:)]);
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
