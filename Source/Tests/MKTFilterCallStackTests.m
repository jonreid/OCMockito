//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "MKTFilterCallStack.h"

#import "MKTParseCallStack.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTFilterCallStackTests : XCTestCase
@end

@implementation MKTFilterCallStackTests

- (void)testFilter_ShouldScanPastForwardInvocation_ThenScanFromBottomPastXCTestForMatchingModuleName
{
    NSArray *callStack = @[
@"0   FooTests                            0x0000000119e77d7e -[MKTLocation init] + 46",
@"1   FooTests                            0x0000000119e75a44 -[MKTInvocation initWithInvocation:] + 100",
@"2   FooTests                            0x0000000119e75e93 -[MKTInvocationContainer setInvocationForPotentialStubbing:] + 99",
@"3   FooTests                            0x0000000119e72669 -[MKTBaseMockObject prepareInvocationForStubbing:] + 89",
@"4   FooTests                            0x0000000119e7218a -[MKTBaseMockObject forwardInvocation:] + 154",
@"5   CoreFoundation                      0x000000010f017727 ___forwarding___ + 487",
@"6   CoreFoundation                      0x000000010f0174b8 _CF_forwarding_prep_0 + 120",
@"7   Foo                                 0x000000010cb44a2f -[Foo callDoneWithOnce] + 111",
@"8   Foo                                 0x000000010cb449ab -[Foo doIt] + 43",
@"9   FooTests                            0x0000000119e5ba82 -[FooTests testFoo_ShouldBar] + 130",
@"10  CoreFoundation                      0x000000010efb01cc __invoking___ + 140",
@"11  CoreFoundation                      0x000000010efb001e -[NSInvocation invoke] + 286",
@"12  XCTest                              0x0000000116c80080 __24-[XCTestCase invokeTest]_block_invoke_2 + 159",
@"13  XCTest                              0x0000000116cb3b14 -[XCTestContext performInScope:] + 184",
@"14  XCTest                              0x0000000116c7ffd0 -[XCTestCase invokeTest] + 169",
@"15  XCTest                              0x0000000116c8046b -[XCTestCase performTest:] + 443",
@"16  XCTest                              0x0000000116c7e131 -[XCTestSuite performTest:] + 377",
@"17  XCTest                              0x0000000116c7e131 -[XCTestSuite performTest:] + 377",
@"18  XCTest                              0x0000000116c7e131 -[XCTestSuite performTest:] + 377",
@"19  XCTest                              0x0000000116c8bb5b -[XCTestObservationCenter _observeTestExecutionForBlock:] + 615",
@"20  XCTest                              0x0000000116cb5041 _XCTestMain + 1052",
@"21  CoreFoundation                      0x000000010efeda1c __CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__ + 12",
@"22  CoreFoundation                      0x000000010efe36a5 __CFRunLoopDoBlocks + 341",
@"23  CoreFoundation                      0x000000010efe2e02 __CFRunLoopRun + 850",
@"24  CoreFoundation                      0x000000010efe2828 CFRunLoopRunSpecific + 488",
@"25  GraphicsServices                    0x0000000110d6fad2 GSEventRunModal + 161",
@"26  UIKit                               0x000000010d49a610 UIApplicationMain + 171",
@"27  Foo                                 0x000000010cb4486f main + 111",
@"28  libdyld.dylib                       0x000000010fcee92d start + 1",
    ];

    NSArray *parsedCallStack = MKTParseCallStack(callStack);

    NSArray *filteredCallStack = MKTFilterCallStack(parsedCallStack);

    assertThat(filteredCallStack, containsIn(@[
            hasProperty(@"instruction", @"-[Foo callDoneWithOnce] + 111"),
            hasProperty(@"instruction", @"-[Foo doIt] + 43"),
    ]));
}

- (void)testFilter_NotBlowUpIfXCTestIsNotInCallStack
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
@"9   ABCTest                             0x000000010dfc4c0b -[ABCTestCase performTest:] + 443",
@"10  ABCTest                             0x000000010dfafa28 -[ABCTestDriver _runSuite] + 408",
@"11  libdyld.dylib                       0x0000000110e3192d start + 1",
    ];
    NSArray *parsedCallStack = MKTParseCallStack(callStack);

    NSArray *filteredCallStack = MKTFilterCallStack(parsedCallStack);
    
    assertThat(filteredCallStack, containsIn(@[
            hasProperty(@"instruction", @"-[ExampleTests testVerifyWithMatcherForPrimitive] + 92"),
    ]));
}

@end
