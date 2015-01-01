//
//  MKTExpectation.h
//  OCMockito
//
//  Created by Tobias Kräntzer on 08.10.14.
//  Copyright (c) 2014 Jonathan M. Reid. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MKTExpectation <NSObject>
- (void)fulfill;
@end
