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
@property (assign, nonatomic) int methodCount;
@end

@implementation SpiedObject

- (void)method
{
    ++_methodCount;
}

@end


#pragma mark -

@interface MKTObjectMockSpyTest : SenTestCase
@end

@implementation MKTObjectMockSpyTest

- (void)testSettingsWithSpiedObjectShouldForwardUnstubbedMethodInvocationsToIt
{
    // given
    SpiedObject *spiedObject = [[SpiedObject alloc] init];
    MKTMockSettings *settings = [[MKTMockSettings alloc] init];
    [settings setSpiedObject:spiedObject];
    id sut = [MKTObjectMock mockForClass:[spiedObject class] withSettings:settings];

    // when
    [sut method];
    [sut method];

    // then
    assertThatInt([spiedObject methodCount], is(equalTo(@2)));
}

- (void)testSettingsWithSpiedObjectShouldNotForwardDoNothingMethodInvocationsToIt
{
    // given
    SpiedObject *spiedObject = [[SpiedObject alloc] init];
    MKTMockSettings *settings = [[MKTMockSettings alloc] init];
    [settings setSpiedObject:spiedObject];
    id sut = [MKTObjectMock mockForClass:[spiedObject class] withSettings:settings];

    // when
    [[doNothing() when:sut] method];
    [sut method];
    [sut method];

    // then
    assertThatInt([spiedObject methodCount], is(equalTo(@0)));
}

@end
