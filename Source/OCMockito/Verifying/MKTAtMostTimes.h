//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Emile Cantin

#import <Foundation/Foundation.h>
#import "MKTVerificationMode.h"


NS_ASSUME_NONNULL_BEGIN

@interface MKTAtMostTimes : NSObject <MKTVerificationMode>

- (instancetype)initWithMaximumCount:(NSUInteger)maxNumberOfInvocations NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
