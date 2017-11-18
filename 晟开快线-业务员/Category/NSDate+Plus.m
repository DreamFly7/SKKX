//
//  NSDate+Plus.m
//  KaMiao
//
//  Created by Mac on 15/10/20.
//  Copyright (c) 2015年 Cp.Li. All rights reserved.
//

#import "NSDate+Plus.h"

@implementation NSDate (Plus)

/**
 *  formate NSDate to String
 *
 */
-(NSString *)formatDate:(NSString *)dateFormat{
    return [self toDateStringByFormat:dateFormat];
}


/**
 *  formate NSDate to String
 *
 */
-(NSString *)toDateStringByFormat:(NSString *)dateFormat{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:dateFormat];
    NSString *fixString = [dateFormatter stringFromDate:self];
    
    return fixString;
    
}


@end
