// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface MKTCallStackElement : NSObject

@property (nonatomic, copy, readonly) NSString *moduleName;
@property (nonatomic, copy, readonly) NSString *instruction;

- (instancetype)initWithSymbols:(NSString *)element NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
