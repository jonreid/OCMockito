//
//  OCMockito - MTTimes.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MTVerificationMode.h"


@interface MTTimes : NSObject <MTVerificationMode>

+ (id)timesWithCount:(NSUInteger)wantedNumberOfInvocations;
- (id)initWithCount:(NSUInteger)wantedNumberOfInvocations;

@end
