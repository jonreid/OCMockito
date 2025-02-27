// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTReturnsValue.h"


@interface MKTReturnsValue ()
@property (nullable, nonatomic, strong, readonly) id value;
@end

@implementation MKTReturnsValue

- (instancetype)initWithValue:(nullable id)value
{
    self = [super init];
    if (self)
        _value = value;
    return self;
}

- (nullable id)answerInvocation:(NSInvocation *)invocation
{
    return self.value;
}

@end
