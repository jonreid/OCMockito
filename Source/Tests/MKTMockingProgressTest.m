//
//  OCMockito - MKTMockingProgressTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

// System under test
#import "MKTMockingProgress.h"

// Collaborators
#import "MKTExactTimes.h"
#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTOngoingStubbing.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface MKTMockingProgressTest : SenTestCase
@end

@implementation MKTMockingProgressTest
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

- (void)testPullOngoingStubbingWithoutStubbingReported_ShouldReturnNil
{
    assertThat([mockingProgress pullOngoingStubbing], is(nilValue()));
}

- (void)testPullOngoingStubbingWithStubbingReported_ShouldReturnStubbing
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

- (void)testPullVerificationModeWithoutVerificationStarted_ShouldReturnNil
{
    assertThat([mockingProgress pullVerificationMode], is(nilValue()));
}

- (void)testPullVerificationModeWithVerificationStarted_ShouldReturnMode
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

- (void)testPullInvocationMatcherWithoutSettingMatchers_ShouldBeNil
{
    assertThat([mockingProgress pullInvocationMatcher], is(nilValue()));
}

- (void)testPullInvocationMatcherAfterSetMatcher_ShouldHaveThoseMatchersForAllFunctionArguments
{
    [mockingProgress setMatcher:equalTo(@"irrelevant") forArgument:1];
    MKTInvocationMatcher *invocationMatcher = [mockingProgress pullInvocationMatcher];
    assertThatUnsignedInteger([invocationMatcher argumentMatchersCount], is(equalTo(@2)));
}

- (void)testPullInvocationMatcher_ShouldClearCurrentMatcher
{
    [mockingProgress setMatcher:equalTo(@"irrelevant") forArgument:3];
    [mockingProgress pullInvocationMatcher];
    assertThat([mockingProgress pullInvocationMatcher], is(nilValue()));
}

- (void)testMoreThanOneSetMatcher_ShouldAccumulate
{
    [mockingProgress setMatcher:equalTo(@"irrelevant") forArgument:1];
    [mockingProgress setMatcher:equalTo(@"irrelevant") forArgument:0];
    MKTInvocationMatcher *invocationMatcher = [mockingProgress pullInvocationMatcher];
    assertThatUnsignedInteger([invocationMatcher argumentMatchersCount], is(equalTo(@2)));
}

@end
