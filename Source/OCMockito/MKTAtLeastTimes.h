//
//  MKTAtLeastTimes.h
//  OCMockito
//
//  Created by Markus Gasser on 18.04.12.
//  Copyright (c) 2012 Jonathan M. Reid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKTVerificationMode.h"


@interface MKTAtLeastTimes : NSObject <MKTVerificationMode>

+ (id)timesWithMinimumCount:(NSUInteger)minimumExpectedNumberOfInvocations;
- (id)initWithMinimumCount:(NSUInteger)minimumExpectedNumberOfInvocations;

@end
