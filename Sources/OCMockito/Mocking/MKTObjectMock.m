// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTObjectMock.h"

#import "MKTDynamicProperties.h"


@interface MKTObjectMock ()
@property (nonatomic, strong, readonly) Class mockedClass;
@property (nonatomic, strong, readonly) MKTDynamicProperties *dynamicProperties;
@end

@implementation MKTObjectMock

- (instancetype)initWithClass:(Class)aClass
{
    self = [super init];
    if (self)
    {
        _mockedClass = aClass;
        _dynamicProperties = [[MKTDynamicProperties alloc] initWithClass:aClass];
    }
    return self;
}

- (NSString *)description
{
    return [@"mock object of " stringByAppendingString:NSStringFromClass(self.mockedClass)];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *dynamicPropertySignature = [self.dynamicProperties methodSignatureForSelector:aSelector];
    if (dynamicPropertySignature)
        return dynamicPropertySignature;
    return [self.mockedClass instanceMethodSignatureForSelector:aSelector];
}


#pragma mark - NSObject protocol

- (BOOL)isKindOfClass:(Class)aClass
{
    return [self.mockedClass isSubclassOfClass:aClass];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self.dynamicProperties methodSignatureForSelector:aSelector] ||
           [self.mockedClass instancesRespondToSelector:aSelector];
}

@end
