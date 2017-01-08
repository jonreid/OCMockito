//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "MKTReturnValueSetter.h"


NS_ASSUME_NONNULL_BEGIN

@interface MKTUnsignedShortReturnSetter : MKTReturnValueSetter

- (instancetype)initWithSuccessor:(nullable MKTReturnValueSetter *)successor NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithType:(char const *)handlerType successor:(nullable MKTReturnValueSetter *)successor NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
