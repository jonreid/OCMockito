//
//  OCMockito - MKTAtLeastTimes.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by Markus Gasser on 18.04.12.
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTAtLeastTimes.h"

#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTVerificationData.h"


@interface MKTAtLeastTimes ()
@property (nonatomic, readonly) NSUInteger minimumExpectedCount;
@end

@implementation MKTAtLeastTimes

- (instancetype)initWithMinimumCount:(NSUInteger)minimumExpectedNumberOfInvocations
{
    self = [super init];
    if (self)
        _minimumExpectedCount = minimumExpectedNumberOfInvocations;
    return self;
}


#pragma mark MKTVerificationMode

- (void)verifyData:(MKTVerificationData *)data
{
    if (self.minimumExpectedCount == 0)
        return;     // this always succeeds

    NSUInteger matchingCount = [data numberOfMatchingInvocations];
    if (matchingCount < self.minimumExpectedCount)
    {
        NSString *plural = (self.minimumExpectedCount == 1) ? @"" : @"s";
        NSString *description = [NSString stringWithFormat:@"Expected %u matching invocation%@, but received %u",
                                            (unsigned)self.minimumExpectedCount, plural, (unsigned)matchingCount];
        MKTFailTestLocation(data.testLocation, description);
    }
}

@end
