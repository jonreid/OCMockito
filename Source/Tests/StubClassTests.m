//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

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
    __strong Class mockClass;
}

- (void)setUp
{
    [super setUp];
    mockClass = mockClass([ClassMethodsReturningObject class]);
}

- (void)testStubbedMethod_ShouldReturnGivenObject
{
    [given([mockClass methodReturningObject]) willReturn:@"STUBBED"];

    assertThat([mockClass methodReturningObject], is(@"STUBBED"));
}

@end
