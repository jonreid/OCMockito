#import <Foundation/Foundation.h>


@interface MKTArgumentGetter : NSObject

@property (nonatomic, strong) MKTArgumentGetter *successor;

- (instancetype)initWithType:(char const *)handlerType;
- (id)retrieveArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation;

@end
