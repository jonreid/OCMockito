//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>
#import "MKTInvocation.h"
#import "MKTInvocationMatcher.h"


@interface MKTInvocationBuilder : NSObject

@property (nonatomic, assign) void *firstArgument;

+ (instancetype)invocationBuilder;
- (void)setSelector:(SEL)selector;
- (MKTInvocationBuilder *)simpleMethod;
- (MKTInvocationBuilder *)differentMethod;
- (NSInvocation *)buildNSInvocation;
- (MKTInvocation *)buildMKTInvocation;
- (MKTInvocationMatcher *)buildInvocationMatcher;

@end


@interface MKTInvocation (MKTInvocationBuilder)
+ (instancetype)invocationFromBuilder:(void (^)(MKTInvocationBuilder *))configure;
@end

@interface MKTInvocationMatcher (MKTInvocationBuilder)
+ (instancetype)matcherFromBuilder:(void (^)(MKTInvocationBuilder *))configure;
@end


@interface MKTMethods : NSObject
- (void)methodWithArg:(id)arg;
@end
