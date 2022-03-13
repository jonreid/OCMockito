// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTThrowsException.h"


@interface MKTThrowsException ()
@property (nonatomic, strong, readonly) NSException *exception;
@end

@implementation MKTThrowsException

- (instancetype)initWithException:(NSException *)exception
{
    self = [super init];
    if (self)
        _exception = exception;
    return self;
}

- (nullable id)answerInvocation:(NSInvocation *)invocation
{
    [self.exception raise];
    return nil;
}

@end
