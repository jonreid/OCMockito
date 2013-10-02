//
//  OCMockito - MKTClassObjectMockTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: David Hart
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


@interface MKTClassObjectMockTest : SenTestCase
@end

@implementation MKTClassObjectMockTest
{
    Class mockStringClass;
}

- (void)setUp
{
    [super setUp];
    mockStringClass = mockClass([NSString class]);
}

- (void)testDescription
{
    assertThat([mockStringClass description], is(@"mock class of NSString"));
}

- (void)testMock_ShouldAnswerSameMethodSignatureForSelectorAsRealObject
{
    SEL selector = @selector(string);
    NSMethodSignature *signature = [mockStringClass methodSignatureForSelector:selector];
    assertThat(signature, is(equalTo([[NSString class] methodSignatureForSelector:selector])));
}

- (void)testMethodSignatureForSelectorNotInClass_ShouldAnswerNil
{
    SEL selector = @selector(rangeOfString:options:);
    NSMethodSignature *signature = [mockStringClass methodSignatureForSelector:selector];
    assertThat(signature, is(nilValue()));
}

- (void)testMock_ShouldRespondToKnownSelector
{
    STAssertTrue([mockStringClass respondsToSelector:@selector(pathWithComponents:)], nil);
}

- (void)testMock_ShouldNotRespondToUnknownSelector
{
    STAssertFalse([mockStringClass respondsToSelector:@selector(pathExtension)], nil);
}

@end
