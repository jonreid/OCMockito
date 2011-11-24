#import <SenTestingKit/SenTestingKit.h>

//#define HC_SHORTHAND
//#import <OCHamcrestIOS/OCHamcrestIOS.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>

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
