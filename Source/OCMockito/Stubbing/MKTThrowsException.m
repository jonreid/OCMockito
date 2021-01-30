//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

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
