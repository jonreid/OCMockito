//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTExactTimes.h"

#import "MKTVerificationData.h"


@interface MKTExactTimes ()
@property (nonatomic, assign, readonly) NSUInteger wantedCount;
@end

@implementation MKTExactTimes

- (instancetype)initWithCount:(NSUInteger)wantedNumberOfInvocations
{
    self = [super init];
    if (self)
        _wantedCount = wantedNumberOfInvocations;
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
    if (matchingCount == self.wantedCount)
        return nil;

    NSString *plural = (self.wantedCount == 1) ? @"" : @"s";
    return [NSString stringWithFormat:@"Expected %u matching invocation%@, but received %u",
                                      (unsigned)self.wantedCount, plural, (unsigned)matchingCount];
}

@end
