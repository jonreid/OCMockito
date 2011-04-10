//
//  OCMockito - MTMockObject.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTMockObject.h"

@interface MTMockObject ()
@property(nonatomic, assign) Class mockedClass;
- (id)initWithClass:(Class)aClass;
@end


@implementation MTMockObject

@synthesize mockedClass;


+ (id)mockForClass:(Class)aClass
{
    return [[[self alloc] initWithClass:aClass] autorelease];
}


- (id)initWithClass:(Class)aClass
{
    if (self)
        mockedClass = aClass;
    return self;
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [mockedClass instanceMethodSignatureForSelector:aSelector];
}

@end
