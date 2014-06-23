//
//  OCMockito - MKTOngoingStubbing.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTOngoingStubbing.h"

#import "MKTInvocationContainer.h"


@interface MKTOngoingStubbing ()

@property (nonatomic, readonly) MKTInvocationContainer *invocationContainer;
@end


@implementation MKTOngoingStubbing


- (instancetype)initWithInvocationContainer:(MKTInvocationContainer *)invocationContainer
{
    self = [super init];
    if (self)
        _invocationContainer = invocationContainer;
    return self;
}

- (MKTOngoingStubbing *)willReturn:(id)object
{
    [self.invocationContainer addAnswer:object];
    return self;
}

- (MKTOngoingStubbing *)willReturnStruct:(const void *)value objCType:(const char *)type
{
    NSValue *answer = [NSValue valueWithBytes:value objCType:type];
    [self.invocationContainer addAnswer:answer];
    return self;
}

- (MKTOngoingStubbing *)willReturnBool:(BOOL)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnChar:(char)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnInt:(int)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnShort:(short)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnLong:(long)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnLongLong:(long long)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnInteger:(NSInteger)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnUnsignedChar:(unsigned char)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnUnsignedInt:(unsigned int)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnUnsignedShort:(unsigned short)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnUnsignedLong:(unsigned long)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnUnsignedLongLong:(unsigned long long)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnUnsignedInteger:(NSUInteger)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnFloat:(float)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}

- (MKTOngoingStubbing *)willReturnDouble:(double)value
{
    [self.invocationContainer addAnswer:@(value)];
    return self;
}


#pragma mark MKTPrimitiveArgumentMatching

- (id)withMatcher:(id <HCMatcher>)matcher forArgument:(NSUInteger)index
{
    [self.invocationContainer setMatcher:matcher atIndex:index];
    return self;
}

- (id)withMatcher:(id <HCMatcher>)matcher
{
    return [self withMatcher:matcher forArgument:0];
}

@end
