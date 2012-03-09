//
//  OCMockito - MKTClassMock.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//

#import "MKTClassMock.h"


@interface MKTClassMock ()
{
    Class mockedClass;
}
@end


@implementation MKTClassMock

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

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [mockedClass instancesRespondToSelector:aSelector];
}

@end
