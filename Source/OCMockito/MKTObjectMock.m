//
//  OCMockito - MKTObjectMock.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import <objc/runtime.h>

#import "MKTObjectMock.h"


@implementation MKTObjectMock
{
    Class _mockedClass;

    NSDictionary *_propertyGetters;
    NSDictionary *_propertySetters;
}

+ (instancetype)mockForClass:(Class)aClass
{
    return [[self alloc] initWithClass:aClass];
}

- (instancetype)initWithClass:(Class)aClass
{
    self = [super init];
    if (self)
    {
        _mockedClass = aClass;

        NSMutableDictionary *propertyGetters = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *propertySetters = [[NSMutableDictionary alloc] init];

        Class _class = [self class];
        while (_class != [NSObject class] && _class != nil)
        {

            unsigned int outCount, i;
            objc_property_t *properties = class_copyPropertyList(_class, &outCount);
            for (i = 0; i < outCount; i++)
            {
                objc_property_t property = properties[i];

                // Check if the property is dynamic (@dynamic).
                char *dynamic = property_copyAttributeValue(property, "D");
                if (dynamic)
                {
                    free(dynamic);

                    NSString *propertyName = [self getNameFor:property];
                    [propertyGetters setObject:propertyName forKey:[self getGetterFor:property]];
                    if (![self isReadonly:property])
                    {
                        [propertySetters setObject:propertyName forKey:[self getSetterFor:property]];
                    }
                }
            }
            free(properties);

            _class = [_class superclass];
        }

        _propertyGetters = propertyGetters;
        _propertySetters = propertySetters;
    }

    return self;
}

- (NSString *)getNameFor:(objc_property_t)pProperty
{
    return [NSString stringWithUTF8String:property_getName(pProperty)];
}

- (NSString *)getGetterFor:(objc_property_t)pProperty
{
    NSString *result;
    char *getterName = property_copyAttributeValue(pProperty, "G");
    if (getterName)
    {
        result = [NSString stringWithUTF8String:getterName];
        free(getterName);
    }
    else
    {
        result = [self getNameFor:pProperty];
    }

    return result;
}

- (NSString *)getSetterFor:(objc_property_t)pProperty
{
    NSString *result;
    char *setterName = property_copyAttributeValue(pProperty, "S");
    if (setterName)
    {
        result = [NSString stringWithUTF8String:setterName];
        free(setterName);
    }
    else
    {
        NSString *name = [self getNameFor:pProperty];
        name = [name stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                             withString:[[name substringToIndex:1] uppercaseString]];
        result = [NSString stringWithFormat:@"set%@:", name];
    }

    return result;
}

- (BOOL)isReadonly:(objc_property_t)pProperty
{
    char *readonly = property_copyAttributeValue(pProperty, "R");

    if (readonly)
    {
        free(readonly);
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSString *)description
{
    return [@"mock object of " stringByAppendingString:NSStringFromClass(_mockedClass)];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [_mockedClass instanceMethodSignatureForSelector:aSelector];
}


#pragma mark NSObject protocol

- (BOOL)isKindOfClass:(Class)aClass
{
    return [_mockedClass isSubclassOfClass:aClass];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self isDynamicMethod:aSelector] || [_mockedClass instancesRespondToSelector:aSelector];
}

- (BOOL)isDynamicMethod:(SEL)aSelector
{
    NSString *selectorString = NSStringFromSelector(aSelector);
    return [_propertyGetters objectForKey:selectorString] != nil ||
            [_propertySetters objectForKey:selectorString] != nil;
}

@end
