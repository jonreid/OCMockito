//
//  OCMockito - MKMockAwareVerificationMode.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MKVerificationMode.h"


@class MKTClassMock;
@protocol MKVerificationMode;


@interface MKMockAwareVerificationMode : NSObject <MKVerificationMode>

+ (id)verificationWithMock:(MKTClassMock *)aMock mode:(id <MKVerificationMode>)aMode;
- (id)initWithMock:(MKTClassMock *)mock mode:(id <MKVerificationMode>)mode;

@end
