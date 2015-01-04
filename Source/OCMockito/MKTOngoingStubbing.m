//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <OCHamcrest/OCHamcrest.h>
#import "MKTOngoingStubbing.h"

#import "MKTInvocationContainer.h"
#import "MKTReturns.h"
#import "MKTThrowsException.h"


@interface MKTOngoingStubbing ()
@property (readonly, nonatomic, strong) MKTInvocationContainer *invocationContainer;
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
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:object];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnStruct:(const void *)value objCType:(const char *)type
{
    NSValue *answer = [NSValue valueWithBytes:value objCType:type];
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:answer];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnBool:(BOOL)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnChar:(char)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnInt:(int)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnShort:(short)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnLong:(long)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnLongLong:(long long)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnInteger:(NSInteger)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnUnsignedChar:(unsigned char)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnUnsignedInt:(unsigned int)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnUnsignedShort:(unsigned short)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnUnsignedLong:(unsigned long)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnUnsignedLongLong:(unsigned long long)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnUnsignedInteger:(NSUInteger)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnFloat:(float)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willReturnDouble:(double)value
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:@(value)];
    [self.invocationContainer addAnswer:returns];
    return self;
}

- (MKTOngoingStubbing *)willThrow:(NSException *)exception
{
    MKTThrowsException *throwsException = [[MKTThrowsException alloc] initWithException:exception];
    [self.invocationContainer addAnswer:throwsException];
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
