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

@end
