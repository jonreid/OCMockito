//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

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
