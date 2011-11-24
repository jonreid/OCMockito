//
//  OCMockito - MTOngoingStubbing.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MTPrimitiveArgumentMatching.h"

@class MTInvocationContainer;


/**
    Methods to invoke on @c given(methodCall) to stub return values.
 */
@interface MTOngoingStubbing : NSObject <MTPrimitiveArgumentMatching>

- (id)initWithInvocationContainer:(MTInvocationContainer *)anInvocationContainer;

/// Stubs given object as return value.
- (MTOngoingStubbing *)willReturn:(id)object;

/// Stubs given @c BOOL as return value.
- (MTOngoingStubbing *)willReturnBool:(BOOL)value;

/// Stubs given @c char as return value.
- (MTOngoingStubbing *)willReturnChar:(char)value;

/// Stubs given @c int as return value.
- (MTOngoingStubbing *)willReturnInt:(int)value;

/// Stubs given @c short as return value.
- (MTOngoingStubbing *)willReturnShort:(short)value;

/// Stubs given @c long as return value.
- (MTOngoingStubbing *)willReturnLong:(long)value;

/// Stubs given <code>long long</code> as return value.
- (MTOngoingStubbing *)willReturnLongLong:(long long)value;

/// Stubs given @c NSInteger as return value.
- (MTOngoingStubbing *)willReturnInteger:(NSInteger)value;

/// Stubs given <code>unsigned char</code> as return value.
- (MTOngoingStubbing *)willReturnUnsignedChar:(unsigned char)value;

/// Stubs given <code>unsigned int</code> as return value.
- (MTOngoingStubbing *)willReturnUnsignedInt:(unsigned int)value;

/// Stubs given <code>unsigned short</code> as return value.
- (MTOngoingStubbing *)willReturnUnsignedShort:(unsigned short)value;

/// Stubs given <code>unsigned long</code> as return value.
- (MTOngoingStubbing *)willReturnUnsignedLong:(unsigned long)value;

/// Stubs given <code>unsigned long long</code> as return value.
- (MTOngoingStubbing *)willReturnUnsignedLongLong:(unsigned long long)value;

/// Stubs given @c NSUInteger as return value.
- (MTOngoingStubbing *)willReturnUnsignedInteger:(NSUInteger)value;

/// Stubs given @c float as return value.
- (MTOngoingStubbing *)willReturnFloat:(float)value;

/// Stubs given @c double as return value.
- (MTOngoingStubbing *)willReturnDouble:(double)value;

@end
