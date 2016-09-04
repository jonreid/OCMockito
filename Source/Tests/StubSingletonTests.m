//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Igor Sales

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface ClassWithSingleton : NSObject
@end


@implementation ClassWithSingleton

+ (id)singletonMethod
{
    static ClassWithSingleton *singleton = nil;
    if (!singleton)
        singleton = [[ClassWithSingleton alloc] init];
    return singleton;
}

@end


@interface StubSingletonTests : XCTestCase
@end

@implementation StubSingletonTests

- (void)testUnstubbedSingleton_ShouldReturnExpectedInstance
{
    ClassWithSingleton *instance = [ClassWithSingleton singletonMethod];
    
    assertThat(instance, is(instanceOf([ClassWithSingleton class])));
}

- (void)testStubbedSingleton_ShouldReturnGivenObject
{
    __strong Class myMockClass = mockClass([ClassWithSingleton class]);
    stubSingleton(myMockClass, singletonMethod);
    
    [given([myMockClass singletonMethod]) willReturn:@"STUBBED"];
    
    assertThat([ClassWithSingleton singletonMethod], is(@"STUBBED"));
}

- (void)testStubbedSingletonOnExistingClass_ShouldReturnGivenObject
{
    __strong Class myMockClass = mockClass([ClassWithSingleton class]);
    Class userDefaultsClass = mockClass([NSUserDefaults class]);
    
    stubSingleton(userDefaultsClass, standardUserDefaults);
    
    [given([userDefaultsClass standardUserDefaults]) willReturn:@"STUBBED"];
    
    assertThat([NSUserDefaults standardUserDefaults], is(@"STUBBED"));
}

- (void)testStubbedSingleton_LastSingletonStubTakesPrecedence
{
    __strong Class myMockClass = mockClass([ClassWithSingleton class]);
    stubSingleton(myMockClass, singletonMethod);
    
    [given([myMockClass singletonMethod]) willReturn:@"STUBBED"];
    
    Class myNewMockClass = mockClass([ClassWithSingleton class]);
    
    stubSingleton(myNewMockClass, singletonMethod);
    
    [given([myNewMockClass singletonMethod]) willReturn:@"STUBBED2"];
    
    assertThat([ClassWithSingleton singletonMethod], is(@"STUBBED2"));
}

//- (void)testStubbedSingleton_ValidUnswizzle
//{
//    stubSingleton(myMockClass, singletonMethod);
//
//    [given([myMockClass singletonMethod]) willReturn:@"STUBBED"];
//
//    MKTClassObjectMock *mock = (MKTClassObjectMock *)myMockClass;
//    [mock unswizzleSingletonAtSelector:@selector(singletonMethod)];
//
//    assertThat([ClassMethodsReturningObject singletonMethod], isNot(@"STUBBED"));
//}
//
//- (void)testStubbedSingleton_InvalidUnswizzling
//{
//    MKTClassObjectMock *mock = (MKTClassObjectMock *)myMockClass;
//
//    [mock unswizzleSingletonAtSelector:@selector(standardUserDefaults)];
//}
//
//- (void)testNoStubbedSingleton_ReturnsNil
//{
//    assertThat([MKTClassObjectMock mockSingleton], equalTo(nil));
//}

@end
