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

@end
