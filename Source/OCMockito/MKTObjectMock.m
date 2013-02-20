//
//  OCMockito - MKTObjectMock.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTObjectMock.h"
#import "MKTMockSettings.h"


@implementation MKTObjectMock
{
    Class _mockedClass;
}

+ (id)mockForClass:(Class)aClass
{
    return [[self alloc] initWithClass:aClass settings:nil];
}

+ (id)mockForClass:(Class)aClass withSettings:(MKTMockSettings *)settings
{
    return [[self alloc] initWithClass:aClass settings:settings];
}

- (id)initWithClass:(Class)aClass settings:(MKTMockSettings *)settings
{
    self = [super initWithSettings:settings];
    if (self)
        _mockedClass = aClass;
    return self;
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
    return [_mockedClass instancesRespondToSelector:aSelector];
}

@end
