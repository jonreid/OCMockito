//
//  OCMockito - MKTAtLeastTimes.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by Markus Gasser on 18.04.12.
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTAtLeastTimes.h"

#import "MKTVerificationData.h"


@interface MKTAtLeastTimes ()
@property (nonatomic, readonly) NSUInteger wantedCount;
@end

@implementation MKTAtLeastTimes

- (instancetype)initWithMinimumCount:(NSUInteger)minNumberOfInvocations
{
    self = [super init];
    if (self)
        _wantedCount = minNumberOfInvocations;
    return self;
}


#pragma mark MKTVerificationMode

- (void)verifyData:(MKTVerificationData *)data
{
    if (self.wantedCount == 0)
        return;     // this always succeeds

    NSUInteger matchingCount = [data numberOfMatchingInvocations];
    if (matchingCount < self.wantedCount)
    {
        NSString *plural = (self.wantedCount == 1) ? @"" : @"s";
        NSString *description = [NSString stringWithFormat:@"Expected %u matching invocation%@, but received %u",
                                                           (unsigned)self.wantedCount, plural, (unsigned)matchingCount];
        MKTFailTestLocation(data.testLocation, description);
    }
}

@end
