//
//  OCMockito - MKTClassObjectMock.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: David Hart
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTClassObjectMock.h"


@interface MKTClassObjectMock ()
@property (nonatomic, strong, readonly) Class mockedClass;
@end

@implementation MKTClassObjectMock

+ (instancetype)mockForClass:(Class)aClass
{
    return [[self alloc] initWithClass:aClass];
}

- (instancetype)initWithClass:(Class)aClass
{
    self = [super init];
    if (self)
        _mockedClass = aClass;
    return self;
}

- (NSString *)description
{
    return [@"mock class of " stringByAppendingString:NSStringFromClass(self.mockedClass)];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [self.mockedClass methodSignatureForSelector:aSelector];
}


#pragma mark NSObject protocol

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self.mockedClass respondsToSelector:aSelector];
}

@end
