//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

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
    NSInvocation *invocation = [DummyObject invocationWithSelector:@selector(methodWithNoArgs)];

    NSString *result = [sut printInvocation:invocation];
    
    assertThat(result, is(@"methodWithNoArgs"));
}

- (void)testPrintInvocation_WithOneArgument
{
    NSInvocation *invocation = [DummyObject invocationWithObjectArg:@12.34];

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithObjectArg:@12.34"));
}

- (void)testPrintInvocation_WithTwoArguments
{
    NSInvocation *invocation = [DummyObject invocationWithObjectArg1:@12.34 objectArg2:@56];

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithObjectArg1:@12.34 objectArg2:@56"));
}

- (void)testPrintInvocation_WithNSString
{
    NSInvocation *invocation = [DummyObject invocationWithObjectArg:@"FOO"];

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithObjectArg:@\"FOO\""));
}

- (void)testPrintInvocation_WithNil
{
    NSInvocation *invocation = [DummyObject invocationWithObjectArg:nil];

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithObjectArg:nil"));
}

- (void)testPrintInvocation_WithInt
{
    NSInvocation *invocation = [DummyObject invocationWithIntArg:123];

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithIntArg:123"));
}

- (void)testPrintInvocation_WithBoolYes
{
    NSInvocation *invocation = [DummyObject invocationWithBoolArg:YES];

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithBoolArg:YES"));
}

- (void)testPrintInvocation_WithBoolNo
{
    NSInvocation *invocation = [DummyObject invocationWithBoolArg:NO];

    NSString *result = [sut printInvocation:invocation];

    assertThat(result, is(@"methodWithBoolArg:NO"));
}

@end
