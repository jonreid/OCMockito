// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <Foundation/Foundation.h>

@class MKTCallStackElement;


NS_ASSUME_NONNULL_BEGIN

NSArray<MKTCallStackElement *> *MKTParseCallStack(NSArray<NSString *> *callStackSymbols);

NS_ASSUME_NONNULL_END
