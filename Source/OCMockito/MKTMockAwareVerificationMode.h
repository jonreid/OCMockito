//
//  OCMockito - MKTMockAwareVerificationMode.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MKTVerificationMode.h"


@class MKTClassMock;
@protocol MKVerificationMode;


@interface MKTMockAwareVerificationMode : NSObject <MKTVerificationMode>

+ (id)verificationWithMock:(MKTClassMock *)aMock mode:(id <MKTVerificationMode>)aMode;
- (id)initWithMock:(MKTClassMock *)mock mode:(id <MKTVerificationMode>)mode;

@end
