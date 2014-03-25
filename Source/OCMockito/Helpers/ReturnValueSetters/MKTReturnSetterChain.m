//
//  OCMockito - MKTReturnValueSetterChain.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTReturnSetterChain.h"

#import "MKTObjectReturnSetter.h"
#import "MKTClassReturnSetter.h"
#import "MKTCharReturnSetter.h"
#import "MKTBoolReturnSetter.h"
#import "MKTLongLongReturnSetter.h"
#import "MKTIntReturnSetter.h"
#import "MKTShortReturnSetter.h"
#import "MKTLongReturnSetter.h"
#import "MKTUnsignedCharReturnSetter.h"
#import "MKTUnsignedIntReturnSetter.h"
#import "MKTUnsignedShortReturnSetter.h"
#import "MKTUnsignedLongReturnSetter.h"
#import "MKTUnsignedLongLongReturnSetter.h"
#import "MKTFloatReturnSetter.h"
#import "MKTDoubleReturnSetter.h"


MKTReturnValueSetter *MKTReturnValueSetterChain(void)
{
    static MKTReturnValueSetter *chain = nil;
    if (!chain)
    {
        MKTReturnValueSetter *objectSetter = [[MKTObjectReturnSetter alloc] init];
        MKTReturnValueSetter *classSetter = [[MKTClassReturnSetter alloc] init];
        MKTReturnValueSetter *charSetter = [[MKTCharReturnSetter alloc] init];
        MKTReturnValueSetter *boolSetter = [[MKTBoolReturnSetter alloc] init];
        MKTReturnValueSetter *intSetter = [[MKTIntReturnSetter alloc] init];
        MKTReturnValueSetter *shortSetter = [[MKTShortReturnSetter alloc] init];
        MKTReturnValueSetter *longSetter = [[MKTLongReturnSetter alloc] init];
        MKTReturnValueSetter *longLongSetter = [[MKTLongLongReturnSetter alloc] init];
        MKTReturnValueSetter *unsignedCharSetter = [[MKTUnsignedCharReturnSetter alloc] init];
        MKTReturnValueSetter *unsignedIntSetter = [[MKTUnsignedIntReturnSetter alloc] init];
        MKTReturnValueSetter *unsignedShortSetter = [[MKTUnsignedShortReturnSetter alloc] init];
        MKTReturnValueSetter *unsignedLongSetter = [[MKTUnsignedLongReturnSetter alloc] init];
        MKTReturnValueSetter *unsignedLongLongSetter = [[MKTUnsignedLongLongReturnSetter alloc] init];
        MKTReturnValueSetter *floatSetter = [[MKTFloatReturnSetter alloc] init];
        MKTReturnValueSetter *doubleSetter = [[MKTDoubleReturnSetter alloc] init];

        chain = objectSetter;
        objectSetter.successor = classSetter;
        classSetter.successor = charSetter;
        charSetter.successor = boolSetter;
        boolSetter.successor = intSetter;
        intSetter.successor = shortSetter;
        shortSetter.successor = longSetter;
        longSetter.successor = longLongSetter;
        longLongSetter.successor = unsignedCharSetter;
        unsignedCharSetter.successor = unsignedIntSetter;
        unsignedIntSetter.successor = unsignedShortSetter;
        unsignedShortSetter.successor = unsignedLongSetter;
        unsignedLongSetter.successor = unsignedLongLongSetter;
        unsignedLongLongSetter.successor = floatSetter;
        floatSetter.successor = doubleSetter;
    }
    return chain;
}
