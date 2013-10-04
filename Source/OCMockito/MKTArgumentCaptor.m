//
//  OCMockito - MKTArgumentCaptor.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by Markus Gasser on 18.04.12.
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTArgumentCaptor.h"

#import "MKTCapturingMatcher.h"


@implementation MKTArgumentCaptor
{
    MKTCapturingMatcher *_matcher;
}

- (id)init
{
    self = [super init];
    if (self)
        _matcher = [[MKTCapturingMatcher alloc] init];
    return self;
}

- (id)capture
{
    return _matcher;
}

- (id)value
{
    return [_matcher getLastValue];
}

@end
