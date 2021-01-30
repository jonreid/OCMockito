//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import <Foundation/Foundation.h>
#import <OCMockito/MKTNonObjectArgumentMatching.h>


NS_ASSUME_NONNULL_BEGIN

@interface MKTBaseMockObject : NSProxy <MKTNonObjectArgumentMatching>

+ (BOOL)isMockObject:(nullable id)object;

- (instancetype)init;
- (void)stopMocking;

@end

NS_ASSUME_NONNULL_END
