//
//  OCMockito - MTClassMock.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>


@interface MTClassMock : NSProxy

+ (id)mockForClass:(Class)aClass;
- (id)initWithClass:(Class)aClass;

@end
