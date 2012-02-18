//
//  OCMockito - MKTExactTimes.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MKTVerificationMode.h"


@interface MKTExactTimes : NSObject <MKTVerificationMode>

+ (id)timesWithCount:(NSUInteger)expectedNumberOfInvocations;
- (id)initWithCount:(NSUInteger)expectedNumberOfInvocations;

@end
