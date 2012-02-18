//
//  OCMockito - MKTExactTimes.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MKVerificationMode.h"


@interface MKTExactTimes : NSObject <MKVerificationMode>

+ (id)timesWithCount:(NSUInteger)expectedNumberOfInvocations;
- (id)initWithCount:(NSUInteger)expectedNumberOfInvocations;

@end
