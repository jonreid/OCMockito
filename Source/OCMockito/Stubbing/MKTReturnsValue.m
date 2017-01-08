//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "MKTReturnsValue.h"


@interface MKTReturnsValue ()
@property (nullable, nonatomic, strong, readonly) id value;
@end

@implementation MKTReturnsValue

- (instancetype)initWithValue:(nullable id)value
{
    self = [super init];
    if (self)
        _value = value;
    return self;
}

- (id)answerInvocation:(NSInvocation *)invocation
{
    return self.value;
}

@end
