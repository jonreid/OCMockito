//
//  OCMockito - MKTClassMock.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MKTPrimitiveArgumentMatching.h"


@interface MKTClassMock : NSProxy <MKTPrimitiveArgumentMatching>

+ (id)mockForClass:(Class)aClass;
- (id)initWithClass:(Class)aClass;

@end
