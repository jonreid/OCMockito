//
//  OCMockito - MKTReturnSetterChain.m
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


MKTReturnSetter *MKTReturnSetterChain(void)
{
    static MKTReturnSetter *chain = nil;
    if (!chain)
    {
        MKTReturnSetter *objectSetter = [[MKTObjectReturnSetter alloc] init];
        MKTReturnSetter *classSetter = [[MKTClassReturnSetter alloc] init];
        MKTReturnSetter *charSetter = [[MKTCharReturnSetter alloc] init];
        MKTReturnSetter *boolSetter = [[MKTBoolReturnSetter alloc] init];
        MKTReturnSetter *intSetter = [[MKTIntReturnSetter alloc] init];
        MKTReturnSetter *shortSetter = [[MKTShortReturnSetter alloc] init];
        MKTReturnSetter *longSetter = [[MKTLongReturnSetter alloc] init];
        MKTReturnSetter *longLongSetter = [[MKTLongLongReturnSetter alloc] init];
        MKTReturnSetter *unsignedCharSetter = [[MKTUnsignedCharReturnSetter alloc] init];
        MKTReturnSetter *unsignedIntSetter = [[MKTUnsignedIntReturnSetter alloc] init];
        MKTReturnSetter *unsignedShortSetter = [[MKTUnsignedShortReturnSetter alloc] init];
        MKTReturnSetter *unsignedLongSetter = [[MKTUnsignedLongReturnSetter alloc] init];
        MKTReturnSetter *unsignedLongLongSetter = [[MKTUnsignedLongLongReturnSetter alloc] init];
        MKTReturnSetter *floatSetter = [[MKTFloatReturnSetter alloc] init];
        MKTReturnSetter *doubleSetter = [[MKTDoubleReturnSetter alloc] init];

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
