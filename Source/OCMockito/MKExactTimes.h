//
//  OCMockito - MKExactTimes.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MKVerificationMode.h"


@interface MKExactTimes : NSObject <MKVerificationMode>

+ (id)timesWithCount:(NSUInteger)expectedNumberOfInvocations;
- (id)initWithCount:(NSUInteger)expectedNumberOfInvocations;

@end
