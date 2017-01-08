//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class MKTCallStackElement;


NS_ASSUME_NONNULL_BEGIN

NSArray<MKTCallStackElement *> *MKTFilterCallStack(NSArray<MKTCallStackElement *> *callStackSymbols);

NS_ASSUME_NONNULL_END
