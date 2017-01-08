//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface MKTLocation : NSObject

- (instancetype)init;
- (instancetype)initWithCallStack:(NSArray<NSString *> *)callStack NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
