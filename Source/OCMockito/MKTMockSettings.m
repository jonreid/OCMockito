//
//  OCMockito - MKTMockSettings.h
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTMockSettings.h"


@implementation MKTMockSettings

- (void)useDefaultAnswerForInvocation:(NSInvocation *)invocation
{
    if (_spiedObject)
        [self letSpiedObjectHandleInvocation:invocation];
}

- (void)letSpiedObjectHandleInvocation:(NSInvocation *)invocation
{
    [invocation setTarget:_spiedObject];
    [invocation invoke];
}

@end
