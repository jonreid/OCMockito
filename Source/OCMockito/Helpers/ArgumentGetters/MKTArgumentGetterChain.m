//
//  OCMockito - MKTArgumentGetterChain.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTArgumentGetterChain.h"

#import "MKTObjectArgumentGetter.h"
#import "MKTSelectorArgumentGetter.h"
#import "MKTClassArgumentGetter.h"
#import "MKTCharArgumentGetter.h"
#import "MKTBoolArgumentGetter.h"
#import "MKTIntArgumentGetter.h"
#import "MKTShortArgumentGetter.h"
#import "MKTLongArgumentGetter.h"
#import "MKTLongLongArgumentGetter.h"
#import "MKTUnsignedCharArgumentGetter.h"
#import "MKTUnsignedIntArgumentGetter.h"
#import "MKTUnsignedShortArgumentGetter.h"
#import "MKTUnsignedLongArgumentGetter.h"
#import "MKTUnsignedLongLongArgumentGetter.h"
#import "MKTFloatArgumentGetter.h"
#import "MKTDoubleArgumentGetter.h"
#import "MKTPointerArgumentGetter.h"
#import "MKTStructArgumentGetter.h"


MKTArgumentGetter *MKTArgumentGetterChain(void)
{
    static MKTArgumentGetter *chain = nil;
    if (!chain)
    {
        MKTArgumentGetter *objectGetter = [[MKTObjectArgumentGetter alloc] init];
        MKTArgumentGetter *selectorGetter = [[MKTSelectorArgumentGetter alloc] init];
        MKTArgumentGetter *classGetter = [[MKTClassArgumentGetter alloc] init];
        MKTArgumentGetter *charGetter = [[MKTCharArgumentGetter alloc] init];
        MKTArgumentGetter *boolGetter = [[MKTBoolArgumentGetter alloc] init];
        MKTArgumentGetter *intGetter = [[MKTIntArgumentGetter alloc] init];
        MKTArgumentGetter *shortGetter = [[MKTShortArgumentGetter alloc] init];
        MKTArgumentGetter *longGetter = [[MKTLongArgumentGetter alloc] init];
        MKTArgumentGetter *longLongGetter = [[MKTLongLongArgumentGetter alloc] init];
        MKTArgumentGetter *unsignedCharGetter = [[MKTUnsignedCharArgumentGetter alloc] init];
        MKTArgumentGetter *unsignedIntGetter = [[MKTUnsignedIntArgumentGetter alloc] init];
        MKTArgumentGetter *unsignedShortGetter = [[MKTUnsignedShortArgumentGetter alloc] init];
        MKTArgumentGetter *unsignedLongGetter = [[MKTUnsignedLongArgumentGetter alloc] init];
        MKTArgumentGetter *unsignedLongLongGetter = [[MKTUnsignedLongLongArgumentGetter alloc] init];
        MKTArgumentGetter *floatGetter = [[MKTFloatArgumentGetter alloc] init];
        MKTArgumentGetter *doubleGetter = [[MKTDoubleArgumentGetter alloc] init];
        MKTArgumentGetter *pointerGetter = [[MKTPointerArgumentGetter alloc] init];
        MKTArgumentGetter *structGetter = [[MKTStructArgumentGetter alloc] init];

        chain = objectGetter;
        objectGetter.successor = selectorGetter;
        selectorGetter.successor = classGetter;
        classGetter.successor = charGetter;
        charGetter.successor = boolGetter;
        boolGetter.successor = intGetter;
        intGetter.successor = shortGetter;
        shortGetter.successor = longGetter;
        longGetter.successor = longLongGetter;
        longLongGetter.successor = unsignedCharGetter;
        unsignedCharGetter.successor = unsignedIntGetter;
        unsignedIntGetter.successor = unsignedShortGetter;
        unsignedShortGetter.successor = unsignedLongGetter;
        unsignedLongGetter.successor = unsignedLongLongGetter;
        unsignedLongLongGetter.successor = floatGetter;
        floatGetter.successor = doubleGetter;
        doubleGetter.successor = pointerGetter;
        pointerGetter.successor = structGetter;
    }
    return chain;
}
