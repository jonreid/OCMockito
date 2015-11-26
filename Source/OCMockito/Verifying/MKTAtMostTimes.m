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

- (void)verifyData:(MKTVerificationData *)data testLocation:(MKTTestLocation)testLocation
{
    NSString *failureDescription = [self check:data];
    if (failureDescription)
        MKTFailTestLocation(testLocation, failureDescription);
}

- (NSString *)check:(MKTVerificationData *)data
{
    NSUInteger matchingCount = [data numberOfMatchingInvocations];
    if (matchingCount <= self.wantedCount)
        return nil;

    NSString *plural = (self.wantedCount == 1) ? @"" : @"s";
    return [NSString stringWithFormat:@"Expected less than %u matching invocation%@, but received %u",
                                      (unsigned)self.wantedCount, plural, (unsigned)matchingCount];
}

@end
