//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class MKTInvocation;
@class MKTInvocationMatcher;


@interface DummyObject : NSObject

+ (NSInvocation *)invocationWithNoArgs;
+ (NSInvocation *)differentInvocationWithNoArgs;
+ (NSInvocation *)invocationWithObjectArg:(__unsafe_unretained id)argument;
+ (NSInvocation *)invocationWithBoolArg:(BOOL)argument;
+ (NSInvocation *)invocationWithCharArg:(char)argument;
+ (NSInvocation *)invocationWithIntArg:(int)argument;
+ (NSInvocation *)invocationWithShortArg:(short)argument;
+ (NSInvocation *)invocationWithLongArg:(long)argument;
+ (NSInvocation *)invocationWithLongLongArg:(long long)argument;
+ (NSInvocation *)invocationWithIntegerArg:(NSInteger)argument;
+ (NSInvocation *)invocationWithUnsignedCharArg:(unsigned char)argument;
+ (NSInvocation *)invocationWithUnsignedIntArg:(unsigned int)argument;
+ (NSInvocation *)invocationWithUnsignedShortArg:(unsigned short)argument;
+ (NSInvocation *)invocationWithUnsignedLongArg:(unsigned long)argument;
+ (NSInvocation *)invocationWithUnsignedLongLongArg:(unsigned long long)argument;
+ (NSInvocation *)invocationWithUnsignedIntegerArg:(NSUInteger)argument;
+ (NSInvocation *)invocationWithFloatArg:(float)argument;
+ (NSInvocation *)invocationWithDoubleArg:(double)argument;
+ (NSInvocation *)invocationWithObjectArg:(__unsafe_unretained id)argument1 intArg:(int)argument2;
+ (NSInvocation *)invocationWithIntArg:(int)argument1 floatArg:(float)argument2;

@end


MKTInvocation *wrappedInvocation(NSInvocation *invocation);
MKTInvocationMatcher *matcherForInvocation(NSInvocation *invocation);
