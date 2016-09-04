//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt
//  Contribution by David Hart

#import "MKTBaseMockObject.h"


/*!
 * @abstract Mock object of a given class object.
 */
@interface MKTClassObjectMock : MKTBaseMockObject

@property (nonatomic, strong, readonly) Class mockedClass;

+ (id)mockSingleton;

- (instancetype)initWithClass:(Class)aClass;

- (void)swizzleSingletonAtSelector:(SEL)singletonSelector;
- (void)unswizzleSingletonAtSelector:(SEL)singletonSelector;

@end
