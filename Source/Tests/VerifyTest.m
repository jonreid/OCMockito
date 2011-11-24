//
//  OCMockito - VerifyTest.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

	// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif

#define verifyWithMockTestCase(mock) MKVerifyWithLocation(mock, mockTestCase, __FILE__, __LINE__)
#define verifyCountWithMockTestCase(mock, mode) MKVerifyCountWithLocation(mock, mode, mockTestCase, __FILE__, __LINE__)


@interface MockTestCase : NSObject
@property(nonatomic, assign) NSUInteger failureCount;
@property(nonatomic, retain) NSException *failureException;
- (void)failWithException:(NSException *)exception;
@end

@implementation MockTestCase
@synthesize failureCount;
@synthesize failureException;

- (void)dealloc
{
    [failureException release];
    [super dealloc];
}

- (void)failWithException:(NSException *)exception
{
    ++failureCount;
    [self setFailureException:exception];
}

@end


#pragma mark -

@interface VerifyTest : SenTestCase
@end

@implementation VerifyTest

- (void)testInvokingMethodShouldPassVerify
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    // when
    [mockArray removeAllObjects];
    
    // then
    [verify(mockArray) removeAllObjects];
}

- (void)testNotInvokingMethodShouldFailVerify
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    // then
    [verifyWithMockTestCase(mockArray) removeAllObjects];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testInvokingWithEqualObjectArgumentsShouldPassVerify
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    // when
    [mockArray removeObject:@"same"];
    
    // then
    [verify(mockArray) removeObject:@"same"];
}

- (void)testInvokingWithDifferentObjectArgumentsShouldFailVerify
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    // when
    [mockArray removeObject:@"same"];
    
    // then
    [verifyWithMockTestCase(mockArray) removeObject:@"different"];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testInvokingWithArgumentMatcherSatisfiedShouldPassVerify
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    // when
    [mockArray removeObject:@"same"];

    // then
    [verify(mockArray) removeObject:equalTo(@"same")];
}

- (void)testInvokingWithEqualPrimitiveNumericArgumentsShouldPassVerify
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    // then
    [mockArray removeObjectAtIndex:2];
    
    // then
    [verify(mockArray) removeObjectAtIndex:2];
}

- (void)testInvokingWithDifferentPrimitiveNumericArgumentsShouldFailVerify
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    // when
    [mockArray removeObjectAtIndex:2];
    [verifyWithMockTestCase(mockArray) removeObjectAtIndex:99];
    
    // then
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testMatcherSatisfiedWithNumericArgumentShouldPassVerify
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    // when
    [mockArray removeObjectAtIndex:2];
    
    // then
    [[verify(mockArray) withMatcher:greaterThan([NSNumber numberWithInt:1]) forArgument:0]
     removeObjectAtIndex:0];
}

- (void)testShouldSupportShortcutForSpecifyingMatcherForFirstArgument
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    // when
    [mockArray removeObjectAtIndex:2];
    
    // then
    [[verify(mockArray) withMatcher:greaterThan([NSNumber numberWithInt:1])] removeObjectAtIndex:0];
}

- (void)testVerifyTimesOneShouldFailForMethodNotInvoked
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    // then
    [verifyCountWithMockTestCase(mockArray, times(1)) removeAllObjects];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testVerifyTimesOneShouldPassForMethodInvokedOnce
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    // when
    [mockArray removeAllObjects];
    
    // then
    [verifyCount(mockArray, times(1)) removeAllObjects];
}

- (void)testVerifyTimesOneShouldFailForMethodInvokedTwice
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    // when
    [mockArray removeAllObjects];
    [mockArray removeAllObjects];

    // then
    [verifyCountWithMockTestCase(mockArray, times(1)) removeAllObjects];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testVerifyTimesTwoShouldFailForMethodInvokedOnce
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    // when
    [mockArray removeAllObjects];
    
    // then
    [verifyCountWithMockTestCase(mockArray, times(2)) removeAllObjects];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testVerifyTimesTwoShouldPassForMethodInvokedTwice
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    // when
    [mockArray removeAllObjects];
    [mockArray removeAllObjects];
    
    // then
    [verifyCount(mockArray, times(2)) removeAllObjects];
}

- (void)testVerifyTimesTwoShouldFailForMethodInvokedThreeTimes
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    // when
    [mockArray removeAllObjects];
    [mockArray removeAllObjects];
    [mockArray removeAllObjects];
    
    // then
    [verifyCountWithMockTestCase(mockArray, times(2)) removeAllObjects];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testVerifyTimesOneFailureShouldStateExpectedNumberOfInvocations
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    // then
    [verifyCountWithMockTestCase(mockArray, times(1)) removeAllObjects];
    assertThat([[mockTestCase failureException] description], is(@"Wanted 1 invocation"));
}

- (void)testVerifyTimesTwoFailureShouldStateExpectedNumberOfInvocations
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    // then
    [verifyCountWithMockTestCase(mockArray, times(2)) removeAllObjects];
    assertThat([[mockTestCase failureException] description], is(@"Wanted 2 invocations"));
}

- (void)testVerifyNeverShouldPassForMethodInvoked
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    // then
    [verifyCount(mockArray, never()) removeAllObjects];
}

- (void)testVerifyNeverShouldFailForInvokedMethod
{
    // given
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    // when
    [mockArray removeAllObjects];

    // then
    [verifyCountWithMockTestCase(mockArray, never()) removeAllObjects];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

@end
