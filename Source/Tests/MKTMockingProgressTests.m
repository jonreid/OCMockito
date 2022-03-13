// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTMockingProgress.h"

#import "MKTExactTimes.h"
#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTOngoingStubbing.h"
#import "MKTBaseMockObject.h"

#import <OCHamcrest/OCHamcrest.h>
@import XCTest;


@interface MKTMockingProgressTests : XCTestCase
@end

@implementation MKTMockingProgressTests
{
    MKTMockingProgress *mockingProgress;
    MKTBaseMockObject *baseMockObject;
}

- (void)setUp
{
    [super setUp];
    mockingProgress = [[MKTMockingProgress alloc] init];
    baseMockObject = [[MKTBaseMockObject alloc] init];
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
    assertThat([mockingProgress pullVerificationModeWithMock:baseMockObject], is(nilValue()));
}

- (void)testPullVerificationMode_WithVerificationStarted_ShouldReturnMode
{
    id <MKTVerificationMode> mode = [[MKTExactTimes alloc] initWithCount:42];

    [mockingProgress verificationStarted:mode
                              atLocation:MKTTestLocationMake(self, __FILE__, __LINE__)
                                withMock:baseMockObject];

    assertThat([mockingProgress pullVerificationModeWithMock:baseMockObject], is(sameInstance(mode)));
}

- (void)testPullVerificationMode_ShouldClearCurrentVerification
{
    id <MKTVerificationMode> mode = [[MKTExactTimes alloc] initWithCount:42];

    [mockingProgress verificationStarted:mode
                              atLocation:MKTTestLocationMake(self, __FILE__, __LINE__)
                                withMock:baseMockObject];
    [mockingProgress pullVerificationModeWithMock:baseMockObject];

    assertThat([mockingProgress pullVerificationModeWithMock:baseMockObject], is(nilValue()));
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
