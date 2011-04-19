//
//  OCMockito - MockingProgressTest.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

    // Class under test
#import "MTMockingProgress.h"

    // Collaborators
#import "MTInvocationContainer.h"
#import "MTInvocationMatcher.h"
#import "MTOngoingStubbing.h"
#import "MTTimes.h"

    // Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>


@interface MockingProgressTest : SenTestCase
{
    MTMockingProgress *mockingProgress;
}
@end


@implementation MockingProgressTest

- (void)setUp
{
    [super setUp];
    mockingProgress = [[MTMockingProgress alloc] init];
}


- (void)tearDown
{
    [mockingProgress release];
    [super tearDown];
}


- (void)testPullOngoingStubbingWithoutStubbingReportedShouldBeNil
{
    assertThat([mockingProgress pullOngoingStubbing], is(nilValue()));
}


- (void)testPullOngoingStubbingWithStubbingReportedShouldReturnStubbing
{
    // given
    MTInvocationContainer *invocationContainer = [[[MTInvocationContainer alloc]
                                                   initWithMockingProgress:mockingProgress] autorelease];
    MTOngoingStubbing *ongoingStubbing = [[[MTOngoingStubbing alloc]
                                           initWithInvocationContainer:invocationContainer] autorelease];
    
    // when
    [mockingProgress reportOngoingStubbing:ongoingStubbing];
    
    // then
    assertThat([mockingProgress pullOngoingStubbing], is(sameInstance(ongoingStubbing)));
}


- (void)testPullOngoingStubbingShouldClearCurrentStubbing
{
    // given
    MTInvocationContainer *invocationContainer = [[[MTInvocationContainer alloc]
                                                   initWithMockingProgress:mockingProgress] autorelease];
    MTOngoingStubbing *ongoingStubbing = [[[MTOngoingStubbing alloc]
                                           initWithInvocationContainer:invocationContainer] autorelease];
    
    // when
    [mockingProgress reportOngoingStubbing:ongoingStubbing];
    [mockingProgress pullOngoingStubbing];
    
    // then
    assertThat([mockingProgress pullOngoingStubbing], is(nilValue()));
}


- (void)testPullVerificationModeWithoutVerificationStartedShouldBeNil
{
    assertThat([mockingProgress pullVerificationMode], is(nilValue()));
}


- (void)testPullVerificationModeWithVerificationStartedShouldReturnMode
{
    // given
    id <MTVerificationMode> mode = [MTTimes timesWithCount:42];
    
    // when
    [mockingProgress verificationStarted:mode atLocation:MTTestLocationMake(self, __FILE__, __LINE__)];
    
    // then
    assertThat([mockingProgress pullVerificationMode], is(sameInstance(mode)));
}


- (void)testPullVerificationModeShouldClearCurrentVerification
{
    // given
    id <MTVerificationMode> mode = [MTTimes timesWithCount:42];
    
    // when
    [mockingProgress verificationStarted:mode atLocation:MTTestLocationMake(self, __FILE__, __LINE__)];
    [mockingProgress pullVerificationMode];
    
    // then
    assertThat([mockingProgress pullVerificationMode], is(nilValue()));
}


- (void)testPullInvocationMatcherWithoutSettingMatchersShouldBeNil
{
    assertThat([mockingProgress pullInvocationMatcher], is(nilValue()));
}


- (void)testPullInvocationMatcherAfterSettingMatchersShouldHaveThoseMatchers
{
    [mockingProgress setMatcher:equalTo(@"irrelevant") atIndex:3];
    
    MTInvocationMatcher *invocationMatcher = [mockingProgress pullInvocationMatcher];
    
    assertThatUnsignedInteger([invocationMatcher argumentMatchersCount], equalToUnsignedInteger(4));
}


- (void)testPullInvocationMatcherShouldClearCurrentMatcher
{
    [mockingProgress setMatcher:equalTo(@"irrelevant") atIndex:3];

    [mockingProgress pullInvocationMatcher];
    
    assertThat([mockingProgress pullInvocationMatcher], is(nilValue()));
}


- (void)testMoreThanOneSetMatcherShouldAccumulate
{
    [mockingProgress setMatcher:equalTo(@"irrelevant") atIndex:3];
    [mockingProgress setMatcher:equalTo(@"irrelevant") atIndex:2];

    MTInvocationMatcher *invocationMatcher = [mockingProgress pullInvocationMatcher];
    
    assertThatUnsignedInteger([invocationMatcher argumentMatchersCount], equalToUnsignedInteger(4));
}


@end
