//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationBuilder.h"

#import "MKTInvocation.h"


@interface MKTMethods : NSObject
@end

@implementation MKTMethods

- (NSString *)simpleMethod {}
- (NSString *)differentMethod {}

@end


@implementation MKTInvocationBuilder

+ (MKTInvocation *)simpleMethod
{
    return [self invocationWithSelector:@selector(simpleMethod)];
}

+ (MKTInvocation *)differentMethod
{
    return [self invocationWithSelector:@selector(differentMethod)];
}

+ (MKTInvocation *)invocationWithSelector:(SEL)selector
{
    NSMethodSignature *signature = [[MKTMethods class] instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
    return [[MKTInvocation alloc] initWithInvocation:invocation];
}

@end
