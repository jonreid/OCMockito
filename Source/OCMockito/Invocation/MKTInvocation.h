//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class MKTLocation;


NS_ASSUME_NONNULL_BEGIN

@interface MKTInvocation : NSObject

@property (nonatomic, strong, readonly) NSInvocation *invocation;
@property (nonatomic, strong, readonly) MKTLocation *location;
@property (nonatomic, assign) BOOL verified;

- (instancetype)initWithInvocation:(NSInvocation *)invocation;
- (instancetype)initWithInvocation:(NSInvocation *)invocation location:(MKTLocation *)location NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
