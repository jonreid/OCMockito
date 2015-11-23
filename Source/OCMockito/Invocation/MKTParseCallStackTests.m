//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTParseCallStack.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTParseCallStackTests : XCTestCase
@end

@implementation MKTParseCallStackTests

- (void)testShouldParseModuleNames_WithShortAndLongNames
{
    NSString *ordinary =
            @"  3   ExampleTests                        0x0000000118446bee -[MKTBaseMockObject forwardInvocation:] + 91";
    NSString *longModuleName =
            @"  3   ThisIsAMuchLongerModuleName         0x0000000118446bee -[MKTBaseMockObject forwardInvocation:] + 91";

    NSArray *result = MKTParseCallStack(@[ ordinary, longModuleName ]);

    assertThat(result, containsIn(@[
            hasProperty(@"moduleName", @"ExampleTests"),
            hasProperty(@"moduleName", @"ThisIsAMuchLongerModuleName"),
            ]));
}

- (void)testShouldParseInstructions_FromFunctionsAndMethods
{
    NSString *function =
            @"  5   CoreFoundation                      0x000000010e9f9a98 _CF_forwarding_prep_0 + 120";
    NSString *method =
            @"  6   ExampleTests                        0x0000000118430edc -[ExampleTests testVerifyWithMatcherForPrimitive] + 92";

    NSArray *result = MKTParseCallStack(@[ function, method ]);

    assertThat(result, containsIn(@[
            hasProperty(@"instruction", @"_CF_forwarding_prep_0 + 120"),
            hasProperty(@"instruction", @"-[ExampleTests testVerifyWithMatcherForPrimitive] + 92"),
    ]));
}

@end
