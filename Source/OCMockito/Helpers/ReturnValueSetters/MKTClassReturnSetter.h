//  OCMockito by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

#import "MKTReturnValueSetter.h"


NS_ASSUME_NONNULL_BEGIN

@interface MKTClassReturnSetter : MKTReturnValueSetter

- (instancetype)initWithSuccessor:(nullable MKTReturnValueSetter *)successor NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithType:(char const *)handlerType successor:(nullable MKTReturnValueSetter *)successor NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
