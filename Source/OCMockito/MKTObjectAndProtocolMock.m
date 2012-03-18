//
//  MKTClassAndProtocolMock.m
//  OCMockito
//
//  Created by Kevin Lundberg on 3/14/12.
//  Copyright (c) 2012 Kevin Lundberg. All rights reserved.
//

#import "MKTClassAndProtocolMock.h"

#import <objc/runtime.h>

@interface MKTClassAndProtocolMock ()
{
    Class mockedClass;
}

@end

@implementation MKTClassAndProtocolMock

+ (id)mockForClass:(Class)cls protocol:(Protocol *)protocol
{
    return [[[self alloc] initWithClass:cls protocol:protocol] autorelease];
}

- (id)initWithClass:(Class)cls protocol:(Protocol *)protocol
{
    self = [super initWithProtocol:protocol];
    if (self) {
        mockedClass = cls;
    }
    return self;
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [mockedClass instanceMethodSignatureForSelector:aSelector];
    
    if (signature) {
        return signature;
    } else {
        return [super methodSignatureForSelector:aSelector];
    }
}

#pragma mark NSObject protocol

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [mockedClass instancesRespondToSelector:aSelector] || [super respondsToSelector:aSelector];
}

@end
