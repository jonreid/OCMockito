//  OCMockito by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocation.h"

#import "MKTLocation.h"


@implementation MKTInvocation

- (instancetype)initWithInvocation:(NSInvocation *)invocation
{
    return [self initWithInvocation:invocation
                           location:[[MKTLocation alloc] init]];
}

- (instancetype)initWithInvocation:(NSInvocation *)invocation location:(MKTLocation *)location
{
    self = [super init];
    if (self) {
        _invocation = invocation;
        _location = location;
    }
    return self;
}

@end
