//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import "OCMockito.h"

#import "MockTestCase.h"
#import <OCHamcrest/OCHamcrest.h>
@import XCTest;


@interface VerifyObjectAndProtocolTests : XCTestCase
@end

@implementation VerifyObjectAndProtocolTests
{
    NSMutableArray <NSLocking> *mockLockingArray;
    MockTestCase *mockTestCase;
}

- (void)setUp
{
    [super setUp];
    mockLockingArray = mockObjectAndProtocol([NSMutableArray class], @protocol(NSLocking));
    mockTestCase = [[MockTestCase alloc] init];
}

- (void)tearDown
{
    mockLockingArray = nil;
    mockTestCase = nil;
    [super tearDown];
}

- (void)testInvokingInstanceMethod_ShouldPass
{
    [mockLockingArray removeAllObjects];

    [verify(mockLockingArray) removeAllObjects];
}

- (void)testVerify_WithInstanceMethodNotInvoked_ShouldFail
{
    [verifyWithMockTestCase(mockLockingArray, mockTestCase) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testVerify_WithProtocolMethodInvoked_ShouldPass
{
    [mockLockingArray lock];

    [verify(mockLockingArray) lock];
}

- (void)testVerify_WithProtocolMethodNotInvoked_ShouldFail
{
    [verifyWithMockTestCase(mockLockingArray, mockTestCase) lock];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

@end
