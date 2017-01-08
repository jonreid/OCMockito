//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import "MockTestCase.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface VerifyCountNeverTests : XCTestCase
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

- (void)tearDown
{
    mockArray = nil;
    [super tearDown];
}

- (void)testVerifyNever_WithMethodNotInvoked_ShouldPass
{
    [verifyCount(mockArray, never()) removeAllObjects];
}

- (void)testVerifyNever_WithMethodInvoked_ShouldFail
{
    MockTestCase *mockTestCase = [[MockTestCase alloc] init];
    [mockArray removeAllObjects];

    [verifyCountWithMockTestCase(mockArray, never(), mockTestCase) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

@end
