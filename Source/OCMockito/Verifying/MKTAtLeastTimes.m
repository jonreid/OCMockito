//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Markus Gasser

#import "MKTAtLeastTimes.h"

#import "MKTAtLeastNumberOfInvocationsChecker.h"
#import "MKTInvocationContainer.h"
#import "MKTVerificationData.h"


@interface MKTAtLeastTimes ()
@property (nonatomic, assign, readonly) NSUInteger wantedCount;
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

- (void)verifyData:(MKTVerificationData *)data testLocation:(MKTTestLocation)testLocation
{
    MKTAtLeastNumberOfInvocationsChecker *checker = [[MKTAtLeastNumberOfInvocationsChecker alloc] init];
    NSString *failureDescription = [checker checkInvocations:data.invocations.registeredInvocations
                                                      wanted:data.wanted
                                                 wantedCount:self.wantedCount];
    if (failureDescription)
        MKTFailTestLocation(testLocation, failureDescription);
}

@end
