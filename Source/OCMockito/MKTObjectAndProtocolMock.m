//
//  OCMockito - MKTObjectAndProtocolMock.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//  
//  Created by: Kevin Lundberg
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTObjectAndProtocolMock.h"

#import <objc/runtime.h>


@implementation MKTObjectAndProtocolMock
{
    Class mockedClass;
}

+ (id)mockForClass:(Class)aClass protocol:(Protocol *)protocol
{
    return [[[self alloc] initWithClass:aClass protocol:protocol] autorelease];
}

- (id)initWithClass:(Class)aClass protocol:(Protocol *)protocol
{
    self = [super initWithProtocol:protocol];
    if (self)
        mockedClass = aClass;
    return self;
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [mockedClass instanceMethodSignatureForSelector:aSelector];
    
    if (signature)
        return signature;
    else
        return [super methodSignatureForSelector:aSelector];
}

#pragma mark NSObject protocol

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [mockedClass instancesRespondToSelector:aSelector] ||
           [super respondsToSelector:aSelector];
}

@end
