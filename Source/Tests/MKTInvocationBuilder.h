//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class MKTInvocation;
@class MKTInvocationMatcher;


@interface MKTInvocationBuilder : NSObject

+ (instancetype)invocationBuilder;
- (MKTInvocationBuilder *)simpleMethod;
- (MKTInvocationBuilder *)differentMethod;
- (NSInvocation *)buildNSInvocation;
- (MKTInvocation *)buildMKTInvocation;
- (MKTInvocationMatcher *)buildInvocationMatcher;

@end
