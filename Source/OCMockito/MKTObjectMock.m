//
//  OCMockito - MKTObjectMock.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTObjectMock.h"


@implementation MKTObjectMock
{
    Class mockedClass;
}

+ (id)mockForClass:(Class)aClass
{
    return [[[self alloc] initWithClass:aClass] autorelease];
}

- (id)initWithClass:(Class)aClass
{
    self = [super init];
    if (self)
        mockedClass = aClass;
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [mockedClass instanceMethodSignatureForSelector:aSelector];
}


#pragma mark NSObject protocol

- (BOOL)isKindOfClass:(Class)aClass
{
    return [mockedClass isSubclassOfClass:aClass];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [mockedClass instancesRespondToSelector:aSelector];
}

@end
