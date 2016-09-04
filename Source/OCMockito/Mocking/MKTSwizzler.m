//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Igor Sales

#import "MKTSwizzler.h"

#import "MKTClassObjectMock.h"


NSMutableDictionary *singletonMap = nil;

NSString *singletonKey(Class aClass, SEL aSelector)
{
    return [NSString stringWithFormat:@"%@-%@", aClass, NSStringFromSelector(aSelector)];
}


@interface MKTClassObjectMockMapEntry2 : NSObject
{
@public
    __weak MKTClassObjectMock *_mock;
}

@property (nonatomic, weak, readonly) MKTClassObjectMock *mock;
@property (nonatomic, weak, readonly) Class mockedClass;
@property (nonatomic, assign, readonly) IMP oldIMP;
@property (nonatomic, assign, readonly) SEL selector;

@end

@implementation MKTClassObjectMockMapEntry2

- (instancetype)initWithMock:(MKTClassObjectMock *)mock IMP:(IMP)oldIMP selector:(SEL)selector
{
    self = [super init];
    if (self)
    {
        _mock = mock;
        _mockedClass = mock.mockedClass;
        _oldIMP = oldIMP;
        _selector = selector;
    }
    return self;
}

@end


@implementation MKTSwizzler

+ (void)initialize
{
    if (!singletonMap)
        singletonMap = [[NSMutableDictionary alloc] init];
}

@end
