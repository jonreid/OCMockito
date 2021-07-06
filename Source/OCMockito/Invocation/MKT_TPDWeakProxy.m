// The MIT License (MIT)
//
// Copyright © 2013 Tetherpad
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "MKT_TPDWeakProxy.h"

@interface MKT_TPDWeakProxy ()

@property (nonatomic, weak) id theObject;

@end

@implementation MKT_TPDWeakProxy

- (instancetype)initWithObject:(id)object {
    // No init method in superclass
    self.theObject = object;
    return self;
}

// First, try to use the fast forwarding path. If theObject is nil
// the Objective C runtime will fall back to the older, slow path. This
// speeds up message forwarding performance a lot from tests; it's nearly
// as fast as directly messaging the object. If we return nil (ie, theObject
// has become dereferenced or was nil to begin with), the Objective C runtime
// falls back to the slow forwarding path.
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.theObject;
}

// First step of the slow forwarding path is to figure out the method signature.
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature;
    // Keep a strong reference so we can safely send messages
    id object = self.theObject;
    if (object) {
        methodSignature = [object methodSignatureForSelector:aSelector];
    } else {
        // If obj is nil, we need to synthesize a NSMethodSignature. Smallest signature
        // is (self, _cmd) according to the documention for NSMethodSignature.
        NSString *types = [NSString stringWithFormat:@"%s%s", @encode(id), @encode(SEL)];
        methodSignature = [NSMethodSignature signatureWithObjCTypes:[types UTF8String]];
    }
    return methodSignature;
}

// The runtime uses the method signature from above to create an NSInvocation and asks us to
// forward it along as we see fit.
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.theObject];
}

@end
