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
@property (assign, nonatomic) int unstubbedMethodCount;
@end

@implementation SpiedObject

- (void)unstubbedMethod
{
    ++_unstubbedMethodCount;
}

@end


#pragma mark -

@interface MKTObjectMockSpyTest : SenTestCase
@end

@implementation MKTObjectMockSpyTest

- (void)testSettingsWithSpiedObjectShouldForwardInvocationsToIt
{
    // given
    SpiedObject *spiedObject = [[SpiedObject  alloc] init];
    MKTMockSettings *settings = [[MKTMockSettings alloc] init];
    [settings setSpiedObject:spiedObject];
    id sut = [MKTObjectMock mockForClass:[spiedObject class] withSettings:settings];

    // when
    [sut unstubbedMethod];
    [sut unstubbedMethod];

    // then
    assertThatInt([spiedObject unstubbedMethodCount], is(equalTo(@2)));
}

@end
