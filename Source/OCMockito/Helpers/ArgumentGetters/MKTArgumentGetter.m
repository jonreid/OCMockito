// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2023 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTArgumentGetter.h"


@interface MKTArgumentGetter (SubclassResponsibility)
- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation;
@end

@interface MKTArgumentGetter ()
@property (nonatomic, assign, readonly) char const *handlerType;
@property (nullable, nonatomic, strong, readonly) MKTArgumentGetter *successor;
@end

@implementation MKTArgumentGetter

- (instancetype)initWithType:(char const *)handlerType successor:(nullable MKTArgumentGetter *)successor
{
    self = [super init];
    if (self)
    {
        _handlerType = handlerType;
        _successor = successor;
    }
    return self;
}

- (BOOL)handlesArgumentType:(char const *)argType
{
    return argType[0] == self.handlerType[0];
}

- (nullable id)retrieveArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    if ([self handlesArgumentType:type])
        return [self getArgumentAtIndex:idx ofType:type onInvocation:invocation];

    return [self.successor retrieveArgumentAtIndex:idx ofType:type onInvocation:invocation];
}

@end
