//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTCallStackParser.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTCallStackParserTests : XCTestCase
@end

@implementation MKTCallStackParserTests

- (void)testParse_WithShortAndLongModuleNames_ShouldParseModuleNames
{
    NSString *ordinary =
            @"  3   ExampleTests                        0x0000000118446bee -[MKTBaseMockObject forwardInvocation:] + 91";
    NSString *longModuleName =
            @"  3   ThisIsAMuchLongerModuleName         0x0000000118446bee -[MKTBaseMockObject forwardInvocation:] + 91";
    MKTCallStackParser *sut = [[MKTCallStackParser alloc] init];

    NSArray *result = [sut parse:@[ ordinary, longModuleName ]];

    assertThat(result, containsIn(@[
            hasProperty(@"moduleName", @"ExampleTests"),
            hasProperty(@"moduleName", @"ThisIsAMuchLongerModuleName"),
            ]));
}

- (void)testParse_WithFunctionAndMethod_ShouldParseInstructions
{
    NSString *function =
            @"  5   CoreFoundation                      0x000000010e9f9a98 _CF_forwarding_prep_0 + 120";
    NSString *method =
            @"  6   ExampleTests                        0x0000000118430edc -[ExampleTests testVerifyWithMatcherForPrimitive] + 92";
    MKTCallStackParser *sut = [[MKTCallStackParser alloc] init];

    NSArray *result = [sut parse:@[ function, method ]];

    assertThat(result, containsIn(@[
            hasProperty(@"instruction", @"_CF_forwarding_prep_0 + 120"),
            hasProperty(@"instruction", @"-[ExampleTests testVerifyWithMatcherForPrimitive] + 92"),
    ]));
}

@end
