//
//  OCMockito - MTClassMock.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTClassMock.h"

#import "MTInvocationContainer.h"
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
        MTVerificationData *data = [[[MTVerificationData alloc] init] autorelease];
        [data setInvocations:invocationContainer];
        [data setTestLocation:[mockingProgress testLocation]];
        [verificationMode verifyData:data];
        return;
    }
    
    [invocationContainer setInvocationForPotentialStubbing:anInvocation];
    MTOngoingStubbing *ongoingStubbing = [[MTOngoingStubbing alloc]
                                          initWithInvocationContainer:invocationContainer];
    [mockingProgress reportOngoingStubbing:ongoingStubbing];
    [ongoingStubbing release];
    
    NSMethodSignature *methodSignature = [anInvocation methodSignature];
    const char* methodReturnType = [methodSignature methodReturnType];
    if (*methodReturnType != 'v')
    {
        id answer = [invocationContainer answer];
        [anInvocation setReturnValue:&answer];
    }
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [mockedClass instanceMethodSignatureForSelector:aSelector];
}


#pragma mark -
#pragma mark NSObject

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [mockedClass instancesRespondToSelector:aSelector];
}

@end
