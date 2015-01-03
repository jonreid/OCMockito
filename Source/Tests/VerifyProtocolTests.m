//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import "MockTestCase.h"
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface VerifyProtocolTests : SenTestCase
@end

@implementation VerifyProtocolTests
{
    id <NSLocking> mockLock;
    id <NSKeyedArchiverDelegate> mockDelegate;
    MockTestCase *mockTestCase;
    NSKeyedArchiver *archiver;
}

- (void)setUp
{
    [super setUp];
    mockLock = mockProtocol(@protocol(NSLocking));
    mockDelegate = mockProtocol(@protocol(NSKeyedArchiverDelegate));
    mockTestCase = [[MockTestCase alloc] init];
    archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:[NSMutableData data]];
}

- (void)tearDown
{
    [archiver finishEncoding];
    [super tearDown];
}

- (void)testInvokingMethod_ShouldPassVerify
{
    [mockLock lock];

    [verify(mockLock) lock];
}

- (void)testNotInvokingMethod_ShouldFailVerify
{
    [verifyWithMockTestCase(mockLock) lock];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testInvokingWithEqualObjectArguments_ShouldPassVerify
{
    [mockDelegate archiver:archiver willEncodeObject:@"same"];

    [verify(mockDelegate) archiver:archiver willEncodeObject:@"same"];
}

- (void)testInvokingWithDifferentObjectArguments_ShouldFailVerify
{
    [mockDelegate archiver:archiver willEncodeObject:@"same"];

    [verifyWithMockTestCase(mockDelegate) archiver:archiver willEncodeObject:@"different"];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testInvokingWithArgumentMatcherSatisfied_ShouldPassVerify
{
    [mockDelegate archiver:archiver willEncodeObject:@"same"];

    [verify(mockDelegate) archiver:archiver willEncodeObject:equalTo(@"same")];
}

@end
