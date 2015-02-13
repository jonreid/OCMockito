//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Emile Cantin

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import "MockTestCase.h"
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface VerifyCountAtMostTimesTests : SenTestCase
@end

@implementation VerifyCountAtMostTimesTests
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

- (void)callRemoveAllObjectsTimes:(int)count
{
    for (int i = 0; i < count; ++i)
        [mockArray removeAllObjects];
}

- (void)testLessThan_WithTooManyInvocations_ShouldFail
{
    [self callRemoveAllObjectsTimes:3];
    
    [verifyCountWithMockTestCase(mockArray, atMost(2)) removeAllObjects];
    
    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testLessThan_WithExactCount_ShouldPass
{
    [self callRemoveAllObjectsTimes:1];
    
    [verifyCount(mockArray, atMost(1)) removeAllObjects];
}

- (void)testLessThan_WithLessInvocations_ShouldPass
{
    [self callRemoveAllObjectsTimes:2];
    
    [verifyCount(mockArray, atMost(3)) removeAllObjects];
}

@end
