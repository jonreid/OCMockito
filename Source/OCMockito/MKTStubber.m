//
//  OCMockito - MKTStubber.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTStubber.h"

#import "MKTBaseMockObject.h"


@implementation MKTStubber
{
    NSMutableArray *_answers;
}

- (id)init
{
    self = [super init];
    if (self)
        _answers = [[NSMutableArray alloc] init];
    return self;
}

- (id)when:(MKTBaseMockObject *)mock
{
    [mock setAnswersForStubbing:[_answers copy]];
    return mock;
}

- (void)doNothing
{
    [_answers addObject:[NSNull null]];
}

@end
