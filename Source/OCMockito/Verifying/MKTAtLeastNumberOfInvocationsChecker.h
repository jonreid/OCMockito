//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class MKTInvocationsFinder;
@class MKTInvocationMatcher;


@interface MKTAtLeastNumberOfInvocationsChecker : NSObject

@property (nonatomic, strong) MKTInvocationsFinder *invocationsFinder;

- (NSString *)checkInvocations:(NSArray *)invocations
                        wanted:(MKTInvocationMatcher *)wanted
                   wantedCount:(NSUInteger)wantedCount;

@end
