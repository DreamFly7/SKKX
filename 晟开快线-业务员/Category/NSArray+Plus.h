//
//  NSArray+Plus.h
//  PayFeeSystem
//
//  Created by Mac on 15/7/15.
//  Copyright (c) 2015年 Cp.Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Plus)

- (void)loop:(void (^)(id obj))block;
@end
