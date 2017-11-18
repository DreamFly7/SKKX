//
//  NSArray+Plus.m
//  PayFeeSystem
//
//  Created by Mac on 15/7/15.
//  Copyright (c) 2015年 Cp.Li. All rights reserved.
//

#import "NSArray+Plus.h"
#import "DefineTools.h"

@implementation NSArray (Plus)

- (void)loop:(void (^)(id obj))block{
    
    for(id obj in self)
        block(obj);
}




@end
