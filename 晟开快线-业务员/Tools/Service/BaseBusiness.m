//
//  BaseBusiness.m
//  晟开快线(业务员版)
//
//  Created by 胡隆海 on 17/1/9.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "BaseBusiness.h"
#import "BaseService.h"
#import "AFNetworking.h"
#import "Imports.h"

@implementation BaseBusiness

// 单例
+(instancetype)sharedInstance{
    
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

// POST
-(void)requestPostDataWithAPI:(NSString*)api params:(NSMutableDictionary*)params callBack:(void(^)(BOOL success, NSMutableDictionary * json))callBack{
    
    NSString * url = [NSString stringWithFormat:@"%@%@", RequestURL, api];
    
    NSLog(@"url = %@", url);
    
    [[BaseService sharedInstance] postDataWithURL:url params:params callBack:^(BOOL success, NSMutableDictionary *json) {
        
        callBack(success, json);
    }];
}

//GET
-(void)requestGetDataWithWithAPI:(NSString*)api params:(NSMutableDictionary*)params callBack:(void(^)(BOOL success, NSMutableDictionary * json))callBack{
    
    NSString * url = [NSString stringWithFormat:@"%@%@", RequestURL, api];
    
    NSLog(@"%@", url);
    
    [[BaseService sharedInstance] getDataWithURL:url params:params callBack:^(BOOL success, NSMutableDictionary *json) {
        
        callBack(success, json);
        
    }];
}

@end
