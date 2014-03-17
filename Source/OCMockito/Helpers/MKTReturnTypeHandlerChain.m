//
//  OCMockito - MKTReturnTypeHandlerChain.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTReturnTypeHandlerChain.h"

#import "MKTObjectReturnTypeHandler.h"
#import "MKTClassReturnTypeHandler.h"
#import "MKTCharReturnTypeHandler.h"
#import "MKTBoolReturnTypeHandler.h"
#import "MKTLongLongReturnTypeHandler.h"
#import "MKTIntReturnTypeHandler.h"
#import "MKTShortReturnTypeHandler.h"
#import "MKTLongReturnTypeHandler.h"
#import "MKTUnsignedCharReturnTypeHandler.h"
#import "MKTUnsignedIntReturnTypeHandler.h"
#import "MKTUnsignedShortReturnTypeHandler.h"
#import "MKTUnsignedLongReturnTypeHandler.h"
#import "MKTUnsignedLongLongReturnTypeHandler.h"
#import "MKTFloatReturnTypeHandler.h"
#import "MKTDoubleReturnTypeHandler.h"


MKTReturnTypeHandler *MKTReturnTypeHandlerChain(void)
{
    static MKTReturnTypeHandler *chain = nil;
    if (!chain)
    {
        MKTReturnTypeHandler *objectHandler = [[MKTObjectReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *classHandler = [[MKTClassReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *charHandler = [[MKTCharReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *boolHandler = [[MKTBoolReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *intHandler = [[MKTIntReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *shortHandler = [[MKTShortReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *longHandler = [[MKTLongReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *longLongHandler = [[MKTLongLongReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *unsignedCharHandler = [[MKTUnsignedCharReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *unsignedIntHandler = [[MKTUnsignedIntReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *unsignedShortHandler = [[MKTUnsignedShortReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *unsignedLongHandler = [[MKTUnsignedLongReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *unsignedLongLongHandler = [[MKTUnsignedLongLongReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *floatHandler = [[MKTFloatReturnTypeHandler alloc] init];
        MKTReturnTypeHandler *doubleHandler = [[MKTDoubleReturnTypeHandler alloc] init];

        chain = objectHandler;
        objectHandler.successor = classHandler;
        classHandler.successor = charHandler;
        charHandler.successor = boolHandler;
        boolHandler.successor = intHandler;
        intHandler.successor = shortHandler;
        shortHandler.successor = longHandler;
        longHandler.successor = longLongHandler;
        longLongHandler.successor = unsignedCharHandler;
        unsignedCharHandler.successor = unsignedIntHandler;
        unsignedIntHandler.successor = unsignedShortHandler;
        unsignedShortHandler.successor = unsignedLongHandler;
        unsignedLongHandler.successor = unsignedLongLongHandler;
        unsignedLongLongHandler.successor = floatHandler;
        floatHandler.successor = doubleHandler;
    }
    return chain;
}
