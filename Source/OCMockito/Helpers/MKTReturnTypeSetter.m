//
//  OCMockito - MKTReturnTypeSetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTReturnTypeSetter.h"


@interface MKTReturnTypeSetter (SubclassResponsibility)
- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation;
@end


@implementation MKTReturnTypeSetter
{
    char const *_handlerType;
}

- (instancetype)initWithType:(char const *)handlerType
{
    self = [super init];
    if (self)
        _handlerType = handlerType;
    return self;
}

- (BOOL)handlesReturnType:(char const *)returnType
{
    return strcmp(returnType, _handlerType) == 0;
}

- (void)setReturnValue:(id)returnValue ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    if ([self handlesReturnType:type])
        [self setReturnValue:returnValue onInvocation:invocation];
    else
        [self.successor setReturnValue:returnValue ofType:type onInvocation:invocation];
}

@end
