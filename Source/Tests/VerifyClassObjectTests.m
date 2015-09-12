//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

#import "MockTestCase.h"
#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface VerifyClassObjectTests : XCTestCase
@end

@implementation VerifyClassObjectTests
{
    __strong Class mockStringClass;
}

- (void)setUp
{
    [super setUp];
    mockStringClass = mockClass([NSString class]);
}

- (void)testVerify_WithClassMethodInvoked_ShouldPass
{
    [mockStringClass string];

    [verify(mockStringClass) string];
}

- (void)testVerify_WithClassMethodNotInvoked_ShouldFail
{
    MockTestCase *mockTestCase = [[MockTestCase alloc] init];

    [verifyWithMockTestCase(mockStringClass) string];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

@end
