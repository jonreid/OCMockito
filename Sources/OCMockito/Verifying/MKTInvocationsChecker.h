// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

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
