//  OCMockito by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

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

- (id)answerInvocation:(NSInvocation *)invocation
{
    return self.block(invocation);
}

@end
