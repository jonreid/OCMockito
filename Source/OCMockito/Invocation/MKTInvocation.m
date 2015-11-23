//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocation.h"


@interface MKTInvocation ()
@property (nonatomic, copy, readonly) NSArray *callStackSymbols;
@end

@implementation MKTInvocation

- (instancetype)initWithInvocation:(NSInvocation *)invocation
{
    self = [super init];
    if (self) {
        _invocation = invocation;
        _callStackSymbols = [NSThread callStackSymbols];
    }
    return self;
}

@end
