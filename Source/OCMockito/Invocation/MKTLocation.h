// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2023 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface MKTLocation : NSObject

- (instancetype)init;
- (instancetype)initWithCallStack:(NSArray<NSString *> *)callStack NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
