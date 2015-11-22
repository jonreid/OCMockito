//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


@interface MKTInvocation : NSObject

@property (nonatomic, strong, readonly) NSInvocation *invocation;

- (instancetype)initWithInvocation:(NSInvocation *)invocation;

@end
