//
//  OCMockito - ArgumentCaptorTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#define MOCKITO_SHORTHAND
#import "OCMockito.h"
#import "MKTArgumentCaptor.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface ArgumentCaptorTest : SenTestCase
@end

@implementation ArgumentCaptorTest
{
    MKTArgumentCaptor *argument;
    NSMutableArray *mockArray;
}

- (void)setUp
{
    [super setUp];
    argument = [[MKTArgumentCaptor alloc] init];
    mockArray = mock([NSMutableArray class]);
}

- (void)testArgumentCaptor_ShouldCaptureObject
{
    [mockArray addObject:@"FOO"];
    [verify(mockArray) addObject:[argument capture]];
    assertThat([argument value], is(@"FOO"));
}

- (void)testArgumentCaptor_ShouldCapturePrimitive
{
    [mockArray replaceObjectAtIndex:42 withObject:[NSNull null]];
    [[verify(mockArray) withMatcher:[argument capture] forArgument:0]
            replaceObjectAtIndex:0 withObject:anything()];
    assertThat([argument value], is(@42));
}

- (void)testArgumentCaptor_ShouldCaptureBlock
{
    [mockArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:0];
    }];
    [verify(mockArray) sortUsingComparator:[argument capture]];
    NSComparator block = [argument value];
    assertThatInt(block(@"a", @"z"), equalToInt(NSOrderedAscending));
}

@end
