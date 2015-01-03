//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface ClassMethodsReturningObject : NSObject
@end

@implementation ClassMethodsReturningObject

+ (id)methodReturningObject { return self; }

@end


@interface StubClassTests : SenTestCase
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
