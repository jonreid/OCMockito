//
//  TPWeakProxy.m
//  TPWeakProxy
//
//  Copyright (c) 2013 Tetherpad, Inc. All rights reserved.
//

#import "MKT_TPWeakProxy.h"

@interface MKT_TPWeakProxy ()

@property (weak, nonatomic) id theObject;

@end

@implementation MKT_TPWeakProxy

- (id)initWithObject:(id)object {
    // No init method in superclass
    self.theObject = object;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.theObject];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [self.theObject methodSignatureForSelector:aSelector];
}

@end
