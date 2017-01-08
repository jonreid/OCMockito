//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface ClassMethodsReturningObject : NSObject
@end

@implementation ClassMethodsReturningObject
+ (id)methodReturningObject { return self; }
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

- (void)tearDown
{
    myMockClass = Nil;
    [super tearDown];
}

- (void)testStubbedMethod_ShouldReturnGivenObject
{
    [given([myMockClass methodReturningObject]) willReturn:@"STUBBED"];

    assertThat([myMockClass methodReturningObject], is(@"STUBBED"));
}

@end
