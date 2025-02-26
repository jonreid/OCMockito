// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <OCMockito/OCMockito.h>
#import <OCHamcrest/OCHamcrest.h>

#import "MockTestCase.h"
@import XCTest;


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
