//
//  OCMockito - BlockMatchingTests.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


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
