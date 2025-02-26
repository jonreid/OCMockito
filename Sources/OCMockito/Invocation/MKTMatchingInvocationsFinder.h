// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <Foundation/Foundation.h>

@class MKTInvocation;
@class MKTInvocationMatcher;
@class MKTLocation;


NS_ASSUME_NONNULL_BEGIN

@interface MKTMatchingInvocationsFinder : NSObject

@property (nonatomic, assign, readonly) NSUInteger count;

- (void)findInvocationsInList:(NSArray<MKTInvocation *> *)invocations matching:(MKTInvocationMatcher *)wanted;
- (MKTLocation *)locationOfInvocationAtIndex:(NSUInteger)index;
- (MKTLocation *)locationOfLastInvocation;
- (void)markInvocationsAsVerified;

@end

NS_ASSUME_NONNULL_END
