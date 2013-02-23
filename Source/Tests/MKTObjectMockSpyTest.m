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

- (void)testMethodInvocationsShouldBeForwardedToSpiedObject
{
    // when
    [sut methodA];

    // then
    assertThatInt([spiedObject methodACount], is(equalTo(@1)));
}

- (void)testDoNothingShouldNotForwardThoseMethodInvocationsToSpiedObject
{
    // given
    [[willDoNothing() when:sut] methodA];

    // when
    [sut methodA];

    // then
    assertThatInt([spiedObject methodACount], is(equalTo(@0)));
}

- (void)testDoNothingShouldForwardOtherMethodInvocationsToSpiedObject
{
    // given
    [[willDoNothing() when:sut] methodB];

    // when
    [sut methodA];

    // then
    assertThatInt([spiedObject methodACount], is(equalTo(@1)));
}

- (void)testDoReturnShouldReturnGivenObjectWhenMethodIsInvoked
{
    // given
    [[willReturn(@"bar") when:sut] fooString];

    // then
    assertThat([sut fooString], is(@"bar"));
}

@end
