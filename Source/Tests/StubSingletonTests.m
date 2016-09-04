//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Igor Sales

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface StubSingletonTests : XCTestCase
@end

@implementation StubSingletonTests

- (void)testStubbedSingleton_ShouldReturnGivenObject
{
    __strong Class mockUserDefaultsClass = mockClass([NSUserDefaults class]);
    stubSingleton(mockUserDefaultsClass, standardUserDefaults);
    [given([mockUserDefaultsClass standardUserDefaults]) willReturn:@"STUBBED"];
    
    assertThat([NSUserDefaults standardUserDefaults], is(@"STUBBED"));
}

- (void)testStubbedSingleton_WithMultipleStubs_ShouldGivePrecedenceToLastStub
{
    __strong Class firstMockClass = mockClass([NSUserDefaults class]);
    stubSingleton(firstMockClass, standardUserDefaults);
    [given([firstMockClass standardUserDefaults]) willReturn:@"STUBBED"];
    
    __strong Class secondMockClass = mockClass([NSUserDefaults class]);
    stubSingleton(secondMockClass, standardUserDefaults);
    [given([secondMockClass standardUserDefaults]) willReturn:@"STUBBED2"];
    
    assertThat([NSUserDefaults standardUserDefaults], is(@"STUBBED2"));
}

@end
