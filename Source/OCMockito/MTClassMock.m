//
//  OCMockito - MTClassMock.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTClassMock.h"

#import "MTInvocationContainer.h"
#import "MTInvocationMatcher.h"
#import "MTMockingProgress.h"
#import "MTOngoingStubbing.h"
#import "MTVerificationData.h"
#import "MTVerificationMode.h"


@interface MTClassMock ()
@property(nonatomic, assign) Class mockedClass;
@property(nonatomic, retain) MTMockingProgress *mockingProgress;
@property(nonatomic, retain) MTInvocationContainer *invocationContainer;
@end


@implementation MTClassMock

@synthesize mockedClass;
@synthesize mockingProgress;
@synthesize invocationContainer;


+ (id)mockForClass:(Class)aClass
{
    return [[[self alloc] initWithClass:aClass] autorelease];
}


- (id)initWithClass:(Class)aClass
{
    if (self)
    {
        mockedClass = aClass;
        mockingProgress = [[MTMockingProgress sharedProgress] retain];
        invocationContainer = [[MTInvocationContainer alloc] initWithMockingProgress:mockingProgress];
    }
    return self;
}


- (void)dealloc
{
    [mockingProgress release];
    [invocationContainer release];
    [super dealloc];
}


- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    id <MTVerificationMode> verificationMode = [mockingProgress pullVerificationMode];
    if (verificationMode)
    {
        MTInvocationMatcher *invocationMatcher = [mockingProgress pullInvocationMatcher];
        if (!invocationMatcher)
            invocationMatcher = [[[MTInvocationMatcher alloc] init] autorelease];
        [invocationMatcher setExpectedInvocation:anInvocation];
        
        MTVerificationData *data = [[MTVerificationData alloc] init];
        [data setInvocations:invocationContainer];
        [data setWanted:invocationMatcher];
        [data setTestLocation:[mockingProgress testLocation]];
        [verificationMode verifyData:data];
        
        [data release];
        return;
    }
    
    [invocationContainer setInvocationForPotentialStubbing:anInvocation];
    MTOngoingStubbing *ongoingStubbing = [[MTOngoingStubbing alloc]
                                          initWithInvocationContainer:invocationContainer];
    [mockingProgress reportOngoingStubbing:ongoingStubbing];
    [ongoingStubbing release];
    
    NSMethodSignature *methodSignature = [anInvocation methodSignature];
    const char* methodReturnType = [methodSignature methodReturnType];
    if (strcmp(methodReturnType, @encode(void)) != 0)
    {
        id answer = [invocationContainer findAnswerFor:anInvocation];
        [anInvocation setReturnValue:&answer];
    }
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [mockedClass instanceMethodSignatureForSelector:aSelector];
}


- (id)withMatcher:(id <HCMatcher>)matcher forArgument:(NSUInteger)index
{
    [mockingProgress setMatcher:matcher forArgument:index];
    return self;
}


- (id)withMatcher:(id <HCMatcher>)matcher
{
    return [self withMatcher:matcher forArgument:0];
}


#pragma mark -
#pragma mark NSObject

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [mockedClass instancesRespondToSelector:aSelector];
}

@end
