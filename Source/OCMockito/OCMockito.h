//
//  OCMockito - OCMockito.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import <objc/objc-api.h>


@interface OCMockito : NSObject

+ (id)mockForClass:(Class)aClass testCase:(id)test;

@end


#define MTMockForClass(aClass)  \
    [OCMockito mockForClass:aClass testCase:self]

#ifdef MOCKITO_SHORTHAND
    #define mockForClass(aClass) MTMockForClass(aClass)
#endif


OBJC_EXPORT id MTVerifyWithLocation(id mock, const char *fileName, int lineNumber);

#define MTVerifyHappenedOnce(mock)  \
    MTVerifyWithLocation(mock, __FILE__, __LINE__)

#ifdef MOCKITO_SHORTHAND
    #define verify(mock) MTVerifyHappenedOnce(mock)
#endif
