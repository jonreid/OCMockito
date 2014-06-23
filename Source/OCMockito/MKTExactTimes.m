//
//  OCMockito - MKTExactTimes.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTExactTimes.h"

#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTTestLocation.h"
#import "MKTVerificationData.h"


@interface MKTExactTimes ()
@property (nonatomic, readonly) NSUInteger expectedCount;
@end

@implementation MKTExactTimes

- (instancetype)initWithCount:(NSUInteger)expectedNumberOfInvocations
{
    self = [super init];
    if (self)
        _expectedCount = expectedNumberOfInvocations;
    return self;
}


#pragma mark MKTVerificationMode

- (void)verifyData:(MKTVerificationData *)data
{
    NSUInteger matchingCount = [data numberOfMatchingInvocations];
    if (matchingCount != self.expectedCount)
    {
        NSString *plural = (self.expectedCount == 1) ? @"" : @"s";
        NSString *description = [NSString stringWithFormat:@"Expected %u matching invocation%@, but received %u",
                                                           (unsigned)self.expectedCount, plural, (unsigned)matchingCount];
        MKTFailTestLocation(data.testLocation, description);
    }
}

@end
