//
//  OCMockito - MTInvocationContainer.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>


@interface MTInvocationContainer : NSObject

@property(nonatomic, retain) NSMutableArray *registeredInvocations;

- (void)registerInvocation:(NSInvocation *)invocation;

@end
