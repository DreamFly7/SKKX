//
//  HttpManage.m
//  晟开快线(业务员版)
//
//  Created by 胡隆海 on 17/1/9.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "HttpManage.h"
#import "BaseBusiness.h"
#import "Imports.h"

@implementation HttpManage

+(id)shareInstance{
    
    static HttpManage *manage = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manage = [[self alloc] init];
    });
    
    return manage;
}

// 当前版本
-(void)postVersionWithParmaeters:(NSMutableDictionary*)dic Success:(void(^)(NSMutableDictionary * dic))block{
    [[BaseBusiness sharedInstance] requestPostDataWithAPI:RequestVersion params:dic callBack:^(BOOL success, NSMutableDictionary *json) {
        block(json);
    }];
}

// 注册
-(void)postRegisterwithParmaeters:(NSMutableDictionary*)dic Success:(void(^)(NSMutableDictionary * dic))block{
    [[BaseBusiness sharedInstance] requestPostDataWithAPI:RequestRegister params:dic callBack:^(BOOL success, NSMutableDictionary *json) {
        block(json);
    }];
}


@end
