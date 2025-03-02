// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTReturnValueSetter.h"


@interface MKTReturnValueSetter (SubclassResponsibility)
- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation;
@end

@interface MKTReturnValueSetter ()
@property (nonatomic, assign, readonly) char const *handlerType;
@property (nullable, nonatomic, strong, readonly) MKTReturnValueSetter *successor;
@end


@implementation MKTReturnValueSetter

- (instancetype)initWithType:(char const *)handlerType successor:(nullable MKTReturnValueSetter *)successor
{
    self = [super init];
    if (self)
    {
        _handlerType = handlerType;
        _successor = successor;
    }
    return self;
}

- (BOOL)handlesReturnType:(char const *)returnType
{
    return returnType[0] == self.handlerType[0];
}

- (void)setReturnValue:(nullable id)returnValue ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    if ([self handlesReturnType:type])
        [self setReturnValue:returnValue onInvocation:invocation];
    else
        [self.successor setReturnValue:returnValue ofType:type onInvocation:invocation];
}

@end
