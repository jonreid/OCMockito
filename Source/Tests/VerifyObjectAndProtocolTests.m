//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import "MockTestCase.h"
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface VerifyObjectAndProtocolTests : SenTestCase
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

- (void)testInvokingInstanceMethod_ShouldPass
{
    [mockLockingArray removeAllObjects];

    [verify(mockLockingArray) removeAllObjects];
}

- (void)testVerify_WithInstanceMethodNotInvoked_ShouldFail
{
    [verifyWithMockTestCase(mockLockingArray) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testVerify_WithProtocolMethodInvoked_ShouldPass
{
    [mockLockingArray lock];

    [verify(mockLockingArray) lock];
}

- (void)testVerify_WithProtocolMethodNotInvoked_ShouldFail
{
    [verifyWithMockTestCase(mockLockingArray) lock];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

@end
