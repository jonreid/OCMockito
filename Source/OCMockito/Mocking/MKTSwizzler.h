//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Igor Sales

#import <Foundation/Foundation.h>

@class MKTClassObjectMock;


extern NSMutableDictionary *singletonMap;
NSString *singletonKey(Class aClass, SEL aSelector);

@interface MKTSwizzler : NSObject
- (void)swizzleSingletonAtSelector:(SEL)singletonSelector toMock:(MKTClassObjectMock *)theMock;
@end
