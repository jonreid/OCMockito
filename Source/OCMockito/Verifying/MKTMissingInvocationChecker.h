//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationsChecker.h"

@class MKTInvocation;
@class MKTInvocationMatcher;


@interface MKTMissingInvocationChecker : MKTInvocationsChecker

@property (nonatomic, copy) MKTInvocation *(^findSimilarInvocation)(NSArray *, MKTInvocationMatcher *);
- (NSString *)checkInvocations:(NSArray *)invocations wanted:(MKTInvocationMatcher *)wanted;

@end
