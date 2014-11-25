//
//  OCMockito - VerifyCountNeverTests.m
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
#import <OCHamcrest/OCHamcrest.h>


@interface VerifyCountNeverTests : SenTestCase
@end

@implementation VerifyCountNeverTests
{
    NSMutableArray *mockArray;
}

- (void)setUp
{
    [super setUp];
    mockArray = mock([NSMutableArray class]);
}

- (void)testVerifyNever_WithMethodNotInvoked_ShouldPass
{
    [verifyCount(mockArray, never()) removeAllObjects];
}

- (void)testVerifyNever_WithMethodInvoked_ShouldFail
{
    MockTestCase *mockTestCase = [[MockTestCase alloc] init];
    [mockArray removeAllObjects];

    [verifyCountWithMockTestCase(mockArray, never()) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

@end
