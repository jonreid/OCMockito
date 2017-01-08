//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "MKTPrinter.h"

#import "DummyObject.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTPrinterTests : XCTestCase
@end

@implementation MKTPrinterTests
{
    MKTPrinter *sut;
}

- (void)setUp
{
    [super setUp];
    sut = [[MKTPrinter alloc] init];
}

- (void)tearDown
{
    sut = nil;
    [super tearDown];
}

- (void)testPrintInvocation_WithNoArgs
{
    MKTInvocation *invocation = wrappedInvocation([DummyObject invocationWithNoArgs]);

    NSString *result = [sut printInvocation:invocation];
    
    assertThat(result, is(@"methodWithNoArgs"));
}

- (void)testPrintInvocation_WithOneArgument
{
    MKTInvocation *invocation = wrappedInvocation([DummyObject invocationWithObjectArg:@12.34]);

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithObjectArg:@12.34"));
}

- (void)testPrintInvocation_WithTwoArguments
{
    MKTInvocation *invocation = wrappedInvocation([DummyObject invocationWithObjectArg1:@12.34
                                                                             objectArg2:@56]);

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithObjectArg1:@12.34 objectArg2:@56"));
}

- (void)testPrintInvocation_WithString
{
    MKTInvocation *invocation = wrappedInvocation([DummyObject invocationWithObjectArg:@"FOO"]);

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithObjectArg:@\"FOO\""));
}

- (void)testPrintInvocation_WithNil
{
    MKTInvocation *invocation = wrappedInvocation([DummyObject invocationWithObjectArg:nil]);

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithObjectArg:nil"));
}

- (void)testPrintInvocation_WithInt
{
    MKTInvocation *invocation = wrappedInvocation([DummyObject invocationWithIntArg:123]);

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithIntArg:123"));
}

- (void)testPrintInvocation_WithBoolYes
{
    MKTInvocation *invocation = wrappedInvocation([DummyObject invocationWithBoolArg:YES]);

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithBoolArg:YES"));
}

- (void)testPrintInvocation_WithBoolNo
{
    MKTInvocation *invocation = wrappedInvocation([DummyObject invocationWithBoolArg:NO]);

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithBoolArg:NO"));
}

- (void)testPrintInvocation_WithSelector
{
    MKTInvocation *invocation =
            wrappedInvocation([DummyObject invocationWithSelectorArg:@selector(description)]);

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithSelectorArg:@selector(description)"));
}

- (void)testPrintInvocation_WithClass
{
    MKTInvocation *invocation =
            wrappedInvocation([DummyObject invocationWithClassArg:[DummyObject class]]);

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithClassArg:[DummyObject class]"));
}

- (void)testPrintInvocation_WithArray
{
    MKTInvocation *invocation = wrappedInvocation([DummyObject invocationWithObjectArg:@[
            @123,
            @"FOO"
    ]]);

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithObjectArg:@[ @123, @\"FOO\" ]"));
}

- (void)testPrintInvocation_WithDictionary
{
    MKTInvocation *invocation = wrappedInvocation([DummyObject invocationWithObjectArg:@{
            @"KEY1" : @"VALUE1",
            @"KEY2" : @"VALUE2"
    }]);

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithObjectArg:@{ @\"KEY1\" : @\"VALUE1\", @\"KEY2\" : @\"VALUE2\" }"));
}

- (void)testPrintMatcher_WithNoArgs
{
    MKTInvocationMatcher *matcher = matcherForInvocation([DummyObject invocationWithNoArgs]);

    NSString *result = [sut printMatcher:matcher];

    assertThat(result, is(@"methodWithNoArgs"));
}

- (void)testPrintMatcher_WithOneArgument
{
    MKTInvocationMatcher *matcher =
            matcherForInvocation([DummyObject invocationWithObjectArg:anything()]);

    NSString *result = [sut printMatcher:matcher];

    assertThat(result, is(@"methodWithObjectArg:ANYTHING"));
}

- (void)testPrintMatcher_WithTwoArguments
{
    MKTInvocationMatcher *matcher =
            matcherForInvocation([DummyObject invocationWithObjectArg1:anythingWithDescription(@"FOO")
                                                            objectArg2:anythingWithDescription(@"BAR")]);

    NSString *result = [sut printMatcher:matcher];

    assertThat(result, is(@"methodWithObjectArg1:FOO objectArg2:BAR"));
}

- (void)testOrdinal_With0_ShouldBe1st
{
    assertThat(MKTOrdinal(0), is(@"1st"));
}

- (void)testOrdinal_With1_ShouldBe2nd
{
    assertThat(MKTOrdinal(1), is(@"2nd"));
}

- (void)testOrdinal_With2_ShouldBe3rd
{
    assertThat(MKTOrdinal(2), is(@"3rd"));
}

- (void)testOrdinal_With3_ShouldBe4th
{
    assertThat(MKTOrdinal(3), is(@"4th"));
}

- (void)testOrdinal_With9_ShouldBe10th
{
    assertThat(MKTOrdinal(9), is(@"10th"));
}

- (void)testPrintMismatch_WithMismatchInFirstArgument
{
    MKTInvocationMatcher *matcher =
            matcherForInvocation([DummyObject invocationWithObjectArg1:equalTo(@"FOO")
                                                            objectArg2:equalTo(@"BAR")]);
    MKTInvocation *invocation =
            wrappedInvocation([DummyObject invocationWithObjectArg1:@"___"
                                                         objectArg2:@"BAR"]);

    NSString *result = [sut printMismatchOf:invocation expectation:matcher];

    assertThat(result, is(@"\nMismatch in 1st argument. Expected \"FOO\", but was \"___\""));
}

- (void)testPrintMismatch_WithMismatchInSecondArgument
{
    MKTInvocationMatcher *matcher =
            matcherForInvocation([DummyObject invocationWithObjectArg1:equalTo(@"FOO")
                                                            objectArg2:equalTo(@"BAR")]);
    MKTInvocation *invocation =
            wrappedInvocation([DummyObject invocationWithObjectArg1:@"FOO"
                                                         objectArg2:@"___"]);

    NSString *result = [sut printMismatchOf:invocation expectation:matcher];

    assertThat(result, is(@"\nMismatch in 2nd argument. Expected \"BAR\", but was \"___\""));
}

@end
