//
//  OCMockito - MTOngoingStubbing.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MTPrimitiveArgumentMatching.h"

@class MTInvocationContainer;


@interface MTOngoingStubbing : NSObject <MTPrimitiveArgumentMatching>

- (id)initWithInvocationContainer:(MTInvocationContainer *)anInvocationContainer;
- (MTOngoingStubbing *)willReturn:(id)object;
- (MTOngoingStubbing *)willReturnBool:(BOOL)value;
- (MTOngoingStubbing *)willReturnChar:(char)value;
- (MTOngoingStubbing *)willReturnInt:(int)value;
- (MTOngoingStubbing *)willReturnShort:(short)value;
- (MTOngoingStubbing *)willReturnLong:(long)value;
- (MTOngoingStubbing *)willReturnLongLong:(long long)value;
- (MTOngoingStubbing *)willReturnInteger:(NSInteger)value;
- (MTOngoingStubbing *)willReturnUnsignedChar:(unsigned char)value;
- (MTOngoingStubbing *)willReturnUnsignedInt:(unsigned int)value;
- (MTOngoingStubbing *)willReturnUnsignedShort:(unsigned short)value;
- (MTOngoingStubbing *)willReturnUnsignedLong:(unsigned long)value;
- (MTOngoingStubbing *)willReturnUnsignedLongLong:(unsigned long long)value;
- (MTOngoingStubbing *)willReturnUnsignedInteger:(NSUInteger)value;

@end
