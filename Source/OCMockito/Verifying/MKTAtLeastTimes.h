//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Markus Gasser

#import <Foundation/Foundation.h>
#import "MKTVerificationMode.h"


@interface MKTAtLeastTimes : NSObject <MKTVerificationMode>

- (instancetype)initWithMinimumCount:(NSUInteger)minNumberOfInvocations;

@end
