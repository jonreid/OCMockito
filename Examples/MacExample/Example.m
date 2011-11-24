#import <SenTestingKit/SenTestingKit.h>

//#define HC_SHORTHAND
//#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

@interface Example : SenTestCase
@end

@implementation Example

- (void)testExample
{
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
//    [mockArray removeAllObjects];
    
    [verify(mockArray) removeAllObjects];
}

@end
