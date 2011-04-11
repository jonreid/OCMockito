//
//  OCMockito - MTVerificationData.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

@class MTInvocationMatcher;


@protocol MTVerificationData

- (NSArray *)allInvocations;
- (MTInvocationMatcher *)wanted;

@end
