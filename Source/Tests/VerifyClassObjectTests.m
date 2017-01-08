//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import "MockTestCase.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


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

- (void)tearDown
{
    mockStringClass = Nil;
    [super tearDown];
}

- (void)testVerify_WithClassMethodInvoked_ShouldPass
{
    [mockStringClass string];

    [verify(mockStringClass) string];
}

- (void)testVerify_WithClassMethodNotInvoked_ShouldFail
{
    MockTestCase *mockTestCase = [[MockTestCase alloc] init];

    [verifyWithMockTestCase(mockStringClass, mockTestCase) string];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

@end
