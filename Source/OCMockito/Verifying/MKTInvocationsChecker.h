//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

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
