//
//  OCMockito - VerifyObjectTest.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

	// Test support
#import "MockTestCase.h"
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif

@interface TestObject : NSObject
@end

@implementation TestObject
- (void)methodWithClassArg:(Class)class { return; }
@end


@interface VerifyObjectTest : SenTestCase
@end

@implementation VerifyObjectTest
{
    NSMutableArray *mockArray;
    MockTestCase *mockTestCase;
}

- (void)setUp
{
    [super setUp];
    mockArray = mock([NSMutableArray class]);
    mockTestCase = [[MockTestCase alloc] init];
}

- (void)tearDown
{
    mockTestCase = nil;
    [super tearDown];
}

- (void)testInvokingMethodShouldPassVerify
{
    // when
    [mockArray removeAllObjects];
    
    // then
    [verify(mockArray) removeAllObjects];
}

- (void)testNotInvokingMethodShouldFailVerify
{
    // when
    [verifyWithMockTestCase(mockArray) removeAllObjects];

    // then
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testInvokingWithEqualObjectArgumentsShouldPassVerify
{
    // when
    [mockArray removeObject:@"same"];
    
    // then
    [verify(mockArray) removeObject:@"same"];
}

- (void)testInvokingWithDifferentObjectArgumentsShouldFailVerify
{
    // when
    [mockArray removeObject:@"same"];
    
    // then
    [verifyWithMockTestCase(mockArray) removeObject:@"different"];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testInvokingWithArgumentMatcherSatisfiedShouldPassVerify
{
    // when
    [mockArray removeObject:@"same"];

    // then
    [verify(mockArray) removeObject:equalTo(@"same")];
}

- (void)testInvokingWithEqualPrimitiveNumericArgumentsShouldPassVerify
{
    // then
    [mockArray removeObjectAtIndex:2];
    
    // then
    [verify(mockArray) removeObjectAtIndex:2];
}

- (void)testInvokingWithDifferentPrimitiveNumericArgumentsShouldFailVerify
{
    // when
    [mockArray removeObjectAtIndex:2];
    [verifyWithMockTestCase(mockArray) removeObjectAtIndex:99];
    
    // then
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testMatcherSatisfiedWithNumericArgumentShouldPassVerify
{
    // when
    [mockArray removeObjectAtIndex:2];
    
    // then
    [[verify(mockArray) withMatcher:greaterThan(@1) forArgument:0]
     removeObjectAtIndex:0];
}

- (void)testShouldSupportShortcutForSpecifyingMatcherForFirstArgument
{
    // when
    [mockArray removeObjectAtIndex:2];
    
    // then
    [[verify(mockArray) withMatcher:greaterThan(@1)] removeObjectAtIndex:0];
}

- (void)testVerifyTimesOneShouldFailForMethodNotInvoked
{
    // when
    [verifyCountWithMockTestCase(mockArray, times(1)) removeAllObjects];

    // then
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testVerifyTimesOneShouldPassForMethodInvokedOnce
{
    // when
    [mockArray removeAllObjects];
    
    // then
    [verifyCount(mockArray, times(1)) removeAllObjects];
}

- (void)testVerifyTimesOneShouldFailForMethodInvokedTwice
{
    // when
    [mockArray removeAllObjects];
    [mockArray removeAllObjects];

    // then
    [verifyCountWithMockTestCase(mockArray, times(1)) removeAllObjects];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testVerifyTimesTwoShouldFailForMethodInvokedOnce
{
    // when
    [mockArray removeAllObjects];
    
    // then
    [verifyCountWithMockTestCase(mockArray, times(2)) removeAllObjects];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testVerifyTimesTwoShouldPassForMethodInvokedTwice
{
    // when
    [mockArray removeAllObjects];
    [mockArray removeAllObjects];
    
    // then
    [verifyCount(mockArray, times(2)) removeAllObjects];
}

- (void)testVerifyTimesTwoShouldFailForMethodInvokedThreeTimes
{
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
    // when
    [verifyCountWithMockTestCase(mockArray, times(1)) removeAllObjects];

    // then
    assertThat([[mockTestCase failureException] description],
               is(@"Expected 1 matching invocation, but received 0"));
}

- (void)testVerifyTimesTwoFailureShouldStateExpectedNumberOfInvocations
{
    // when
    [mockArray removeAllObjects];
    
    // then
    [verifyCountWithMockTestCase(mockArray, times(2)) removeAllObjects];
    assertThat([[mockTestCase failureException] description],
               is(@"Expected 2 matching invocations, but received 1"));
}

- (void)testVerifyNeverShouldPassForMethodInvoked
{
    [verifyCount(mockArray, never()) removeAllObjects];
}

- (void)testVerifyNeverShouldFailForInvokedMethod
{
    // when
    [mockArray removeAllObjects];

    // then
    [verifyCountWithMockTestCase(mockArray, never()) removeAllObjects];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}

- (void)testVerifyWithNilShouldGiveError
{
    // then
    [verifyWithMockTestCase(nil) removeAllObjects];
    assertThat([[mockTestCase failureException] description],
               is(@"Argument passed to verify() should be a mock but is nil"));
}

- (void)testVerifyCountWithNilShouldGiveError
{
    // then
    [verifyCountWithMockTestCase(nil, times(1)) removeAllObjects];
    assertThat([[mockTestCase failureException] description],
               is(@"Argument passed to verifyCount() should be a mock but is nil"));
}

- (void)testVerifyWithNonMockShouldGiveError
{
    // given
    NSMutableArray *realArray = [NSMutableArray array];

    // then
    [verifyWithMockTestCase(realArray) removeAllObjects];
    assertThat([[mockTestCase failureException] description],
               startsWith(@"Argument passed to verify() should be a mock but is type "));
}

- (void)testVerifyCountWithNonMockShouldGiveError
{
    // given
    NSMutableArray *realArray = [NSMutableArray array];

    // then
    [verifyCountWithMockTestCase(realArray, times(1)) removeAllObjects];
    assertThat([[mockTestCase failureException] description],
               startsWith(@"Argument passed to verifyCount() should be a mock but is type "));
}

- (void)testVerifyWithClassArgCountCorrectly
{
    // given
    TestObject *testMock = mock([TestObject class]);
    
    // when
    [testMock methodWithClassArg:[NSString class]];
    [testMock methodWithClassArg:[NSData class]];
    
    // then
    [verify(testMock) methodWithClassArg:[NSString class]];
    [verify(testMock) methodWithClassArg:[NSData class]];
}

@end
