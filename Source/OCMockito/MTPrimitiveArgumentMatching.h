//
//  OCMockito - MTPrimitiveArgumentMatching.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

@protocol HCMatcher;


@protocol MTPrimitiveArgumentMatching

- (id)withMatcher:(id <HCMatcher>)matcher forArgument:(NSUInteger)index;
- (id)withMatcher:(id <HCMatcher>)matcher;

@end
