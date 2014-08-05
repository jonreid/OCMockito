//
//  OCMockito - StubClassTests.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif

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
