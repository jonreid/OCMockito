//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Igor Sales

#import <Foundation/Foundation.h>

@class MKTClassObjectMock;


@interface MKTSingletonSwizzler : NSObject

- (instancetype)initWithMock:(MKTClassObjectMock *)classMock;
- (void)swizzleSingletonAtSelector:(SEL)singletonSelector;
- (void)unswizzleSingletonsForMock;

@end
