//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class MKTInvocation;
@class MKTInvocationMatcher;


NS_ASSUME_NONNULL_BEGIN

@interface MKTPrinter : NSObject

- (NSString *)printMatcher:(MKTInvocationMatcher *)matcher;
- (NSString *)printInvocation:(MKTInvocation *)invocation;
- (NSString *)printMismatchOf:(MKTInvocation *)invocation
                  expectation:(MKTInvocationMatcher *)expectation;

@end


FOUNDATION_EXPORT NSString *MKTOrdinal(NSUInteger index);

NS_ASSUME_NONNULL_END
