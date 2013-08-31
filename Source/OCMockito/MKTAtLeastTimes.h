//
//  OCMockito - MKTAtLeastTimes.h
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//  
//  Created by Markus Gasser on 18.04.12.
//  Source: https://github.com/jonreid/OCMockito
//

#import <Foundation/Foundation.h>
#import "MKTVerificationMode.h"


@interface MKTAtLeastTimes : NSObject <MKTVerificationMode>

+ (id)timesWithMinimumCount:(NSUInteger)minimumExpectedNumberOfInvocations eventually:(BOOL)eventually;
- (id)initWithMinimumCount:(NSUInteger)minimumExpectedNumberOfInvocations eventually:(BOOL)eventually;

@end
