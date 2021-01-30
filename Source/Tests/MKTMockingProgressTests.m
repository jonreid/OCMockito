//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import "MKTMockingProgress.h"

#import "MKTExactTimes.h"
#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTOngoingStubbing.h"

#import <OCHamcrest/OCHamcrest.h>
@import XCTest;


@interface MKTMockingProgressTests : XCTestCase
@end

@implementation MKTMockingProgressTests
{
    MKTMockingProgress *mockingProgress;
}

- (void)setUp
{
    [super setUp];
    mockingProgress = [[MKTMockingProgress alloc] init];
}

- (void)tearDown
{
    mockingProgress = nil;
    [super tearDown];
}

- (void)testPullOngoingStubbing_WithoutStubbingReported_ShouldReturnNil
{
    assertThat([mockingProgress pullOngoingStubbing], is(nilValue()));
}

- (void)testPullOngoingStubbing_WithStubbingReported_ShouldReturnStubbing
{
    MKTInvocationContainer *invocationContainer = [[MKTInvocationContainer alloc] init];
    MKTOngoingStubbing *ongoingStubbing = [[MKTOngoingStubbing alloc]
                                           initWithInvocationContainer:invocationContainer];

    [mockingProgress reportOngoingStubbing:ongoingStubbing];

    assertThat([mockingProgress pullOngoingStubbing], is(sameInstance(ongoingStubbing)));
}

- (void)testPullOngoingStubbing_ShouldClearCurrentStubbing
{
    MKTInvocationContainer *invocationContainer = [[MKTInvocationContainer alloc] init];
    MKTOngoingStubbing *ongoingStubbing = [[MKTOngoingStubbing alloc]
                                           initWithInvocationContainer:invocationContainer];

    [mockingProgress reportOngoingStubbing:ongoingStubbing];
    [mockingProgress pullOngoingStubbing];

    assertThat([mockingProgress pullOngoingStubbing], is(nilValue()));
}

- (void)testPullVerificationMode_WithoutVerificationStarted_ShouldReturnNil
{
    assertThat([mockingProgress pullVerificationMode], is(nilValue()));
}

- (void)testPullVerificationMode_WithVerificationStarted_ShouldReturnMode
{
    id <MKTVerificationMode> mode = [[MKTExactTimes alloc] initWithCount:42];

    [mockingProgress verificationStarted:mode atLocation:MKTTestLocationMake(self, __FILE__, __LINE__)];

    assertThat([mockingProgress pullVerificationMode], is(sameInstance(mode)));
}

- (void)testPullVerificationMode_ShouldClearCurrentVerification
{
    id <MKTVerificationMode> mode = [[MKTExactTimes alloc] initWithCount:42];

    [mockingProgress verificationStarted:mode atLocation:MKTTestLocationMake(self, __FILE__, __LINE__)];
    [mockingProgress pullVerificationMode];

    assertThat([mockingProgress pullVerificationMode], is(nilValue()));
}

- (void)testPullInvocationMatcher_WithoutSettingMatchers_ShouldReturnNil
{
    assertThat([mockingProgress pullInvocationMatcher], is(nilValue()));
}

- (void)testPullInvocationMatcher_AfterSetMatcher_ShouldHaveThoseMatchersForAllFunctionArguments
{
    [mockingProgress setMatcher:equalTo(@"IRRELEVANT") forArgument:1];

    MKTInvocationMatcher *invocationMatcher = [mockingProgress pullInvocationMatcher];

    assertThat(invocationMatcher.matchers, hasCountOf(2));
}

- (void)testPullInvocationMatcher_ShouldClearCurrentMatcher
{
    [mockingProgress setMatcher:equalTo(@"IRRELEVANT") forArgument:3];

    [mockingProgress pullInvocationMatcher];

    assertThat([mockingProgress pullInvocationMatcher], is(nilValue()));
}

- (void)testMultipleSetMatcherCalls_ShouldAccumulateInArgumentMatchersCount
{
    [mockingProgress setMatcher:equalTo(@"IRRELEVANT") forArgument:1];
    [mockingProgress setMatcher:equalTo(@"IRRELEVANT") forArgument:0];

    MKTInvocationMatcher *invocationMatcher = [mockingProgress pullInvocationMatcher];

    assertThat(invocationMatcher.matchers, hasCountOf(2));
}

@end
