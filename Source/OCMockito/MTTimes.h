//
//  OCMockito - MTTimes.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>


@interface MTTimes : NSObject

+ (id)timesWithCount:(NSUInteger)wantedNumberOfInvocations;
- (id)initWithCount:(NSUInteger)wantedNumberOfInvocations;

@end
