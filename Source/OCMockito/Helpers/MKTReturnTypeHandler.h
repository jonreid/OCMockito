//
//  OCMockito - MKTReturnTypeHandler.h
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import <Foundation/Foundation.h>


@interface MKTReturnTypeHandler : NSObject

@property (nonatomic, strong) MKTReturnTypeHandler *successor;

- (instancetype)initWithType:(char const *)handlerType;
- (void)setReturnValue:(id)returnValue ofType:(char const *)type onInvocation:(NSInvocation *)invocation;

@end
