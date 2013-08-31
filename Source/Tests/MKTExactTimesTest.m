//
//  OCMockito - MKTExactTimesTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//  
//  Created by Daniel Rodríguez Troitiño on 30.08.13.
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTExactTimes.h"

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


@interface MKTExactTimesTest : SenTestCase
@end

@implementation MKTExactTimesTest
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
    MKTExactTimes *exactTimes = [MKTExactTimes timesWithCount:1 eventually:NO];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    
    // then
    STAssertThrows([exactTimes verifyData:emptyData], @"verify should throw an exception for empty data");
}

- (void)testVerificationShouldEventuallyFailForEmptyDataIfCountIsNonzero
{
    // given
    MKTExactTimes *exactTimes = [MKTExactTimes timesWithCount:1 eventually:YES];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];

    // then
    STAssertThrows([exactTimes verifyData:emptyData], @"verify should eventually throw an exception for empty data");
}

- (void)testVerificationShouldFailForTooLittleInvocations
{
    // given
    MKTExactTimes *exactTimes = [MKTExactTimes timesWithCount:2 eventually:NO];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation]; // 1 call, but expect 2
    
    // then
    STAssertThrows([exactTimes verifyData:emptyData], @"verify should throw an exception for too little invocations");
}

- (void)testVerificationShouldEventuallyFailForTooLittleInvocations
{
    // given
    MKTExactTimes *exactTimes = [MKTExactTimes timesWithCount:2 eventually:YES];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation]; // 1 call, but expect 2

    // then
    STAssertThrows([exactTimes verifyData:emptyData], @"verify should eventually throw an exception for too little invocations");
}

- (void)testVerificationShouldSucceedForMinimumCountZero
{
    // given
    MKTExactTimes *exactTimes = [MKTExactTimes timesWithCount:0 eventually:NO];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    
    // then
    STAssertNoThrow([exactTimes verifyData:emptyData], @"verify should succeed for times(0)");
}

- (void)testVerificationShouldEventuallySucceedForMinimumCountZero
{
    // given
    MKTExactTimes *exactTimes = [MKTExactTimes timesWithCount:0 eventually:YES];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];

    // then
    STAssertNoThrow([exactTimes verifyData:emptyData], @"verify should eventually succeed for eventuallyTimes(0)");
}

- (void)testVerificationShouldSucceedForExactNumberOfInvocations
{
    // given
    MKTExactTimes *exactTimes = [MKTExactTimes timesWithCount:1 eventually:NO];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation];
    
    // then
    STAssertNoThrow([exactTimes verifyData:emptyData], @"verify should succeed for exact number of invocations matched");
}

- (void)testVerificationShouldEventuallySucceedForExactNumberOfInvocations
{
    // given
    MKTExactTimes *exactTimes = [MKTExactTimes timesWithCount:1 eventually:YES];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation];

    // then
    STAssertNoThrow([exactTimes verifyData:emptyData], @"verify should eventually succeed for exact number of invocations matched");
}

- (void)testVerificationShouldAsynchronouslySucceedForExactNumberOfInvocations
{
    // given
    MKTExactTimes *exactTimes = [MKTExactTimes timesWithCount:1 eventually:YES];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[emptyData invocations] setInvocationForPotentialStubbing:invocation];
    });

    // then
    STAssertNoThrow([exactTimes verifyData:emptyData], @"verify should eventually succeed for exact number of invocations matched");
}

- (void)testVerificationShouldFailForMoreInvocations
{
    // given
    MKTExactTimes *exactTimes = [MKTExactTimes timesWithCount:1 eventually:NO];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation]; // 2 calls to the expected method
    
    // then
    STAssertThrows([exactTimes verifyData:emptyData], @"verify should throw an exception for more invocations matched");
}

- (void)testVerificationShouldEventuallyFailForMoreInvocations
{
    // given
    MKTExactTimes *exactTimes = [MKTExactTimes timesWithCount:1 eventually:YES];

    // when
    [[emptyData wanted] setExpectedInvocation:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation];
    [[emptyData invocations] setInvocationForPotentialStubbing:invocation]; // 2 calls to the expected method

    // then
    STAssertThrows([exactTimes verifyData:emptyData], @"verify should eventually throw an exception for more invocations matched");
}


#pragma mark - Test From Top-Level

- (void)testTimesInActionForExactCount
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    [mockArray removeAllObjects];

    // then
    [verifyCount(mockArray, times(1)) removeAllObjects];
}

- (void)testEventuallyTimesInActionForExactCount
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [mockArray removeAllObjects];
    });

    // then
    [verifyCount(mockArray, eventuallyTimes(1)) removeAllObjects];
}

- (void)testNeverInActionForExactCount
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    // nothing

    // then
    [verifyCount(mockArray, never()) removeAllObjects];
}

- (void)testEventuallyNeverInActionForExactCount
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    // nothing

    // then
    [verifyCount(mockArray, eventuallyNever()) removeAllObjects];
}

- (void)testTimesInActionForExcessInvocations
{
    // given
    [self disableFailureHandler]; // enable the handler to catch the exception generated by verify()
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    [mockArray addObject:@"foo"];
    [mockArray addObject:@"foo"];
    [mockArray addObject:@"foo"];

    // then
    STAssertThrows(([verifyCount(mockArray, times(2)) addObject:@"foo"]), @"verifyCount() should have failed");
}

- (void)testEventuallyTimesInActionForExcessInvocations
{
    // given
    [self disableFailureHandler]; // enable the handler to catch the exception generated by verify()
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 500*NSEC_PER_MSEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [mockArray addObject:@"foo"];
        [mockArray addObject:@"foo"];
        [mockArray addObject:@"foo"];
    });

    // then
    STAssertThrows(([verifyCount(mockArray, eventuallyTimes(2)) addObject:@"foo"]), @"verifyCount() should have failed");
}

- (void)testNeverInActionForExcessInvocations
{
    // given
    [self disableFailureHandler]; // enable the handler to catch the exception generated by verify()
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    [mockArray addObject:@"foo"];

    // then
    STAssertThrows(([verifyCount(mockArray, never()) addObject:@"foo"]), @"verifyCount() should have failed");
}

- (void)testEventuallyNeverInActionForExcessInvocations
{
    // given
    [self disableFailureHandler]; // enable the handler to catch the exception generated by verify()
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [mockArray addObject:@"foo"];
    });

    // then
    STAssertThrows(([verifyCount(mockArray, eventuallyNever()) addObject:@"foo"]), @"verifyCount() should have failed");
}

- (void)testTimesInActionForTooLittleInvocations
{
    // given
    [self disableFailureHandler]; // enable the handler to catch the exception generated by verify()
    NSMutableArray *mockArray = mock([NSMutableArray class]);

    // when
    [mockArray addObject:@"foo"];

    // then
    STAssertThrows(([verifyCount(mockArray, times(2)) addObject:@"foo"]), @"verifyCount() should have failed");
}

- (void)testEventuallyTimesInActionForTooLittleInvocations
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
    STAssertThrows(([verifyCount(mockArray, eventuallyTimes(2)) addObject:@"foo"]), @"verifyCount() should have failed");
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
