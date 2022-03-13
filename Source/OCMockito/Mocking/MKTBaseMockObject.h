// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <Foundation/Foundation.h>
#import <OCMockito/MKTNonObjectArgumentMatching.h>


NS_ASSUME_NONNULL_BEGIN

@interface MKTBaseMockObject : NSProxy <MKTNonObjectArgumentMatching>

+ (BOOL)isMockObject:(nullable id)object;

- (instancetype)init;
- (void)stopMocking;

@end

NS_ASSUME_NONNULL_END
