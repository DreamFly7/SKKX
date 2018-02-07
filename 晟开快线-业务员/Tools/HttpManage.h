//
//  HttpManage.h
//  晟开快线(业务员版)
//
//  Created by 胡隆海 on 17/1/9.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpManage : NSObject

+(id)shareInstance;

// 发货
-(void)postLoadingUrlWithParmaeters:(NSMutableDictionary*)dic Success:(void(^)(NSMutableDictionary * dic))block;
// 收货
-(void)postArriveUrlWithParmaeters:(NSMutableDictionary*)dic  Success:(void(^)(NSMutableDictionary * dic))block;
// 交账
-(void)postAccountUrlWithParmaeters:(NSMutableDictionary*)dic Success:(void(^)(NSMutableDictionary * dic))block;
// 代收
-(void)postEnquiriesUrlWithParmaeters:(NSMutableDictionary*)dic Success:(void(^)(NSMutableDictionary * dic))block;

@end
