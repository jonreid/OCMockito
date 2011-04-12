//
//  OCMockito - NSException+OCMockito.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>


@interface NSException (OCMockito)

+ (NSException *)failureInFile:(NSString *)fileName atLine:(int)lineNumber reason:(NSString *)reason;

@end
