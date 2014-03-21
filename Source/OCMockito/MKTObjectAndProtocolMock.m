//
//  OCMockito - MKTObjectAndProtocolMock.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//  
//  Created by: Kevin Lundberg
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTObjectAndProtocolMock.h"

#import <objc/runtime.h>


@implementation MKTObjectAndProtocolMock
{
    Class _mockedClass;
}

+ (instancetype)mockForClass:(Class)aClass protocol:(Protocol *)aProtocol
{
    return [[self alloc] initWithClass:aClass protocol:aProtocol];
}

- (instancetype)initWithClass:(Class)aClass protocol:(Protocol *)aProtocol
{
    self = [super initWithProtocol:aProtocol];
    if (self)
        _mockedClass = aClass;
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"mock object of %@ implementing %@ protocol",
            NSStringFromClass(_mockedClass), NSStringFromProtocol(_mockedProtocol)];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [_mockedClass instanceMethodSignatureForSelector:aSelector];
    
    if (signature)
        return signature;
    else
        return [super methodSignatureForSelector:aSelector];
}


#pragma mark NSObject protocol

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [_mockedClass instancesRespondToSelector:aSelector] ||
           [super respondsToSelector:aSelector];
}

@end
