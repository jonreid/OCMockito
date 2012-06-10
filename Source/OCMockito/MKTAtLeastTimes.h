//
//  OCMockito - MKTAtLeastTimes.h
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//  
//  Created by Markus Gasser on 18.04.12.
//

#import <Foundation/Foundation.h>
#import "MKTVerificationMode.h"


@interface MKTAtLeastTimes : NSObject <MKTVerificationMode>

+ (id)timesWithMinimumCount:(NSUInteger)minimumExpectedNumberOfInvocations;
- (id)initWithMinimumCount:(NSUInteger)minimumExpectedNumberOfInvocations;

@end
