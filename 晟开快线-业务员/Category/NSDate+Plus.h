//
//  NSDate+Plus.h
//  KaMiao
//
//  Created by Mac on 15/10/20.
//  Copyright (c) 2015年 Cp.Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Plus)
-(NSString *)formatDate:(NSString *)dateFormat;
-(NSString *)toDateStringByFormat:(NSString *)dateFormat;
@end
