//
//  NSMutableDictionary+Plus.m
//
//  Created by Cp.Li on 15/5/29.
//  Copyright (c) 2015年 Cp.Li All rights reserved.
//

#import "NSMutableDictionary+Plus.h"

@implementation NSMutableDictionary (Plus)

-(NSString *)jsonToString:(NSMutableDictionary*)json{
    
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];;
}

@end
