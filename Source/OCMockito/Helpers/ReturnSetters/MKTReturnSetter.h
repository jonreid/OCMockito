//
//  OCMockito - MKTReturnSetter.h
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import <Foundation/Foundation.h>


@interface MKTReturnSetter : NSObject

@property (nonatomic, strong) MKTReturnSetter *successor;

- (instancetype)initWithType:(char const *)handlerType;
- (void)setReturnValue:(id)returnValue ofType:(char const *)type onInvocation:(NSInvocation *)invocation;

@end
