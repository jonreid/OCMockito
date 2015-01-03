//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface ArgumentCaptorTests : SenTestCase
@end

@implementation ArgumentCaptorTests
{
    MKTArgumentCaptor *sut;
    NSMutableArray *mockArray;
}

- (void)setUp
{
    [super setUp];
    sut = [[MKTArgumentCaptor alloc] init];
    mockArray = mock([NSMutableArray class]);
}

- (void)tearDown
{
    sut = nil;
    [super tearDown];
}

- (void)testValue_ShouldCaptureArgumentValue
{
    [mockArray addObject:@"FOO"];

    [verify(mockArray) addObject:[sut capture]];

    assertThat([sut value], is(@"FOO"));
}

- (void)testValue_ShouldCaptureLastArgumentValue
{
    [mockArray addObject:@"FOO"];
    [mockArray addObject:@"BAR"];

    [verifyCount(mockArray, atLeastOnce()) addObject:[sut capture]];

    assertThat([sut value], is(@"BAR"));
}

- (void)testAllValues_ShouldCaptureAllMatchingInvocations
{
    [mockArray addObject:@"FOO"];
    [mockArray addObject:@"BAR"];

    [verifyCount(mockArray, atLeastOnce()) addObject:[sut capture]];

    assertThat([sut allValues], contains(@"FOO", @"BAR", nil));
}

- (void)testAllValues_ShouldNotCaptureInvocationsThatDoNotMatch
{
    [mockArray addObject:@"FOO"];
    [mockArray removeObject:@"BAR"];

    [verifyCount(mockArray, atLeastOnce()) addObject:[sut capture]];

    assertThat([sut allValues], contains(@"FOO", nil));
}

- (void)testShouldCapturePrimitiveArgument
{
    [mockArray replaceObjectAtIndex:42 withObject:[NSNull null]];

    [[verify(mockArray) withMatcher:[sut capture] forArgument:0]
            replaceObjectAtIndex:0 withObject:anything()];

    assertThat([sut value], is(@42));
}

- (void)testShouldCaptureBlockArgument
{
    [mockArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:0];
    }];

    [verify(mockArray) sortUsingComparator:[sut capture]];

    NSComparator block = [sut value];
    assertThat(@(block(@"a", @"z")), is(@(NSOrderedAscending)));
}

@end
