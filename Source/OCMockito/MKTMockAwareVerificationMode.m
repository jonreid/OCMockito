//
//  OCMockito - MKTMockAwareVerificationMode.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//

#import "MKTMockAwareVerificationMode.h"


@interface MKTMockAwareVerificationMode ()
{
    MKTObjectMock *_mock;
    id <MKTVerificationMode> _mode;
}
@end


@implementation MKTMockAwareVerificationMode

+ (id)verificationWithMock:(MKTObjectMock *)mock mode:(id <MKTVerificationMode>)mode
{
    return [[[self alloc] initWithMock:mock mode:mode] autorelease];
}

- (id)initWithMock:(MKTObjectMock *)mock mode:(id <MKTVerificationMode>)mode
{
    self = [super init];
    if (self)
    {
        _mock = [mock retain];
        _mode = [mode retain];
    }
    return self;
}

- (void)dealloc
{
    [_mock release];
    [_mode release];
    [super dealloc];
}


#pragma mark MKTVerificationMode

- (void)verifyData:(MKTVerificationData *)data
{
    [_mode verifyData:data];
}

@end
