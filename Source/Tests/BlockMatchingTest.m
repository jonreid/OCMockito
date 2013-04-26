//
//  OCMockito - BlockMatchingTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
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


@interface BlockMatchingTest : SenTestCase
@end

@implementation BlockMatchingTest
{
    ObjectWithBlockArg *m;
}

- (void)setUp
{
    [super setUp];
    m = mock([ObjectWithBlockArg class]);
}

- (void)testMatchNilValue
{
    [given([m doBlock:(id)nilValue()]) willReturn:@"match nil"];
    [given([m doBlock:(id)notNilValue()]) willReturn:@"match not nil"];
    
    assertThat([m doBlock:nil], is(@"match nil"));
}

- (void)testMatchNotNilValue
{
    [given([m doBlock:(id)notNilValue()]) willReturn:@"match not nil"];
    [given([m doBlock:(id)nilValue()]) willReturn:@"match nil"];
    
    assertThat([m doBlock:^NSString *{ return nil; }], is(@"match not nil"));
}

@end
