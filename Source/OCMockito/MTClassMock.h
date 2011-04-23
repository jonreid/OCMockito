//
//  OCMockito - MTClassMock.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

@protocol HCMatcher;


@interface MTClassMock : NSProxy

+ (id)mockForClass:(Class)aClass;
- (id)initWithClass:(Class)aClass;
- (id)withMatcher:(id <HCMatcher>)matcher forArgument:(NSUInteger)index;
- (id)withMatcher:(id <HCMatcher>)matcher;

@end
