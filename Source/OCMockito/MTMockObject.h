//
//  OCMockito - MTMockObject.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>


@interface MTMockObject : NSProxy

+ (id)mockForClass:(Class)aClass;

@end
