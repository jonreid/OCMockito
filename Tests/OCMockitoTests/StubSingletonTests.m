// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT
//  Contribution by Igor Sales

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
@import XCTest;


@interface StubSingletonTests : XCTestCase
@end

@implementation StubSingletonTests
{
    __strong Class mockUserDefaultsClass;
}

- (void)setUp
{
    [super setUp];
    mockUserDefaultsClass = mockClass([NSUserDefaults class]);
}

- (void)tearDown
{
    mockUserDefaultsClass = Nil;
    [super tearDown];
}

- (void)testStubbedSingleton_ShouldReturnGivenObject
{
    stubSingleton(mockUserDefaultsClass, standardUserDefaults);
    [given([mockUserDefaultsClass standardUserDefaults]) willReturn:@"STUBBED"];
    
    assertThat([NSUserDefaults standardUserDefaults], is(@"STUBBED"));
}

- (void)testStubbedSingleton_EnsureThatMockDeallocationRestoresOriginalSingleton
{
    @autoreleasepool {
        mockUserDefaultsClass = mockClass([NSUserDefaults class]);
        stubSingleton(mockUserDefaultsClass, standardUserDefaults);
        [given([mockUserDefaultsClass standardUserDefaults]) willReturn:@"STUBBED"];

        assertThat([NSUserDefaults standardUserDefaults], is(@"STUBBED"));
        mockUserDefaultsClass = nil;
    }

    assertThat([NSUserDefaults standardUserDefaults], is(instanceOf([NSUserDefaults class])));
}

- (void)testExplicitlyStopMocking_ClassWithStubbedSingleton_ShouldReturnOriginalSingleton
{
    stubSingleton(mockUserDefaultsClass, standardUserDefaults);
    [given([mockUserDefaultsClass standardUserDefaults]) willReturn:@"STUBBED"];
    
    stopMocking(mockUserDefaultsClass);
    
    assertThat([NSUserDefaults standardUserDefaults], is(instanceOf([NSUserDefaults class])));
}

- (void)testStubbedSingleton_WithMultipleStubs_ShouldGivePrecedenceToLastStub
{
    stubSingleton(mockUserDefaultsClass, standardUserDefaults);
    [given([mockUserDefaultsClass standardUserDefaults]) willReturn:@"STUBBED"];
    
    __strong Class secondMockClass = mockClass([NSUserDefaults class]);
    stubSingleton(secondMockClass, standardUserDefaults);
    [given([secondMockClass standardUserDefaults]) willReturn:@"STUBBED2"];
    
    assertThat([NSUserDefaults standardUserDefaults], is(@"STUBBED2"));
}

- (void)testExplicitlyStop_WithMultipleStubs_ShouldReturnOriginalSingleton
{
    stubSingleton(mockUserDefaultsClass, standardUserDefaults);
    [given([mockUserDefaultsClass standardUserDefaults]) willReturn:@"STUBBED"];
    
    __strong Class secondMockClass = mockClass([NSUserDefaults class]);
    stubSingleton(secondMockClass, standardUserDefaults);
    [given([secondMockClass standardUserDefaults]) willReturn:@"STUBBED2"];
    
    stopMocking(mockUserDefaultsClass);
    stopMocking(secondMockClass);
    
    assertThat([NSUserDefaults standardUserDefaults], is(instanceOf([NSUserDefaults class])));
}

@end
