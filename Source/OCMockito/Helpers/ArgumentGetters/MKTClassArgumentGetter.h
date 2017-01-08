//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "MKTArgumentGetter.h"


NS_ASSUME_NONNULL_BEGIN

@interface MKTClassArgumentGetter : MKTArgumentGetter

- (instancetype)initWithSuccessor:(nullable MKTArgumentGetter *)successor NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithType:(char const *)handlerType successor:(nullable MKTArgumentGetter *)successor NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
