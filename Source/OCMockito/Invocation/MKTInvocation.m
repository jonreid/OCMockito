//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocation.h"


@implementation MKTInvocation

- (instancetype)initWithInvocation:(NSInvocation *)invocation
{
    self = [super init];
    if (self) {
        _invocation = invocation;
    }
    return self;
}

@end
