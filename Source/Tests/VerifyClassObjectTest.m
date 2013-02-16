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

- (void)testInvokingClassMethodShouldPassVerify
{
    // given
    [mockStringClass string];
    
    // then
    [verify(mockStringClass) string];
}

- (void)testNotInvokingClassMethodShouldFailVerify
{
    // given
    MockTestCase *mockTestCase = [[MockTestCase alloc] init];

    // when
    [verifyWithMockTestCase(mockStringClass) string];

    // then
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));
}

@end
