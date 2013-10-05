//
//  NSInvocation+TKAdditions.h
//
//  Created by Taras Kalapun
//

#import <Foundation/Foundation.h>

@interface NSInvocation (TKAdditions)

- (NSArray *)tk_arrayArguments;
- (void)mkt_setReturnValue:(id)returnValue;

@end
