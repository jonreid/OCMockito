//
//  OCMockito - MTMockAwareVerificationMode.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MTVerificationMode.h"


@class MTClassMock;
@protocol MTVerificationMode;


@interface MTMockAwareVerificationMode : NSObject <MTVerificationMode>

+ (id)verificationWithMock:(MTClassMock *)aMock mode:(id <MTVerificationMode>)aMode;
- (id)initWithMock:(MTClassMock *)mock mode:(id <MTVerificationMode>)mode;

@end
