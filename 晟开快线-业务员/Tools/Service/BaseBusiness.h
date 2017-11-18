//
//  BaseBusiness.h
//  晟开快线(业务员版)
//
//  Created by 胡隆海 on 17/1/9.
//  Copyright © 2017年 胡隆海. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface BaseBusiness : NSObject

+(instancetype)sharedInstance;

-(void)requestPostDataWithAPI:(NSString*)api params:(NSMutableDictionary*)params callBack:(void(^)(BOOL success, NSMutableDictionary * json))callBack;

-(void)requestGetDataWithWithAPI:(NSString*)api params:(NSMutableDictionary*)params callBack:(void(^)(BOOL success, NSMutableDictionary * json))callBack;

@end
