//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import "MockTestCase.h"
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface VerifyProgrammerErrorTests : SenTestCase
@end

@implementation VerifyProgrammerErrorTests
{
    MockTestCase *mockTestCase;
}

- (void)setUp
{
    [super setUp];
    mockTestCase = [[MockTestCase alloc] init];
}

- (void)testVerify_WithNil_ShouldGiveError
{
    [verifyWithMockTestCase(nil) removeAllObjects];

    assertThat([mockTestCase.failureException description],
               is(@"Argument passed to verify() should be a mock but is nil"));
}

- (void)testVerifyCount_WithNil_ShouldGiveError
{
    [verifyCountWithMockTestCase(nil, times(1)) removeAllObjects];

    assertThat([mockTestCase.failureException description],
               is(@"Argument passed to verifyCount() should be a mock but is nil"));
}

- (void)testVerify_WithNonMock_ShouldGiveError
{
    NSMutableArray *realArray = [NSMutableArray array];

    [verifyWithMockTestCase(realArray) removeAllObjects];

    assertThat([mockTestCase.failureException description],
               startsWith(@"Argument passed to verify() should be a mock but is type "));
}

- (void)testVerifyCount_WithNonMock_ShouldGiveError
{
    NSMutableArray *realArray = [NSMutableArray array];

    [verifyCountWithMockTestCase(realArray, times(1)) removeAllObjects];

    assertThat([mockTestCase.failureException description],
               startsWith(@"Argument passed to verifyCount() should be a mock but is type "));
}

@end
