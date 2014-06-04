//
//  OCMockito - MKTObjectMockTest.m
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


@interface PropertyHolder : NSObject

@property (nonatomic) NSString* myProperty;

@end

@implementation PropertyHolder

@dynamic myProperty;

@end

@interface CustomPropertyHolder : NSObject

@property (nonatomic, getter = getMyCustomProperty, setter = setterMyCustomProperty:) NSString* myCustomProperty;

@end

@implementation CustomPropertyHolder

@dynamic myCustomProperty;

@end

@interface StringPropertyHolder : NSObject
@property (nonatomic) NSString* stringProperty;
@end

@implementation StringPropertyHolder
@synthesize stringProperty;
@end

@interface MKTObjectMockTest : SenTestCase
@end

@implementation MKTObjectMockTest
{
    NSString *mockString;
    PropertyHolder *mockDynamicPropertyHolder;
    CustomPropertyHolder *mockDynamicCustomPropertyHolder;
}

- (void)setUp
{
    [super setUp];

    mockString = mock([NSString class]);
    mockDynamicPropertyHolder = mock([PropertyHolder class]);
    mockDynamicCustomPropertyHolder = mock([CustomPropertyHolder class]);
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

- (void)testMethodSignatureForSelectorNotInClass_ShouldAnswerNil
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

- (void)testMock_ShouldRespondToDynamicSetterSelector
{
    STAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(setMyProperty:)], nil);
}

- (void)testMock_ShouldRespondToDynamicGetterSelector
{
    STAssertTrue([mockDynamicPropertyHolder respondsToSelector:@selector(myProperty)], nil);
}

- (void)testMock_ShouldRespondToDynamicSetterSelectorWithCustomName
{
    STAssertTrue([mockDynamicCustomPropertyHolder respondsToSelector:@selector(setterMyCustomProperty:)], nil);
}

- (void)testMock_ShouldRespondToDynamicGetterSelectorWithCustomName
{
    STAssertTrue([mockDynamicCustomPropertyHolder respondsToSelector:@selector(getMyCustomProperty)], nil);
}

- (void)testMock_ShouldAnswerSameMethodSignatureForRequiredSelectorForGetter
{
    StringPropertyHolder *obj = [[StringPropertyHolder alloc] init];
    SEL selector = @selector(stringProperty);

    NSMethodSignature *signature = [mockDynamicPropertyHolder methodSignatureForSelector:@selector(myProperty)];
    assertThat(signature, equalTo([obj methodSignatureForSelector:selector]));
}

- (void)testMock_ShouldAnswerSameMethodSignatureForRequiredSelectorForSetter
{
    StringPropertyHolder *obj = [[StringPropertyHolder alloc] init];
    SEL selector = @selector(setStringProperty:);
    
    NSMethodSignature *signature = [mockDynamicPropertyHolder methodSignatureForSelector:@selector(setMyProperty:)];
    assertThat(signature, equalTo([obj methodSignatureForSelector:selector]));
}

@end
