//
//  OCMockito - MKTObjectMockTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

#import "MKTMockSettings.h"

    // Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface MKTObjectMockTest : SenTestCase
@end

@implementation MKTObjectMockTest
{
    NSString *mockString;
}

- (void)setUp
{
    [super setUp];
    mockString = mock([NSString class]);
}
- (void)testMockShouldAnswerSameMethodSignatureForSelectorAsRealObject
{
    // given
    NSString *realString = [NSString string];
    SEL selector = @selector(rangeOfString:options:);
    
    // when
    NSMethodSignature *signature = [mockString methodSignatureForSelector:selector];
    
    // then
    assertThat(signature, is(equalTo([realString methodSignatureForSelector:selector])));
}

- (void)testMethodSignatureForSelectorNotInClassShouldAnswerNil
{
    // given
    SEL selector = @selector(objectAtIndex:);
    
    // when
    NSMethodSignature *signature = [mockString methodSignatureForSelector:selector];
    
    // then
    assertThat(signature, is(nilValue()));
}

- (void)testMockShouldBeKindOfSameClass
{
    STAssertTrue([mockString isKindOfClass:[NSString class]], nil);
}

- (void)testMockShouldBeKindOfSubclass
{
    // given
    NSString *mockMutableString = mock([NSMutableString class]);

    //then
    STAssertTrue([mockMutableString isKindOfClass:[NSString class]], nil);
}

- (void)testMockShouldNotBeKindOfDifferentClass
{
    STAssertFalse([mockString isKindOfClass:[NSArray class]], nil);
}

- (void)testMockShouldRespondToKnownSelector
{
    STAssertTrue([mockString respondsToSelector:@selector(substringFromIndex:)], nil);
}

- (void)testMockShouldNotRespondToUnknownSelector
{
    STAssertFalse([mockString respondsToSelector:@selector(removeAllObjects)], nil);
}

@end


#pragma mark -

@interface SpiedObject : NSObject
@property (assign, nonatomic) int unstubbedMethodCount;
@end

@implementation SpiedObject

- (void)unstubbedMethod
{
    ++_unstubbedMethodCount;
}

@end


#pragma mark -

@interface MKTObjectMockWithSettingsTest : SenTestCase
@end

@implementation MKTObjectMockWithSettingsTest

//- (void)testSettingsWithSpiedObjectShouldForwardInvocationsToIt
//{
//    // given
//    SpiedObject *spiedObject = [[SpiedObject  alloc] init];
//    MKTMockSettings *settings = [[MKTMockSettings alloc] init];
//    [settings setSpiedObject:spiedObject];
//    id sut = [MKTObjectMock mockForClass:[spiedObject class] withSettings:settings];
//
//    // when
//    [sut unstubbedMethod];
//    [sut unstubbedMethod];
//
//    // then
//    assertThatInt([spiedObject unstubbedMethodCount], is(equalTo(@2)));
//}

@end
