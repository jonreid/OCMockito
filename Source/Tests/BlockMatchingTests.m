//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface ObjectWithBlockArg : NSObject
@end

@implementation ObjectWithBlockArg

- (NSString *)doBlock:(NSString *(^)(void))block
{
    if (block)
        return block();
    return nil;
}

@end


@interface BlockMatchingTests : SenTestCase
@end

@implementation BlockMatchingTests
{
    ObjectWithBlockArg *obj;
}

- (void)setUp
{
    [super setUp];
    obj = mock([ObjectWithBlockArg class]);
}

- (void)testMethodWithBlockArg_WithNilValueMatcher_ShouldMatchNil
{
    [given([obj doBlock:(id)nilValue()]) willReturn:@"match nil"];
    [given([obj doBlock:(id)notNilValue()]) willReturn:@"match not nil"];

    assertThat([obj doBlock:nil], is(@"match nil"));
}

- (void)testMethodWithBlockArg_WithNotNilValueMatcher_ShouldMatchBlock
{
    [given([obj doBlock:(id)nilValue()]) willReturn:@"match nil"];
    [given([obj doBlock:(id)notNilValue()]) willReturn:@"match not nil"];

    NSString *(^anyBlock)() = ^NSString *{ return nil; };

    assertThat([obj doBlock:anyBlock], is(@"match not nil"));
}

@end
