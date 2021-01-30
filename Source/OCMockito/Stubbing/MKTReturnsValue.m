//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

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

- (nullable id)answerInvocation:(NSInvocation *)invocation
{
    return self.value;
}

@end
