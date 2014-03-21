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

    NSDictionary *_propertySelectors;
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

        NSMutableDictionary *propertySelectors = [[NSMutableDictionary alloc] init];

        Class _class = aClass;
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

                    [propertySelectors setObject:[self getGetterSignatureFor:property]
                                          forKey:[self getGetterNameFor:property]];
                    if (![self isReadonly:property])
                    {
                        [propertySelectors setObject:[self getSetterSignatureFor:property]
                                              forKey:[self getSetterNameFor:property]];
                    }
                }
            }
            free(properties);

            _class = [_class superclass];
        }

        _propertySelectors = propertySelectors;
    }

    return self;
}

- (NSMethodSignature *)getSetterSignatureFor:(objc_property_t)aProperty
{
    NSString *typeString= [self getTypeString:aProperty];

    return [NSMethodSignature signatureWithObjCTypes:
            [[NSString stringWithFormat:@"v@:%@", typeString] UTF8String]];
}

- (id)getGetterSignatureFor:(objc_property_t)aProperty
{
    NSString *typeString= [self getTypeString:aProperty];

    return [NSMethodSignature signatureWithObjCTypes:
            [[NSString stringWithFormat:@"%@@:", typeString] UTF8String]];
}

- (NSString *)getTypeString:(objc_property_t)aProperty
{
    char *type = property_copyAttributeValue(aProperty, "T");
    NSString * typeString = @"";
    if (type) {
        typeString = [NSString stringWithUTF8String:type];
        free(type);
    }
    return typeString;
}

- (NSString *)getNameFor:(objc_property_t)aProperty
{
    return [NSString stringWithUTF8String:property_getName(aProperty)];
}

- (NSString *)getGetterNameFor:(objc_property_t)pProperty
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

- (NSString *)getSetterNameFor:(objc_property_t)pProperty
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
    NSMethodSignature *signature = [_propertySelectors objectForKey:NSStringFromSelector(aSelector)];

    if (signature)
        return signature;
    else
        return [_mockedClass instanceMethodSignatureForSelector:aSelector];
}


#pragma mark NSObject protocol

- (BOOL)isKindOfClass:(Class)aClass
{
    return [_mockedClass isSubclassOfClass:aClass];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [_propertySelectors objectForKey:NSStringFromSelector(aSelector)] ||
            [_mockedClass instancesRespondToSelector:aSelector];
}

@end
