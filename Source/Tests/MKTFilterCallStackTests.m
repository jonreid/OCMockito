//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTFilterCallStack.h"

#import "MKTParseCallStack.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTFilterCallStackTests : XCTestCase
@end

@implementation MKTFilterCallStackTests

- (void)testFilter_ShouldScanPastForwardInvocation_ThenScanFromBottomForMatchingModuleName
{
    NSArray *callStack = @[
@"0   ExampleTests                        0x000000011844a79c -[MKTInvocation initWithInvocation:] + 121",
@"1   ExampleTests                        0x000000011844412e -[MKTInvocationContainer setInvocationForPotentialStubbing:] + 92",
@"2   ExampleTests                        0x0000000118446f60 -[MKTBaseMockObject prepareInvocationForStubbing:] + 79",
@"3   ExampleTests                        0x0000000118446bee -[MKTBaseMockObject forwardInvocation:] + 91",
@"4   CoreFoundation                      0x000000010e9f9d07 ___forwarding___ + 487",
@"5   CoreFoundation                      0x000000010e9f9a98 _CF_forwarding_prep_0 + 120",
@"6   ExampleTests                        0x0000000118430edc -[ExampleTests testVerifyWithMatcherForPrimitive] + 92",
@"7   CoreFoundation                      0x000000010e9927ac __invoking___ + 140",
@"8   CoreFoundation                      0x000000010e9925fe -[NSInvocation invoke] + 286",
@"9   XCTest                              0x000000010dfc4820 __24-[XCTestCase invokeTest]_block_invoke_2 + 159",
@"10  XCTest                              0x000000010dff77c2 -[XCTestContext performInScope:] + 184",
@"11  XCTest                              0x000000010dfc4770 -[XCTestCase invokeTest] + 169",
@"12  XCTest                              0x000000010dfc4c0b -[XCTestCase performTest:] + 443",
@"13  XCTest                              0x000000010dfc28d1 -[XCTestSuite performTest:] + 377",
@"14  XCTest                              0x000000010dfc28d1 -[XCTestSuite performTest:] + 377",
@"15  XCTest                              0x000000010dfc28d1 -[XCTestSuite performTest:] + 377",
@"16  XCTest                              0x000000010dfafadc __25-[XCTestDriver _runSuite]_block_invoke + 51",
@"17  XCTest                              0x000000010dfd02e3 -[XCTestObservationCenter _observeTestExecutionForBlock:] + 615",
@"18  XCTest                              0x000000010dfafa28 -[XCTestDriver _runSuite] + 408",
@"19  XCTest                              0x000000010dfb0787 -[XCTestDriver _checkForTestManager] + 263",
@"20  XCTest                              0x000000010dff8b23 _XCTestMain + 628",
@"21  xctest                              0x000000010df3725c xctest + 8796",
@"22  libdyld.dylib                       0x0000000110e3192d start + 1",
    ];
    NSArray *parsedCallStack = MKTParseCallStack(callStack);

    NSArray *filteredCallStack = MKTFilterCallStack(parsedCallStack);

    assertThat(filteredCallStack, containsIn(@[
            hasProperty(@"instruction", @"-[ExampleTests testVerifyWithMatcherForPrimitive] + 92")]));
}

@end
