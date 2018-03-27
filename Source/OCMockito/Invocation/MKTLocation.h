//  OCMockito by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface MKTLocation : NSObject

- (instancetype)init;
- (instancetype)initWithCallStack:(NSArray<NSString *> *)callStack NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
