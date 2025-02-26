// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
@import XCTest;


@interface ArgumentCaptorTests : XCTestCase
@end

@implementation ArgumentCaptorTests

- (void)testExactTimes_CapturingAllValues_ShouldGiveActualArgumentsWithoutDoubling
{
    NSString *aMock = mock([NSString class]);
    HCArgumentCaptor *captor = [[HCArgumentCaptor alloc] init];

    [aMock stringByAppendingString:@"FOO"];
    [aMock stringByAppendingString:@"BAR"];
    [verifyCount(aMock, times(2)) stringByAppendingString:(id)captor];

    assertThat(captor.allValues, containsIn(@[ @"FOO", @"BAR" ]));
}

@end
