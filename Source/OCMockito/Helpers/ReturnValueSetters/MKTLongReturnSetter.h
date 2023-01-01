// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2023 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTReturnValueSetter.h"


NS_ASSUME_NONNULL_BEGIN

@interface MKTLongReturnSetter : MKTReturnValueSetter

- (instancetype)initWithSuccessor:(nullable MKTReturnValueSetter *)successor NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithType:(char const *)handlerType successor:(nullable MKTReturnValueSetter *)successor NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
