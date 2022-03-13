// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

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
