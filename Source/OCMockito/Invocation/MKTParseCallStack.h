//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import <Foundation/Foundation.h>

@class MKTCallStackElement;


NS_ASSUME_NONNULL_BEGIN

NSArray<MKTCallStackElement *> *MKTParseCallStack(NSArray<NSString *> *callStackSymbols);

NS_ASSUME_NONNULL_END
