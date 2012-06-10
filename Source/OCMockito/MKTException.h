//
//  OCMockito - MKTException.h
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>


@interface MKTException : NSException

+ (NSException *)failureInFile:(NSString *)fileName
                        atLine:(int)lineNumber
                        reason:(NSString *)reason;

@end
