//
//  OCMockito - OCMockito.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import <objc/objc-api.h>


@interface OCMockito : NSObject

+ (id)mockForClass:(Class)aClass;

@end


#define MTMockForClass(aClass) [OCMockito mockForClass:aClass]

#ifdef MOCKITO_SHORTHAND
    #define mockForClass(aClass) MTMockForClass(aClass)
#endif


OBJC_EXPORT id MTVerifyWithLocation(id mock, id testCase, const char *fileName, int lineNumber);

#define MTVerify(mock) MTVerifyWithLocation(mock, self, __FILE__, __LINE__)

#ifdef MOCKITO_SHORTHAND
    #define verify(mock) MTVerify(mock)
#endif
