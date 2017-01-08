//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Igor Sales

#import <Foundation/Foundation.h>

@class MKTClassObjectMock;


NS_ASSUME_NONNULL_BEGIN

@interface MKTSingletonSwizzler : NSObject

- (instancetype)initWithMock:(MKTClassObjectMock *)classMock NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (void)swizzleSingletonAtSelector:(SEL)singletonSelector;
- (void)unswizzleSingletonsForMock;

@end

NS_ASSUME_NONNULL_END
