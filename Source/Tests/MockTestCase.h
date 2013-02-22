//
//  OCMockito - MockTestCase.h
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import <Foundation/Foundation.h>


#define verifyWithMockTestCase(mock)  \
    MKTVerifyWithLocation(mock, mockTestCase, __FILE__, __LINE__)

#define verifyCountWithMockTestCase(mock, mode)  \
    MKTVerifyCountWithLocation(mock, mode, mockTestCase, __FILE__, __LINE__)


@interface MockTestCase : NSObject

@property (nonatomic, assign) NSUInteger failureCount;
@property (nonatomic, strong) NSException *failureException;

- (void)failWithException:(NSException *)exception;

@end
