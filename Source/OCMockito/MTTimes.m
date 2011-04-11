//
//  OCMockito - MTTimes.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTTimes.h"

@interface MTTimes ()
@property(nonatomic, assign) NSUInteger wantedCount;
@end


@implementation MTTimes

@synthesize wantedCount;

+ (id)timesWithCount:(NSUInteger)wantedNumberOfInvocations
{
    return [[[self alloc] initWithCount:wantedNumberOfInvocations] autorelease];
}


- (id)initWithCount:(NSUInteger)wantedNumberOfInvocations
{
    self = [super init];
    if (self)
        wantedCount = wantedNumberOfInvocations;
    return self;
}

@end
