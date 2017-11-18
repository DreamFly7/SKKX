//
//  BaseService.m
//  晟开快线(业务员版)
//
//  Created by 胡隆海 on 17/1/9.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "BaseService.h"
#import "AFNetworking.h"

@implementation BaseService


+(instancetype)sharedInstance{
    
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


// POST请求
-(void)postDataWithURL:(NSString*)url params:(NSMutableDictionary*)params callBack:(void(^)(BOOL success, NSMutableDictionary * json))callBack{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callBack(YES, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"POST请求错误日志 ------------------ %@", error);
        callBack(NO, nil);
        
    }];
    
}


// GET请求
-(void)getDataWithURL:(NSString*)url params:(NSMutableDictionary*)params callBack:(void(^)(BOOL success, NSMutableDictionary * json))callBack{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callBack(YES, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"GET请求错误日志 ------------------ %@", error);
        callBack(NO, nil);
    }];
    
}


@end
