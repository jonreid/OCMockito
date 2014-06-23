//
//  OCMockito - MKTArgumentCaptor.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTArgumentCaptor.h"

#import "MKTCapturingMatcher.h"


@interface MKTArgumentCaptor ()
@property (nonatomic, readonly) MKTCapturingMatcher *matcher;
@end

@implementation MKTArgumentCaptor

- (instancetype)init
{
    self = [super init];
    if (self)
        _matcher = [[MKTCapturingMatcher alloc] init];
    return self;
}

- (id)capture
{
    return self.matcher;
}

- (id)value
{
    return [self.matcher lastValue];
}

- (NSArray *)allValues
{
    return [self.matcher allValues];
}

@end
