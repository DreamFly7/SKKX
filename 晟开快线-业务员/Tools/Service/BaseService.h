//
//  BaseService.h
//  晟开快线(业务员版)
//
//  Created by 胡隆海 on 17/1/9.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseService : NSObject

+(instancetype)sharedInstance;

-(void)postDataWithURL:(NSString*)url params:(NSMutableDictionary*)params callBack:(void(^)(BOOL success, NSMutableDictionary * json))callBack;

-(void)getDataWithURL:(NSString*)url params:(NSMutableDictionary*)params callBack:(void(^)(BOOL success, NSMutableDictionary * json))callBack;

@end
