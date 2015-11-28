//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTExactTimes.h"

#import "MKTInvocationContainer.h"
#import "MKTNumberOfInvocationsChecker.h"
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
    MKTNumberOfInvocationsChecker *checker = [[MKTNumberOfInvocationsChecker alloc] init];
    NSString *failureDescription = [checker checkInvocations:data.invocations.registeredInvocations
                                                      wanted:data.wanted
                                                 wantedCount:self.wantedCount];
    if (failureDescription)
        MKTFailTestLocation(testLocation, failureDescription);
}

@end
