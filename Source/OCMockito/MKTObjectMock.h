//
//  OCMockito - MKTObjectMock.h
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTBaseMockObject.h"

@class MKTMockSettings;


/**
    Mock object of a given class.
 */
@interface MKTObjectMock : MKTBaseMockObject

+ (id)mockForClass:(Class)aClass;
- (id)initWithClass:(Class)aClass settings:(MKTMockSettings *)settings;
+ (id)mockForClass:(Class)aClass withSettings:(MKTMockSettings *)settings;

@end
