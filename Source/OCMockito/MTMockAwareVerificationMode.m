//
//  OCMockito - MTMockAwareVerificationMode.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTMockAwareVerificationMode.h"


@interface MTMockAwareVerificationMode ()
@property(nonatomic, retain) MTClassMock *mock;
@property(nonatomic, retain) id <MTVerificationMode> mode;
@end


@implementation MTMockAwareVerificationMode

@synthesize mock;
@synthesize mode;


+ (id)verificationWithMock:(MTClassMock *)aMock mode:(id <MTVerificationMode>)aMode
{
    return [[[self alloc] initWithMock:aMock mode:aMode] autorelease];
}


- (id)initWithMock:(MTClassMock *)aMock mode:(id <MTVerificationMode>)aMode
{
    self = [super init];
    if (self)
    {
        mock = [aMock retain];
        mode = [aMode retain];
    }
    return self;
}


- (void)dealloc
{
    [mock release];
    [mode release];
    [super dealloc];
}


#pragma mark -
#pragma mark MTVerificationMode

- (void)verifyWithData:(id <MTVerificationData>)data
{
    [mode verifyWithData:data];
}

@end
