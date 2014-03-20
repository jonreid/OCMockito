//
//  OCMockito - MKTReturnTypeSetterChain.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTReturnTypeSetterChain.h"

#import "MKTObjectReturnTypeSetter.h"
#import "MKTClassReturnTypeSetter.h"
#import "MKTCharReturnTypeSetter.h"
#import "MKTBoolReturnTypeSetter.h"
#import "MKTLongLongReturnTypeSetter.h"
#import "MKTIntReturnTypeSetter.h"
#import "MKTShortReturnTypeSetter.h"
#import "MKTLongReturnTypeSetter.h"
#import "MKTUnsignedCharReturnTypeSetter.h"
#import "MKTUnsignedIntReturnTypeSetter.h"
#import "MKTUnsignedShortReturnTypeSetter.h"
#import "MKTUnsignedLongReturnTypeSetter.h"
#import "MKTUnsignedLongLongReturnTypeSetter.h"
#import "MKTFloatReturnTypeSetter.h"
#import "MKTDoubleReturnTypeSetter.h"


MKTReturnTypeSetter *MKTReturnTypeSetterChain(void)
{
    static MKTReturnTypeSetter *chain = nil;
    if (!chain)
    {
        MKTReturnTypeSetter *objectSetter = [[MKTObjectReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *classSetter = [[MKTClassReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *charSetter = [[MKTCharReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *boolSetter = [[MKTBoolReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *intSetter = [[MKTIntReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *shortSetter = [[MKTShortReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *longSetter = [[MKTLongReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *longLongSetter = [[MKTLongLongReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *unsignedCharSetter = [[MKTUnsignedCharReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *unsignedIntSetter = [[MKTUnsignedIntReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *unsignedShortSetter = [[MKTUnsignedShortReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *unsignedLongSetter = [[MKTUnsignedLongReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *unsignedLongLongSetter = [[MKTUnsignedLongLongReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *floatSetter = [[MKTFloatReturnTypeSetter alloc] init];
        MKTReturnTypeSetter *doubleSetter = [[MKTDoubleReturnTypeSetter alloc] init];

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
