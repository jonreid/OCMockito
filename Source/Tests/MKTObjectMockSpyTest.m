//
//  OCMockito - MKTObjectMockSpyTest.m
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


@interface SpiedObject : NSObject
@property (nonatomic, assign) int methodACount;
@end

@implementation SpiedObject

- (void)methodA
{
    ++_methodACount;
}

- (void)methodB
{
}

- (NSString *)fooString
{
    return @"foo";
}

- (NSString *)methodWithArg:(NSString *)arg
{
    return @"unstubbed";
}

- (NSString *)methodWithInt:(int)arg
{
    return @"unstubbed";
}

@end


#pragma mark -

@interface MKTObjectMockSpyTest : SenTestCase
@end

@implementation MKTObjectMockSpyTest
{
    SpiedObject *spiedObject;
    MKTMockSettings *settings;
    id sut;
}

- (void)setUp
{
    [super setUp];
    spiedObject = [[SpiedObject alloc] init];
    sut = partialMock(spiedObject);
}

- (void)testUnstubbedMethodInvocationsShouldBeForwardedToSpiedObject
{
    // when
    [sut methodA];

    // then
    assertThatInt([spiedObject methodACount], is(equalTo(@1)));
}

- (void)testWillDoNothingShouldNotForwardThoseMethodInvocationsToSpiedObject
{
    // given
    [[willDoNothing() when:sut] methodA];

    // when
    [sut methodA];

    // then
    assertThatInt([spiedObject methodACount], is(equalTo(@0)));
}

- (void)testWillDoNothingShouldForwardOtherMethodInvocationsToSpiedObject
{
    // given
    [[willDoNothing() when:sut] methodB];

    // when
    [sut methodA];

    // then
    assertThatInt([spiedObject methodACount], is(equalTo(@1)));
}

- (void)testWillReturnShouldReturnGivenObjectWhenMethodIsInvoked
{
    // given
    [[willReturn(@"bar") when:sut] fooString];

    // then
    assertThat([sut fooString], is(@"bar"));
}

- (void)testWillReturnValuesByMatchingMethodArgumentWithMatcher
{
    // given
    [[willReturn(@"foo") when:sut] methodWithArg:equalTo(@"foo")];

    // then
    assertThat([sut methodWithArg:@"foo"], is(@"foo"));
    assertThat([sut methodWithArg:@"bar"], is(@"unstubbed"));
}

- (void)testWillReturnValuesByMatchingMethodArgumentWithImplicitMatcher
{
    // given
    [[willReturn(@"foo") when:sut] methodWithArg:@"foo"];

    // then
    assertThat([sut methodWithArg:@"foo"], is(@"foo"));
    assertThat([sut methodWithArg:@"bar"], is(@"unstubbed"));
}

- (void)testWillReturnValuesMatchingAnyArgument
{
    // given
    [[willReturn(@"foo") when:sut] methodWithArg:(id)anything()];

    // then
    assertThat([sut methodWithArg:@"bar"], is(@"foo"));
}

- (void)testWillReturnValuesMatchingPrimitiveArgument
{
    // given
    [[willReturn(@"foo") when:sut] methodWithInt:0];

    // then
    assertThat([sut methodWithInt:0], is(@"foo"));
    assertThat([sut methodWithInt:1], is(@"unstubbed"));
}

@end
