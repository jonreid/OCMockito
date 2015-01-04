//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTReturns.h"


@interface MKTReturns ()
@property (readonly, nonatomic, strong) id value;
@end

@implementation MKTReturns

- (instancetype)initWithAnswer:(id)answer
{
    self = [super init];
    if (self)
        _value = answer;
    return self;
}

- (id)answer
{
    return self.value;
}

@end
