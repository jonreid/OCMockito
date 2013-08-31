//
//  OCMockito - MKTAtLeastTimesTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
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
@end

@implementation MKTAtLeastTimesTest
{
    BOOL shouldPassAllExceptionsUp;
    MKTVerificationData *emptyData;
    NSInvocation *invocation;
    NSTimeInterval timeout;
}

- (void)setUp
{
    [super setUp];
    emptyData = [[MKTVerificationData alloc] init];
    [emptyData setInvocations:[[MKTInvocationContainer alloc] init]];
    [emptyData setWanted:[[MKTInvocationMatcher alloc] init]];
    invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:"v@:"]];

    // Reduce the timeout, so the test do not take that much
    timeout = MKT_eventuallyDefaultTimeout();
    MKT_setEventuallyDefaultTimeout(0.1);
}

- (void)tearDown
{
    MKT_setEventuallyDefaultTimeout(timeout);
    emptyData = nil;
    [super tearDown];
}

- (void)testVerificationShouldFailForEmptyDataIfCountIsNonzero
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:1 eventually:NO];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    
    // then
    STAssertThrows([atLeastTimes verifyData:emptyData], @"verify should throw an exception for empty data");
}

- (void)testVerificationShouldEventuallyFailForEmptyDataIfCountIsNonzero
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:1 eventually:YES];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];

    // then
    STAssertThrows([atLeastTimes verifyData:emptyData], @"verify should eventually throw an exception for empty data");
}

- (void)testVerificationShouldFailForTooLittleInvocations
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:2 eventually:NO];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation]; // 1 call, but expect 2
    
    // then
    STAssertThrows([atLeastTimes verifyData:emptyData], @"verify should throw an exception for too little invocations");
}

- (void)testVerificationShouldEventuallyFailForTooLittleInvocations
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:2 eventually:YES];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation]; // 1 call, but expect 2

    // then
    STAssertThrows([atLeastTimes verifyData:emptyData], @"verify should eventually throw an exception for too little invocations");
}

- (void)testVerificationShouldSucceedForMinimumCountZero
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:0 eventually:NO];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    
    // then
    STAssertNoThrow([atLeastTimes verifyData:emptyData], @"verify should succeed for atLeast(0)");
}

- (void)testVerificationShouldEventuallySucceedForMinimumCountZero
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:0 eventually:YES];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];

    // then
    STAssertNoThrow([atLeastTimes verifyData:emptyData], @"verify should eventually succeed for atLeast(0)");
}

- (void)testVerificationShouldSucceedForExactNumberOfInvocations
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:1 eventually:NO];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation];
    
    // then
    STAssertNoThrow([atLeastTimes verifyData:emptyData], @"verify should succeed for exact number of invocations matched");
}

- (void)testVerificationShouldEventuallySucceedForExactNumberOfInvocations
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:1 eventually:YES];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation];

    // then
    STAssertNoThrow([atLeastTimes verifyData:emptyData], @"verify should eventually succeed for exact number of invocations matched");
}

- (void)testVerificationShouldAsynchronouslySucceedForExactNumberOfInvocations
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:1 eventually:YES];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[emptyData invocations] setInvocationForPotentialStubbing:invocation];
    });

    // then
    STAssertNoThrow([atLeastTimes verifyData:emptyData], @"verify should eventually succeed for exact number of invocations matched");
}

- (void)testVerificationShouldSucceedForMoreInvocations
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:1 eventually:NO];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation]; // 2 calls to the expected method
    
    // then
    STAssertNoThrow([atLeastTimes verifyData:emptyData], @"verify should succeed for more invocations matched");
}

- (void)testVerificationShouldEventuallySucceedForMoreInvocations
{
    // given
    MKTAtLeastTimes *atLeastTimes = [MKTAtLeastTimes timesWithMinimumCount:1 eventually:YES];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation]; // 2 calls to the expected method

    // then
    STAssertNoThrow([atLeastTimes verifyData:emptyData], @"verify should eventually succeed for more invocations matched");
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

- (void)testEventuallyAtLeastInActionForExactCount
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [mockArray removeAllObjects];
    });

    // then
    [verifyCount(mockArray, eventuallyAtLeast(1)) removeAllObjects];
}

- (void)testAtLeastOnceInActionForExactCount
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    [mockArray removeAllObjects];

    // then
    [verifyCount(mockArray, atLeastOnce()) removeAllObjects];
}

- (void)testEventuallyAtLeastOnceInActionForExactCount
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [mockArray removeAllObjects];
    });

    // then
    [verifyCount(mockArray, eventuallyAtLeastOnce()) removeAllObjects];
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

- (void)testEventuallyAtLeastInActionForExcessInvocations
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [mockArray addObject:@"foo"];
        [mockArray addObject:@"foo"];
        [mockArray addObject:@"foo"];
    });

    // then
    [verifyCount(mockArray, eventuallyAtLeast(2)) addObject:@"foo"];
}

- (void)testAtLeastOnceInActionForExcessInvocations
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    [mockArray addObject:@"foo"];
    [mockArray addObject:@"foo"];

    // then
    [verifyCount(mockArray, atLeastOnce()) addObject:@"foo"];
}

- (void)testEventuallyAtLeastOnceInActionForExcessInvocations
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [mockArray addObject:@"foo"];
        [mockArray addObject:@"foo"];
    });

    // then
    [verifyCount(mockArray, eventuallyAtLeastOnce()) addObject:@"foo"];
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

- (void)testEventuallyAtLeastInActionForTooLittleInvocations
{
    // given
    [self disableFailureHandler]; // enable the handler to catch the exception generated by verify()
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 500*NSEC_PER_MSEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [mockArray addObject:@"foo"];
    });

    // then
    STAssertThrows(([verifyCount(mockArray, eventuallyAtLeast(2)) addObject:@"foo"]), @"verifyCount() should have failed");
}


#pragma mark - Helper Methods

- (void)disableFailureHandler
{
    shouldPassAllExceptionsUp = YES;
}

- (void)failWithException:(NSException *)exception
{
    if (shouldPassAllExceptionsUp)
        @throw exception;
    else
        [super failWithException:exception];
}

@end
