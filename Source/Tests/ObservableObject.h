//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Ceri Hughes

#import <Foundation/Foundation.h>

@protocol ObjectObserver <NSObject>
@end

@interface ObservableObject : NSObject
- (void)addObserver:(id <ObjectObserver>)observer;
- (void)removeObserver:(id <ObjectObserver>)observer;
@end
