//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import "MockTestCase.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>

struct MKTStruct {
    int anInt;
    char aChar;
    double *arrayOfDoubles;
};
typedef struct MKTStruct MKTStruct;

static inline double *createArrayOf10Doubles(void)
{
    return malloc(10 * sizeof(double));
}


@interface TestObject : NSObject
@end

@implementation TestObject
- (void)methodWithClassArg:(Class)class { return; }
- (id)methodWithError:(NSError * __strong *)error { return nil; }
- (void)methodWithSelector:(SEL)selector { return; }
- (void)methodWithStruct:(MKTStruct)aStruct { return; }
@end


@interface VerifyObjectTests : XCTestCase
@end

@implementation VerifyObjectTests
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
    mockArray = nil;
    mockTestCase = nil;
    [super tearDown];
}

- (void)testVerify_WithMethodInvoked_ShouldPass
{
    [mockArray removeAllObjects];

    [verify(mockArray) removeAllObjects];
}

- (void)testVerify_WithMethodNotInvoked_ShouldFail
{
    [verifyWithMockTestCase(mockArray, mockTestCase) removeAllObjects];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testVerify_WithEqualObjectArguments_ShouldPass
{
    [mockArray removeObject:@"same"];

    [verify(mockArray) removeObject:@"same"];
}

- (void)testVerify_WithDifferentObjectArguments_ShouldFail
{
    [mockArray removeObject:@"same"];

    [verifyWithMockTestCase(mockArray, mockTestCase) removeObject:@"different"];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testVerify_ShouldIgnoreAlreadyVerifiedInvocations
{
    [mockArray removeObject:@"same"];
    [verify(mockArray) removeObject:@"same"];

    [mockArray removeObject:@"same"];
    [verify(mockArray) removeObject:@"same"];
}

- (void)testVerify_WithArgumentSatisfyingMatcher_ShouldPass
{
    [mockArray removeObject:@"same"];

    [verify(mockArray) removeObject:equalTo(@"same")];
}

- (void)testVerify_WithEqualPrimitiveNumericArgs_ShouldPass
{
    [mockArray removeObjectAtIndex:2];

    [verify(mockArray) removeObjectAtIndex:2];
}

- (void)testVerify_WithUnequalPrimitiveNumericArgs_ShouldFail
{
    [mockArray removeObjectAtIndex:2];

    [verifyWithMockTestCase(mockArray, mockTestCase) removeObjectAtIndex:99];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testVerify_WithPrimitiveNumericArgSatisfyingMatcher_ShouldPass
{
    [mockArray removeObjectAtIndex:2];

    [[verify(mockArray) withMatcher:greaterThan(@1) forArgument:0]
            removeObjectAtIndex:0];
}

- (void)testShouldSupportShortcutForSpecifyingMatcherForFirstArgument
{
    [mockArray removeObjectAtIndex:2];

    [[verify(mockArray) withMatcher:greaterThan(@1)]
            removeObjectAtIndex:0];
}

- (void)testVerify_WithClassArg_ShouldOnlyCountInvocationsWithMatchingArg
{
    TestObject *testMock = mock([TestObject class]);

    [testMock methodWithClassArg:[NSString class]];
    [testMock methodWithClassArg:[NSData class]];

    [verify(testMock) methodWithClassArg:[NSString class]];
}

- (void)testVerifyingMethodWithHandleArg_ShouldMatchNull
{
    TestObject *testMock = mock([TestObject class]);

    [testMock methodWithError:NULL];

    [verify(testMock) methodWithError:NULL];
}

- (void)testVerifyingMethodWithHandleArg_WithSameHandle_ShouldPass
{
    TestObject *testMock = mock([TestObject class]);
    NSError *err;

    [testMock methodWithError:&err];

    [verify(testMock) methodWithError:&err];
}

- (void)testVerifyingMethodWithHandleArg_WithDifferentHandle_ShouldFail
{
    TestObject *testMock = mock([TestObject class]);
    NSError *err1;
    NSError *err2;

    [testMock methodWithError:&err1];
    [verifyWithMockTestCase(testMock, mockTestCase) methodWithError:&err2];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testVerifyingMethodWithSelectorArg_WithNil_ShouldMatch
{
    TestObject *testMock = mock([TestObject class]);

    [testMock methodWithSelector:nil];

    [verify(testMock) methodWithSelector:nil];
}

- (void)testVerifyingMethodWithSelectorArg_WithSameSelector_ShouldMatch
{
    TestObject *testMock = mock([TestObject class]);

    [testMock methodWithSelector:@selector(lastObject)];

    [verify(testMock) methodWithSelector:@selector(lastObject)];
}

- (void)testVerifyingMethodWithSelectorArg_WithDifferentSelector_ShouldNotMatch
{
    TestObject *testMock = mock([TestObject class]);
    [testMock methodWithSelector:@selector(lastObject)];

    [verifyWithMockTestCase(testMock, mockTestCase) methodWithSelector:@selector(removeAllObjects)];

    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testVerifyingMethodWithStructArg_WithSameStruct_ShouldMatch
{
    TestObject *testMock = mock([TestObject class]);
    double *a = createArrayOf10Doubles();
    MKTStruct struct1 = {1, 'a', a};

    [testMock methodWithStruct:struct1];

    [verify(testMock) methodWithStruct:struct1];

    free(a);
}

- (void)testVerifyingMethodWithStructArg_WithEqualStruct_ShouldMatch
{
    TestObject *testMock = mock([TestObject class]);
    double *a = createArrayOf10Doubles();
    MKTStruct struct1 = {1, 'a', a};
    MKTStruct struct2 = {1, 'a', a};

    [testMock methodWithStruct:struct1];

    [verify(testMock) methodWithStruct:struct2];

    free(a);
}

- (void)testVerifyingMethodWithStructArg_WithDifferentStruct_ShouldNotMatch
{
    TestObject *testMock = mock([TestObject class]);
    double *a = createArrayOf10Doubles();
    double *b = createArrayOf10Doubles();
    MKTStruct struct1 = {1, 'a', a};
    MKTStruct struct2 = {1, 'a', b};
    [testMock methodWithStruct:struct1];

    [verifyWithMockTestCase(testMock, mockTestCase) methodWithStruct:struct2];

    assertThat(@(mockTestCase.failureCount), is(@1));

    free(a);
    free(b);
}

@end
