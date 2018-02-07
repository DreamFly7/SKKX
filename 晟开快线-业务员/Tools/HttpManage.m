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

// 发货
-(void)postLoadingUrlWithParmaeters:(NSMutableDictionary*)dic Success:(void(^)(NSMutableDictionary * dic))block {
    [[BaseBusiness sharedInstance] requestPostDataWithAPI:LoadingUrl params:dic callBack:^(BOOL success, NSMutableDictionary *json) {
        block(json);
    }];
}
// 收货
-(void)postArriveUrlWithParmaeters:(NSMutableDictionary*)dic Success:(void(^)(NSMutableDictionary * dic))block {
    [[BaseBusiness sharedInstance] requestPostDataWithAPI:ArriveUrl params:dic callBack:^(BOOL success, NSMutableDictionary *json) {
        block(json);
    }];
}
// 交账
-(void)postAccountUrlWithParmaeters:(NSMutableDictionary*)dic Success:(void(^)(NSMutableDictionary * dic))block {
    [[BaseBusiness sharedInstance] requestPostDataWithAPI:AccountUrl params:dic callBack:^(BOOL success, NSMutableDictionary *json) {
        block(json);
    }];
}

// 代收
-(void)postEnquiriesUrlWithParmaeters:(NSMutableDictionary*)dic Success:(void(^)(NSMutableDictionary * dic))block {
    [[BaseBusiness sharedInstance] requestPostDataWithAPI:Enquiries params:dic callBack:^(BOOL success, NSMutableDictionary *json) {
        block(json);
    }];
}


@end
