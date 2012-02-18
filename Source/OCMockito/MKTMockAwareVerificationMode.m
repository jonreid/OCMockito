//
//  OCMockito - MKTMockAwareVerificationMode.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MKTMockAwareVerificationMode.h"


@interface MKTMockAwareVerificationMode ()
@property (nonatomic, retain) MKTClassMock *mock;
@property (nonatomic, retain) id <MKTVerificationMode> mode;
@end


@implementation MKTMockAwareVerificationMode

@synthesize mock;
@synthesize mode;

+ (id)verificationWithMock:(MKTClassMock *)aMock mode:(id <MKTVerificationMode>)aMode
{
    return [[[self alloc] initWithMock:aMock mode:aMode] autorelease];
}

- (id)initWithMock:(MKTClassMock *)aMock mode:(id <MKTVerificationMode>)aMode
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

- (void)verifyData:(MKTVerificationData *)data
{
    [mode verifyData:data];
}

@end
