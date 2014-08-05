//
//  OCMockito - VerifyClassObjectTests.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import "MockTestCase.h"
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface VerifyClassObjectTests : SenTestCase
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
