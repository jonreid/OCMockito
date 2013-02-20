//
//  OCMockito - MKTMockSettings.h
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import <Foundation/Foundation.h>


@interface MKTMockSettings : NSObject

@property (nonatomic, strong) id spiedObject;

- (void)useDefaultAnswerForInvocation:(NSInvocation *)invocation;
@end
