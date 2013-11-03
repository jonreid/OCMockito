//
//  MKTPartialMock.h
//  OCMockito
//
//  Created by Erik Blomqvist on 2013-10-20.
//  Copyright (c) 2013 Erik Blomqvist. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKTBaseMockObject.h"

@interface MKTPartialMock : MKTBaseMockObject

+ (id)mockForObject:(id)spiedObject;

- (void)disguise;

@end
