//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Markus Gasser

#import <Foundation/Foundation.h>
#import "MKTVerificationMode.h"


NS_ASSUME_NONNULL_BEGIN

@interface MKTAtLeastTimes : NSObject <MKTVerificationMode>

- (instancetype)initWithMinimumCount:(NSUInteger)minNumberOfInvocations NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
