// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTProtocolMock.h"

#import <objc/runtime.h>


@interface MKTProtocolMock ()
@property (nonatomic, assign, readonly) BOOL includeOptionalMethods;
@end

@implementation MKTProtocolMock

- (instancetype)initWithProtocol:(Protocol *)aProtocol
          includeOptionalMethods:(BOOL)includeOptionalMethods
{
    self = [super init];
    if (self)
    {
        _mockedProtocol = aProtocol;
        _includeOptionalMethods = includeOptionalMethods;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"mock implementer of %@ protocol",
            NSStringFromProtocol(self.mockedProtocol)];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    struct objc_method_description methodDescription =
            protocol_getMethodDescription(self.mockedProtocol, aSelector, YES, YES);
    if (!methodDescription.name && self.includeOptionalMethods)
        methodDescription = protocol_getMethodDescription(self.mockedProtocol, aSelector, NO, YES);
    if (!methodDescription.name)
        methodDescription = protocol_getMethodDescription(self.mockedProtocol, aSelector, YES, NO);
    if (!methodDescription.name && self.includeOptionalMethods)
        methodDescription = protocol_getMethodDescription(self.mockedProtocol, aSelector, NO, NO);
    if (!methodDescription.name)
        return nil;
    return [NSMethodSignature signatureWithObjCTypes:methodDescription.types];
}

#pragma mark - NSObject protocol

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    return protocol_conformsToProtocol(self.mockedProtocol, aProtocol);
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self methodSignatureForSelector:aSelector] != nil;
}

#pragma mark - Support being called as isEqual: argument

- (BOOL)isNSArray__ { return NO; }
- (BOOL)isNSData__ { return NO; }
- (BOOL)isNSDictionary__ { return NO; }
- (BOOL)isNSNumber__ { return NO; }
- (BOOL)isNSString__ { return NO; }

@end
