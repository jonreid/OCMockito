//
//  OCMockito - MKOngoingStubbing.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MKPrimitiveArgumentMatching.h"

@class MKTInvocationContainer;


/**
    Methods to invoke on @c given(methodCall) to return stubbed values.
 */
@interface MKOngoingStubbing : NSObject <MKPrimitiveArgumentMatching>

- (id)initWithInvocationContainer:(MKTInvocationContainer *)anInvocationContainer;

/// Stubs given object as return value.
- (MKOngoingStubbing *)willReturn:(id)object;

/// Stubs given @c BOOL as return value.
- (MKOngoingStubbing *)willReturnBool:(BOOL)value;

/// Stubs given @c char as return value.
- (MKOngoingStubbing *)willReturnChar:(char)value;

/// Stubs given @c int as return value.
- (MKOngoingStubbing *)willReturnInt:(int)value;

/// Stubs given @c short as return value.
- (MKOngoingStubbing *)willReturnShort:(short)value;

/// Stubs given @c long as return value.
- (MKOngoingStubbing *)willReturnLong:(long)value;

/// Stubs given <code>long long</code> as return value.
- (MKOngoingStubbing *)willReturnLongLong:(long long)value;

/// Stubs given @c NSInteger as return value.
- (MKOngoingStubbing *)willReturnInteger:(NSInteger)value;

/// Stubs given <code>unsigned char</code> as return value.
- (MKOngoingStubbing *)willReturnUnsignedChar:(unsigned char)value;

/// Stubs given <code>unsigned int</code> as return value.
- (MKOngoingStubbing *)willReturnUnsignedInt:(unsigned int)value;

/// Stubs given <code>unsigned short</code> as return value.
- (MKOngoingStubbing *)willReturnUnsignedShort:(unsigned short)value;

/// Stubs given <code>unsigned long</code> as return value.
- (MKOngoingStubbing *)willReturnUnsignedLong:(unsigned long)value;

/// Stubs given <code>unsigned long long</code> as return value.
- (MKOngoingStubbing *)willReturnUnsignedLongLong:(unsigned long long)value;

/// Stubs given @c NSUInteger as return value.
- (MKOngoingStubbing *)willReturnUnsignedInteger:(NSUInteger)value;

/// Stubs given @c float as return value.
- (MKOngoingStubbing *)willReturnFloat:(float)value;

/// Stubs given @c double as return value.
- (MKOngoingStubbing *)willReturnDouble:(double)value;

@end
