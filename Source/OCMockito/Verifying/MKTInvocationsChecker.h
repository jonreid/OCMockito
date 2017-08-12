//
// Created by Jon Reid on 11/27/15.
// Copyright (c) 2015 Jonathan M. Reid. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKTMatchingInvocationsFinder;


NS_ASSUME_NONNULL_BEGIN

@interface MKTInvocationsChecker : NSObject

@property (nonatomic, strong) MKTMatchingInvocationsFinder *invocationsFinder;

- (instancetype)initWithWantedDescription:(NSString *)wantedDescription NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (NSString *)tooLittleActual:(NSUInteger)actualCount wantedCount:(NSUInteger)wantedCount;
- (NSString *)tooManyActual:(NSUInteger)actualCount wantedCount:(NSUInteger)wantedCount;
- (NSString *)neverWantedButActual:(NSUInteger)actualCount;

@end

NS_ASSUME_NONNULL_END
