//
//  OCMockito - MTOngoingStubbing.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTOngoingStubbing.h"

#import "MTInvocationContainer.h"


@interface MTOngoingStubbing ()
@property(nonatomic, retain) MTInvocationContainer *invocationContainer;
@end


@implementation MTOngoingStubbing

@synthesize invocationContainer;


- (id)initWithInvocationContainer:(MTInvocationContainer *)anInvocationContainer
{
    self = [super init];
    if (self)
        invocationContainer = [anInvocationContainer retain];
    return self;
}


- (void)dealloc
{
    [invocationContainer release];
    [super dealloc];
}


- (MTOngoingStubbing *)willReturn:(id)object
{
    [invocationContainer addAnswer:object];
    return self;
}


#define DEFINE_RETURN_METHOD(type, typeName)                                        \
    - (MTOngoingStubbing *)willReturn ## typeName:(type)value                       \
    {                                                                               \
        [invocationContainer addAnswer:[NSNumber numberWith ## typeName:value]];    \
        return self;                                                                \
    }


DEFINE_RETURN_METHOD(BOOL, Bool)
DEFINE_RETURN_METHOD(char, Char)
DEFINE_RETURN_METHOD(int, Int)
DEFINE_RETURN_METHOD(short, Short)
DEFINE_RETURN_METHOD(long, Long)
DEFINE_RETURN_METHOD(long long, LongLong)
DEFINE_RETURN_METHOD(NSInteger, Integer)
DEFINE_RETURN_METHOD(unsigned char, UnsignedChar)
DEFINE_RETURN_METHOD(unsigned int, UnsignedInt)
DEFINE_RETURN_METHOD(unsigned short, UnsignedShort)
DEFINE_RETURN_METHOD(unsigned long, UnsignedLong)
DEFINE_RETURN_METHOD(unsigned long long, UnsignedLongLong)
DEFINE_RETURN_METHOD(NSUInteger, UnsignedInteger)
DEFINE_RETURN_METHOD(float, Float)
DEFINE_RETURN_METHOD(double, Double)


#pragma mark -
#pragma mark MTPrimitiveArgumentMatching

- (id)withMatcher:(id <HCMatcher>)matcher forArgument:(NSUInteger)index
{
    [invocationContainer setMatcher:matcher atIndex:index+2];
    return self;
}


- (id)withMatcher:(id <HCMatcher>)matcher
{
    return [self withMatcher:matcher forArgument:0];
}

@end
