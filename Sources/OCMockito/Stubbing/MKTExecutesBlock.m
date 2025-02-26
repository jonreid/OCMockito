// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTExecutesBlock.h"


@interface MKTExecutesBlock ()
@property (nonatomic, copy, readonly) id (^block)(NSInvocation *);
@end

@implementation MKTExecutesBlock

- (instancetype)initWithBlock:(id (^)(NSInvocation *))block
{
    self = [super init];
    if (self)
        _block = [block copy];
    return self;
}

- (nullable id)answerInvocation:(NSInvocation *)invocation
{
    return self.block(invocation);
}

@end
