//
//  OCMockito - MKMockAwareVerificationMode.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MKMockAwareVerificationMode.h"


@interface MKMockAwareVerificationMode ()
@property(nonatomic, retain) MKClassMock *mock;
@property(nonatomic, retain) id <MKVerificationMode> mode;
@end


@implementation MKMockAwareVerificationMode

@synthesize mock;
@synthesize mode;

+ (id)verificationWithMock:(MKClassMock *)aMock mode:(id <MKVerificationMode>)aMode
{
    return [[[self alloc] initWithMock:aMock mode:aMode] autorelease];
}

- (id)initWithMock:(MKClassMock *)aMock mode:(id <MKVerificationMode>)aMode
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


#pragma mark - MTVerificationMode

- (void)verifyData:(MKVerificationData *)data
{
    [mode verifyData:data];
}

@end
