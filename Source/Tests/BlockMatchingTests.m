//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


typedef NSString *(^BlockReturningString)(void);

@interface ObjectWithBlockArg : NSObject
@end

@implementation ObjectWithBlockArg

- (NSString *)doBlock:(BlockReturningString)block
{
    if (block)
        return block();
    return nil;
}

@end


@interface BlockMatchingTests : XCTestCase
@end

@implementation BlockMatchingTests
{
    ObjectWithBlockArg *mockObj;
}

- (void)setUp
{
    [super setUp];
    mockObj = mock([ObjectWithBlockArg class]);
}

- (void)tearDown
{
    mockObj = nil;
    [super tearDown];
}

- (void)testMockingMethodWithBlockArg_WithNilValueMatcher_ShouldMatchNil
{
    [given([mockObj doBlock:(id)nilValue()]) willReturn:@"match nil"];
    [given([mockObj doBlock:(id)notNilValue()]) willReturn:@"match not nil"];

    assertThat([mockObj doBlock:nil], is(@"match nil"));
}

- (void)testMockingMethodWithBlockArg_WithNotNilValueMatcher_ShouldMatchBlock
{
    [given([mockObj doBlock:(id)nilValue()]) willReturn:@"match nil"];
    [given([mockObj doBlock:(id)notNilValue()]) willReturn:@"match not nil"];

    BlockReturningString anyBlock = ^NSString *{ return @"DUMMY"; };

    assertThat([mockObj doBlock:anyBlock], is(@"match not nil"));
}

- (void)testMockingMethodWithBlockArg_WithArgumentCaptor_ShouldLetYouExecuteCapturedBlock
{
    HCArgumentCaptor *argument = [[HCArgumentCaptor alloc] init];
    
    [mockObj doBlock:^NSString * {
        return @"SUCCESS";
    }];
    [verify(mockObj) doBlock:(id)argument];

    BlockReturningString block = argument.value;
    assertThat(block(), is(@"SUCCESS"));
}

@end
