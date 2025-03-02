// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT
//  Contribution by Kevin Lundberg

#import "MKTObjectAndProtocolMock.h"

#import "MKTDynamicProperties.h"
#import <objc/runtime.h>


@interface MKTObjectAndProtocolMock ()
@property (nonatomic, strong, readonly) Class mockedClass;
@property (nonatomic, strong, readonly) MKTDynamicProperties *dynamicProperties;
@end

@implementation MKTObjectAndProtocolMock

- (instancetype)initWithClass:(Class)aClass protocol:(Protocol *)protocol
{
    self = [super initWithProtocol:protocol includeOptionalMethods:YES];
    if (self)
    {
        _mockedClass = aClass;
        _dynamicProperties = [[MKTDynamicProperties alloc] initWithClass:aClass];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"mock object of %@ implementing %@ protocol",
            NSStringFromClass(self.mockedClass), NSStringFromProtocol(self.mockedProtocol)];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *dynamicPropertySignature = [self.dynamicProperties methodSignatureForSelector:aSelector];
    if (dynamicPropertySignature)
        return dynamicPropertySignature;
    NSMethodSignature *signature = [self.mockedClass instanceMethodSignatureForSelector:aSelector];
    if (signature)
        return signature;
    return [super methodSignatureForSelector:aSelector];
}


#pragma mark - NSObject protocol

- (BOOL)isKindOfClass:(Class)aClass
{
    return [self.mockedClass isSubclassOfClass:aClass];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self.dynamicProperties methodSignatureForSelector:aSelector] ||
           [self.mockedClass instancesRespondToSelector:aSelector] ||
           [super respondsToSelector:aSelector];
}

@end
