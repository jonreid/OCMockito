//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationsChecker.h"

@class MKTInvocation;
@class MKTInvocationMatcher;


@interface MKTAtLeastNumberOfInvocationsChecker : MKTInvocationsChecker

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithWantedDescription:(NSString *)wantedDescription NS_UNAVAILABLE;
- (NSString *)checkInvocations:(NSArray<MKTInvocation *> *)invocations
                        wanted:(MKTInvocationMatcher *)wanted
                   wantedCount:(NSUInteger)wantedCount;

@end
