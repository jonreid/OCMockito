//
//  OCMockito - MTClassMock.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTClassMock.h"

#import "MTInvocationContainer.h"
#import "MTMockingProgress.h"
#import "MTMockitoCore.h"
#import "MTVerificationData.h"
#import "MTVerificationMode.h"


@interface MTClassMock ()
@property(nonatomic, assign) Class mockedClass;
@property(nonatomic, retain) MTInvocationContainer *invocationContainer;
@end


@implementation MTClassMock

@synthesize mockedClass;
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
        invocationContainer = [[MTInvocationContainer alloc] init];
    }
    return self;
}


- (void)dealloc
{
    [invocationContainer release];
    [super dealloc];
}


- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    MTMockingProgress *mockingProgress = [[MTMockitoCore sharedCore] mockingProgress];
    id <MTVerificationMode> verificationMode = [mockingProgress pullVerificationMode];
    if (verificationMode)
    {
        MTVerificationData *data = [[[MTVerificationData alloc] init] autorelease];
        [data setInvocations:invocationContainer];
        [data setTestLocation:[mockingProgress testLocation]];
        [verificationMode verifyData:data];
    }
    else
    {
        [invocationContainer registerInvocation:anInvocation];
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
