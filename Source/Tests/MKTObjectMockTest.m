//
//  OCMockito - MKTObjectMockTest.m
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


@interface MKTObjectMockTest : SenTestCase

@property (nonatomic) NSString* myProperty;
@property (nonatomic, getter = getMyCustomProperty, setter = setterMyCustomProperty:) NSString* myCustomProperty;

@end

@implementation MKTObjectMockTest
{
    NSString *mockString;
    MKTObjectMockTest *mockDynamicObject;
}

@dynamic myProperty;
@dynamic myCustomProperty;

- (void)setUp
{
    [super setUp];

    mockString = mock([NSString class]);
    mockDynamicObject = mock([MKTObjectMockTest class]);
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
    STAssertFalse([mockDynamicObject respondsToSelector:@selector(setMyProperty:)], nil);
}

- (void)testMock_ShouldRespondToDynamicGetterSelector
{
    STAssertFalse([mockDynamicObject respondsToSelector:@selector(myProperty)], nil);
}

- (void)testMock_ShouldRespondToDynamicSetterSelectorWithCustomName
{
    STAssertFalse([mockDynamicObject respondsToSelector:@selector(setterMyCustomProperty:)], nil);
}

- (void)testMock_ShouldRespondToDynamicGetterSelectorWithCustomName
{
    STAssertFalse([mockDynamicObject respondsToSelector:@selector(getMyCustomProperty)], nil);
}

@end
