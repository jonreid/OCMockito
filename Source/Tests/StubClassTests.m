//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>

@interface ClassMethodsReturningObject : NSObject
@end

@implementation ClassMethodsReturningObject

+ (id)methodReturningObject { return self; }

+ (id)singletonMethod
{
    static ClassMethodsReturningObject* sSingleton = nil;

    if (!sSingleton) {
        sSingleton = [ClassMethodsReturningObject new];
    }

    return sSingleton;
}

@end


@interface StubClassTests : XCTestCase
@end

@implementation StubClassTests
{
    __strong Class myMockClass;
}

- (void)setUp
{
    [super setUp];
    myMockClass = mockClass([ClassMethodsReturningObject class]);
}

- (void)testStubbedMethod_ShouldReturnGivenObject
{
    [given([myMockClass methodReturningObject]) willReturn:@"STUBBED"];

    assertThat([myMockClass methodReturningObject], is(@"STUBBED"));
}

- (void)testStubbedSingleton_ShouldReturnGivenObject
{
    stubSingleton(myMockClass, singletonMethod);

    [given([myMockClass singletonMethod]) willReturn:@"STUBBED"];

    assertThat([ClassMethodsReturningObject singletonMethod], is(@"STUBBED"));
}

- (void)testStubbedSingletonOnExistingClass_ShouldReturnGivenObject
{
    Class userDefaultsClass = mockClass([NSUserDefaults class]);

    stubSingleton(userDefaultsClass, standardUserDefaults);
    
    [given([userDefaultsClass standardUserDefaults]) willReturn:@"STUBBED"];
    
    assertThat([NSUserDefaults standardUserDefaults], is(@"STUBBED"));
}

- (void)testStubbedSingleton_LastSingletonStubTakesPrecedence
{
    stubSingleton(myMockClass, singletonMethod);
    
    [given([myMockClass singletonMethod]) willReturn:@"STUBBED"];
    
    Class myNewMockClass = mockClass([ClassMethodsReturningObject class]);
    [givenVoid(stubSingleton(myNewMockClass, singletonMethod)) willThrow:anything()];
    
    [given([myNewMockClass singletonMethod]) willReturn:@"STUBBED2"];
    
    assertThat([ClassMethodsReturningObject singletonMethod], is(@"STUBBED2"));
}

- (void)testStubbedSingleton_ValidUnswizzle
{
    stubSingleton(myMockClass, singletonMethod);
    
    [given([myMockClass singletonMethod]) willReturn:@"STUBBED"];
    
    MKTClassObjectMock* mock = (MKTClassObjectMock*)myMockClass;
    [mock unswizzleSingletonAtSelector:@selector(singletonMethod)];
    
    assertThat([ClassMethodsReturningObject singletonMethod], isNot(@"STUBBED"));
}

- (void)testStubbedSingleton_InvalidUnswizzling
{
    MKTClassObjectMock* mock = (MKTClassObjectMock*)myMockClass;
    
    [mock unswizzleSingletonAtSelector:@selector(standardUserDefaults)];
}

@end
