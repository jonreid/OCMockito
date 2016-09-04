//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Igor Sales

#import <Foundation/Foundation.h>

@class MKTClassObjectMock;


extern NSMutableDictionary *MKTSingletonMap;
NSString *mkt_singletonKey(Class aClass, SEL aSelector);


@interface MKTSingletonMapEntry : NSObject
{
@public
    __weak MKTClassObjectMock *_mock;
}

@property (nonatomic, weak, readonly) MKTClassObjectMock *mock;
@property (nonatomic, weak, readonly) Class mockedClass;
@property (nonatomic, assign, readonly) IMP oldIMP;
@property (nonatomic, assign, readonly) SEL selector;

@end


@interface MKTSwizzler : NSObject

@property (nonatomic, weak) MKTClassObjectMock *classMock;
- (void)swizzleSingletonAtSelector:(SEL)singletonSelector;
- (void)unswizzleSingletonsForMock;
- (void)unswizzleSingletonFromEntry:(MKTSingletonMapEntry *)swizzle;
@end
