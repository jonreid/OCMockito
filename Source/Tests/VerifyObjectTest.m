//
//  OCMockito - VerifyObjectTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
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

struct MKTStruct {
    int anInt;
    char aChar;
    double *arrayOfDoubles;
};
typedef struct MKTStruct MKTStruct;
#define allocDoubleArray() (double *)malloc(10*sizeof(double));

@interface TestObject : NSObject
@end

@implementation TestObject
- (void)methodWithClassArg:(Class)class { return; }
- (id)methodWithError:(NSError * __strong *)error { return nil; }
- (void)methodWithSelector:(SEL)selector { return; }
- (void)methodWithStruct:(MKTStruct)aStruct { return; }
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
    [mockArray removeAllObjects];
    [verify(mockArray) removeAllObjects];
}

- (void)testNotInvokingMethodShouldFailVerify
{
    [verifyWithMockTestCase(mockArray) removeAllObjects];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

- (void)testInvokingWithEqualObjectArgumentsShouldPassVerify
{
    [mockArray removeObject:@"same"];
    [verify(mockArray) removeObject:@"same"];
}

- (void)testInvokingWithDifferentObjectArgumentsShouldFailVerify
{
    [mockArray removeObject:@"same"];
    [verifyWithMockTestCase(mockArray) removeObject:@"different"];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

- (void)testInvokingWithArgumentMatcherSatisfiedShouldPassVerify
{
    [mockArray removeObject:@"same"];
    [verify(mockArray) removeObject:equalTo(@"same")];
}

- (void)testInvokingWithEqualPrimitiveNumericArgumentsShouldPassVerify
{
    [mockArray removeObjectAtIndex:2];
    [verify(mockArray) removeObjectAtIndex:2];
}

- (void)testInvokingWithDifferentPrimitiveNumericArgumentsShouldFailVerify
{
    [mockArray removeObjectAtIndex:2];
    [verifyWithMockTestCase(mockArray) removeObjectAtIndex:99];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

- (void)testMatcherSatisfiedWithNumericArgumentShouldPassVerify
{
    [mockArray removeObjectAtIndex:2];
    [[verify(mockArray) withMatcher:greaterThan(@1) forArgument:0]
     removeObjectAtIndex:0];
}

- (void)testShouldSupportShortcutForSpecifyingMatcherForFirstArgument
{
    [mockArray removeObjectAtIndex:2];
    [[verify(mockArray) withMatcher:greaterThan(@1)] removeObjectAtIndex:0];
}

- (void)testVerifyTimesOneShouldFailForMethodNotInvoked
{
    [verifyCountWithMockTestCase(mockArray, times(1)) removeAllObjects];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

- (void)testVerifyTimesOneShouldPassForMethodInvokedOnce
{
    [mockArray removeAllObjects];
    [verifyCount(mockArray, times(1)) removeAllObjects];
}

- (void)testVerifyTimesOneShouldFailForMethodInvokedTwice
{
    [mockArray removeAllObjects];
    [mockArray removeAllObjects];
    [verifyCountWithMockTestCase(mockArray, times(1)) removeAllObjects];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

- (void)testVerifyTimesTwoShouldFailForMethodInvokedOnce
{
    [mockArray removeAllObjects];
    [verifyCountWithMockTestCase(mockArray, times(2)) removeAllObjects];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

- (void)testVerifyTimesTwoShouldPassForMethodInvokedTwice
{
    [mockArray removeAllObjects];
    [mockArray removeAllObjects];
    [verifyCount(mockArray, times(2)) removeAllObjects];
}

- (void)testVerifyTimesTwoShouldFailForMethodInvokedThreeTimes
{
    [mockArray removeAllObjects];
    [mockArray removeAllObjects];
    [mockArray removeAllObjects];
    [verifyCountWithMockTestCase(mockArray, times(2)) removeAllObjects];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

- (void)testVerifyTimesOneFailureShouldStateExpectedNumberOfInvocations
{
    [verifyCountWithMockTestCase(mockArray, times(1)) removeAllObjects];
    assertThat([mockTestCase.failureException description],
               is(@"Expected 1 matching invocation, but received 0"));
}

- (void)testVerifyTimesTwoFailureShouldStateExpectedNumberOfInvocations
{
    [mockArray removeAllObjects];
    [verifyCountWithMockTestCase(mockArray, times(2)) removeAllObjects];
    assertThat([mockTestCase.failureException description],
               is(@"Expected 2 matching invocations, but received 1"));
}

- (void)testVerifyNeverShouldPassForMethodInvoked
{
    [verifyCount(mockArray, never()) removeAllObjects];
}

- (void)testVerifyNeverShouldFailForInvokedMethod
{
    [mockArray removeAllObjects];
    [verifyCountWithMockTestCase(mockArray, never()) removeAllObjects];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

- (void)testVerifyWithNilShouldGiveError
{
    [verifyWithMockTestCase(nil) removeAllObjects];
    assertThat([mockTestCase.failureException description],
               is(@"Argument passed to verify() should be a mock but is nil"));
}

- (void)testVerifyCountWithNilShouldGiveError
{
    [verifyCountWithMockTestCase(nil, times(1)) removeAllObjects];
    assertThat([mockTestCase.failureException description],
               is(@"Argument passed to verifyCount() should be a mock but is nil"));
}

- (void)testVerifyWithNonMockShouldGiveError
{
    NSMutableArray *realArray = [NSMutableArray array];
    [verifyWithMockTestCase(realArray) removeAllObjects];
    assertThat([mockTestCase.failureException description],
               startsWith(@"Argument passed to verify() should be a mock but is type "));
}

- (void)testVerifyCountWithNonMockShouldGiveError
{
    NSMutableArray *realArray = [NSMutableArray array];
    [verifyCountWithMockTestCase(realArray, times(1)) removeAllObjects];
    assertThat([mockTestCase.failureException description],
               startsWith(@"Argument passed to verifyCount() should be a mock but is type "));
}

- (void)testVerifyWithClassArgCountCorrectly
{
    TestObject *testMock = mock([TestObject class]);
    [testMock methodWithClassArg:[NSString class]];
    [testMock methodWithClassArg:[NSData class]];
    [verify(testMock) methodWithClassArg:[NSString class]];
    [verify(testMock) methodWithClassArg:[NSData class]];
}

- (void)testVerifyWithErrorHandleArgMatchingNull
{
    TestObject *testMock = mock([TestObject class]);
    [testMock methodWithError:NULL];
    [verify(testMock) methodWithError:NULL];
}

- (void)testVerifyWithErrorHandleArgMatchingValue
{
    TestObject *testMock = mock([TestObject class]);
    NSError *err;
    [testMock methodWithError:&err];
    [verify(testMock) methodWithError:&err];
}

- (void)testVerifyWithErrorHandleArgNotMatching
{
    TestObject *testMock = mock([TestObject class]);
    NSError *err1;
    NSError *err2;
    [testMock methodWithError:&err1];
    [verifyWithMockTestCase(testMock) methodWithError:&err2];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

- (void)testVerifyWithNilSelectorArg
{
    TestObject *testMock = mock([TestObject class]);
    [testMock methodWithSelector:nil];
    [verify(testMock) methodWithSelector:nil];
}

- (void)testVerifyWithNotNilSelectorArg
{
    TestObject *testMock = mock([TestObject class]);
    [testMock methodWithSelector:_cmd];
    [verify(testMock) methodWithSelector:_cmd];
}

- (void)testVerifyWithNotNilStructArgMatchingValueSamePointer
{
    TestObject *testMock = mock([TestObject class]);
    double *a = allocDoubleArray();
    MKTStruct struct1 = {1, 'a', a};
    [testMock methodWithStruct:struct1];
    [verify(testMock) methodWithStruct:struct1];
}

- (void)testVerifyWithNotNilStructArgMatchingValueSameContent
{
    TestObject *testMock = mock([TestObject class]);
    double *a = allocDoubleArray();
    MKTStruct struct1 = {1, 'a', a};
    MKTStruct struct2 = {1, 'a', a};
    [testMock methodWithStruct:struct1];
    [verify(testMock) methodWithStruct:struct2];
}

- (void)testVerifyWithNotNilStructArgNotMatchingDifferentContent
{
    TestObject *testMock = mock([TestObject class]);
    double *a = allocDoubleArray();
    double *b = allocDoubleArray();
    MKTStruct struct1 = {1, 'a', a};
    MKTStruct struct2 = {1, 'a', b};
    [testMock methodWithStruct:struct1];
    [verifyWithMockTestCase(testMock) methodWithStruct:struct2];
    assertThatUnsignedInteger(mockTestCase.failureCount, is(equalTo(@1)));
}

@end
