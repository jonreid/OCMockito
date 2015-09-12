//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Emile Cantin

#import "MKTAtMostTimes.h"
#import "MKTVerificationData.h"


@interface MKTAtMostTimes ()
@property (nonatomic, assign, readonly) NSUInteger wantedCount;
@end

@implementation MKTAtMostTimes

- (instancetype)initWithMaximumCount:(NSUInteger)maxNumberOfInvocations
{
    self = [super init];
    if (self)
        _wantedCount = maxNumberOfInvocations;
    return self;
}


#pragma mark MKTVerificationMode

- (void)verifyData:(MKTVerificationData *)data
{
    if (self.wantedCount == 0)
        return;     // this always succeeds
    
    NSUInteger matchingCount = [data numberOfMatchingInvocations];
    if (matchingCount > self.wantedCount)
    {
        NSString *plural = (self.wantedCount == 1) ? @"" : @"s";
        NSString *description = [NSString stringWithFormat:@"Expected less than %u matching invocation%@, but received %u",
                                 (unsigned)self.wantedCount, plural, (unsigned)matchingCount];
        MKTFailTestLocation(data.testLocation, description);
    }
}

@end
