// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <Foundation/Foundation.h>
#import "MKTVerificationMode.h"


NS_ASSUME_NONNULL_BEGIN

@interface MKTExactTimes : NSObject <MKTVerificationMode>

- (instancetype)initWithCount:(NSUInteger)wantedNumberOfInvocations NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
