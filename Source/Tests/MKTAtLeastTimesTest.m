//
//  OCMockito - MKTAtLeastTimesTest.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//  
//  Created by Markus Gasser on 18.04.12.
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTAtLeastTimes.h"

#define MOCKITO_SHORTHAND
#import "OCMockito.h"
#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTVerificationData.h"

    // Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
#import <OCHamcrest/OCHamcrest.h>
#else
#import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface MKTAtLeastTimesTest : SenTestCase
{
    BOOL _shouldPassAllExceptionsUp;
}
@end

@implementation MKTAtLeastTimesTest

- (void)testVerificationShouldFailForEmptyDataIfCountIsNonzero
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:1];
    MKTVerificationData *emptyData = [[MKTVerificationData alloc] init];
    emptyData.invocations = [[MKTInvocationContainer alloc] initWithMockingProgress:nil];
    emptyData.wanted = [[MKTInvocationMatcher alloc] init];
    
    // when
    [emptyData.wanted setExpectedInvocation:[NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:"v@:"]]];
    
    // then
    STAssertThrows([atLeastTimes verifyData:emptyData], @"verify should fail for empty data");
}

- (void)testVerificationShouldFailForTooLittleInvocations
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:2];
    MKTVerificationData *emptyData = [[MKTVerificationData alloc] init];
    emptyData.invocations = [[MKTInvocationContainer alloc] initWithMockingProgress:nil];
    emptyData.wanted = [[MKTInvocationMatcher alloc] init];
    
    // when
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:"v@:"]];
    [emptyData.wanted setExpectedInvocation:invocation];
    [emptyData.invocations setInvocationForPotentialStubbing:invocation]; // 1 call to the expected method
    
    // then
    STAssertThrows([atLeastTimes verifyData:emptyData], @"verify should fail for too little invocations");
}

- (void)testVerificationShouldSucceedForMinimumCountZero
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:0];
    MKTVerificationData *emptyData = [[MKTVerificationData alloc] init];
    emptyData.invocations = [[MKTInvocationContainer alloc] initWithMockingProgress:nil];
    emptyData.wanted = [[MKTInvocationMatcher alloc] init];
    
    // when
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:"v@:"]];
    [emptyData.wanted setExpectedInvocation:invocation];
    
    // then
    STAssertNoThrow([atLeastTimes verifyData:emptyData], @"verify should succeed for atLeast(0)");
}

- (void)testVerificationShouldSucceedForExactNumberOfInvocations
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:1];
    MKTVerificationData *emptyData = [[MKTVerificationData alloc] init];
    emptyData.invocations = [[MKTInvocationContainer alloc] initWithMockingProgress:nil];
    emptyData.wanted = [[MKTInvocationMatcher alloc] init];
    
    // when
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:"v@:"]];
    [emptyData.wanted setExpectedInvocation:invocation];
    [emptyData.invocations setInvocationForPotentialStubbing:invocation]; // 1 call to the expected method
    
    // then
    STAssertNoThrow([atLeastTimes verifyData:emptyData], @"verify should succeed for exact number of invocations matched");
}

- (void)testVerificationShouldSucceedForMoreInvocations
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:1];
    MKTVerificationData *emptyData = [[MKTVerificationData alloc] init];
    emptyData.invocations = [[MKTInvocationContainer alloc] initWithMockingProgress:nil];
    emptyData.wanted = [[MKTInvocationMatcher alloc] init];
    
    // when
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:"v@:"]];
    [emptyData.wanted setExpectedInvocation:invocation];
    [emptyData.invocations setInvocationForPotentialStubbing:invocation];
    [emptyData.invocations setInvocationForPotentialStubbing:invocation]; // 2 calls to the expected method
    
    // then
    STAssertNoThrow([atLeastTimes verifyData:emptyData], @"verify should succeed for more invocations matched");
}


#pragma mark - Test From Top-Level

- (void)testAtLeastInActionForExactCount
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    // when
    [mockArray removeAllObjects];
    
    // then
    [verifyCount(mockArray, atLeast(1)) removeAllObjects];
}

- (void)testAtLeastInActionForExcessInvocations
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    // when
    [mockArray addObject:@"foo"];
    [mockArray addObject:@"foo"];
    [mockArray addObject:@"foo"];
    
    // then
    [verifyCount(mockArray, atLeast(2)) addObject:@"foo"];
}

- (void)testAtLeastInActionForTooLittleInvocations
{
    // given
    [self disableFailureHandler]; // enable the handler to catch the exception generated by verify()
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    // when
    [mockArray addObject:@"foo"];
    
    // then
    STAssertThrows(([verifyCount(mockArray, atLeast(2)) addObject:@"foo"]), @"verifyCount() should have failed");
}


#pragma mark - Helper Methods

- (void)disableFailureHandler
{
    _shouldPassAllExceptionsUp = YES;
}

- (void)failWithException:(NSException *)exception
{
    if (_shouldPassAllExceptionsUp)
        @throw exception;
    else
        [super failWithException:exception];
}

@end
