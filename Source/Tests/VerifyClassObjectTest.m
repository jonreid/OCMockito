//
//  OCMockito - VerifyClassObjectTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
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


@interface VerifyClassObjectTest : SenTestCase
@end

@implementation VerifyClassObjectTest
{
    Class mockStringClass;
}

- (void)setUp
{
    [super setUp];
    mockStringClass = mockClass([NSString class]);
}

- (void)testInvokingClassMethod_ShouldPassVerify
{
    [mockStringClass string];
    [verify(mockStringClass) string];
}

- (void)testNotInvokingClassMethod_ShouldFailVerify
{
    MockTestCase *mockTestCase = [[MockTestCase alloc] init];
    [verifyWithMockTestCase(mockStringClass) string];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

@end
