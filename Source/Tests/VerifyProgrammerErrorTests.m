//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import "MockTestCase.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface VerifyProgrammerErrorTests : XCTestCase
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

- (void)tearDown
{
    mockTestCase = nil;
    [super tearDown];
}

- (void)testVerify_WithNil_ShouldGiveError
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    [verifyWithMockTestCase(nil, mockTestCase) removeAllObjects];
#pragma clang diagnostic pop

    assertThat(mockTestCase.failureDescription,
               is(@"Argument passed to verify() should be a mock, but was nil"));
}

- (void)testVerifyCount_WithNil_ShouldGiveError
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    [verifyCountWithMockTestCase(nil, times(1), mockTestCase) removeAllObjects];
#pragma clang diagnostic pop

    assertThat(mockTestCase.failureDescription,
               is(@"Argument passed to verifyCount() should be a mock, but was nil"));
}

- (void)testVerify_WithNonMock_ShouldGiveError
{
    NSMutableArray *realArray = [NSMutableArray array];

    [verifyWithMockTestCase(realArray, mockTestCase) removeAllObjects];

    assertThat(mockTestCase.failureDescription,
               startsWith(@"Argument passed to verify() should be a mock, but was type "));
}

- (void)testVerifyCount_WithNonMock_ShouldGiveError
{
    NSMutableArray *realArray = [NSMutableArray array];

    [verifyCountWithMockTestCase(realArray, times(1), mockTestCase) removeAllObjects];

    assertThat(mockTestCase.failureDescription,
               startsWith(@"Argument passed to verifyCount() should be a mock, but was type "));
}

@end
