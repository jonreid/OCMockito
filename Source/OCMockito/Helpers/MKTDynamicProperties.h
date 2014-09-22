//
//  OCMockito - MKTDynamicProperties.h
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import <Foundation/Foundation.h>


@interface MKTDynamicProperties : NSObject

- (instancetype)initWithClass:(Class)aClass;
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;

@end
