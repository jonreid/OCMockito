//
// Created by Jon Reid on 11/27/15.
// Copyright (c) 2015 Jonathan M. Reid. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKTInvocationsFinder;


@interface MKTInvocationsChecker : NSObject

@property (nonatomic, copy, readonly) NSString *wantedDescription;
@property (nonatomic, strong) MKTInvocationsFinder *invocationsFinder;

- (instancetype)initWithWantedDescription:(NSString *)wantedDescription;
- (NSString *)tooLittleActual:(NSUInteger)actualCount wantedCount:(NSUInteger)wantedCount;
- (NSString *)describeWanted:(NSUInteger)wantedCount butWasCalled:(NSUInteger)actualCount;
- (NSString *)pluralizeTimes:(NSUInteger)count;
- (NSString *)joinProblem:(NSString *)problem callStack:(NSArray *)callStack label:(NSString *)label;

@end
