//
//  OCMockito - MKMockAwareVerificationMode.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MTVerificationMode.h"


@class MKClassMock;
@protocol MKVerificationMode;


@interface MKMockAwareVerificationMode : NSObject <MKVerificationMode>

+ (id)verificationWithMock:(MKClassMock *)aMock mode:(id <MKVerificationMode>)aMode;
- (id)initWithMock:(MKClassMock *)mock mode:(id <MKVerificationMode>)mode;

@end
