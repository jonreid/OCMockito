//
//  OCMockito - MKTObjectAndProtocolMock.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//  
//  Created by: Kevin Lundberg
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTObjectAndProtocolMock.h"

#import <objc/runtime.h>


@implementation MKTObjectAndProtocolMock
{
    Protocol * _mockedProtocol;
    NSString* _description;
}

+ (instancetype)mockForClass:(Class)aClass protocol:(Protocol *)aProtocol
{
    return [[self alloc] initWithClass:aClass protocol:aProtocol];
}

- (instancetype)initWithClass:(Class)aClass protocol:(Protocol *)aProtocol
{
    self = [super initWithClass:aClass];
    if (self)
    {
        _mockedProtocol = aProtocol;
        _description = [NSString stringWithFormat:@"mock object of %@ implementing %@ protocol",
                                                  NSStringFromClass(aClass), NSStringFromProtocol(aProtocol)];
    }
    return self;
}

- (NSString *)description
{
    return _description;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    struct objc_method_description methodDescription = protocol_getMethodDescription(_mockedProtocol, aSelector, YES, YES);
    if (!methodDescription.name)
        methodDescription = protocol_getMethodDescription(_mockedProtocol, aSelector, NO, YES);

    if (methodDescription.name)
        return [NSMethodSignature signatureWithObjCTypes:methodDescription.types];
    else
        return [super methodSignatureForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self methodSignatureForSelector:aSelector] != nil ||
           [super respondsToSelector:aSelector];
}

#pragma mark NSObject protocol

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    return protocol_conformsToProtocol(_mockedProtocol, aProtocol);
}

@end
