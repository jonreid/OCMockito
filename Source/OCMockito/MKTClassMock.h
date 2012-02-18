//
//  OCMockito - MKTClassMock.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MKPrimitiveArgumentMatching.h"


@interface MKTClassMock : NSProxy <MKPrimitiveArgumentMatching>

+ (id)mockForClass:(Class)aClass;
- (id)initWithClass:(Class)aClass;

@end
