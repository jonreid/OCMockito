//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import "MKTArgumentGetter.h"


NS_ASSUME_NONNULL_BEGIN

@interface MKTIntArgumentGetter : MKTArgumentGetter

- (instancetype)initWithSuccessor:(nullable MKTArgumentGetter *)successor NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithType:(char const *)handlerType successor:(nullable MKTArgumentGetter *)successor NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
