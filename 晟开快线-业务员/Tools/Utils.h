//
//  Utils.h
//  晟开快线(业务员版)
//
//  Created by 胡隆海 on 17/1/9.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIAlertView;


@interface Utils : NSObject

+(instancetype)sharedInstance;
//时间差
+(NSString *)intervalSinceNow:(NSString*)theDate;
//判断是不是合法的手机号
+(BOOL)isValidMobileNumber:(NSString *)mobileNum;
//判断是不是合法的邮箱
+(BOOL)isValidEmail:(NSString *)email;
+(BOOL)isBlankString:(NSString *)string;

+(UIAlertView *)alertWithMessage:(NSString*)message;

+(NSURL *)obtainImageURLWithFilePath:(NSString *)file name:(NSString *)name;

+(void)countDownBySeconds:(int)seconds callback:(void(^)(BOOL isTimeout,NSInteger leftSeconds))callback;


+(NSString*)obtainUserID;
//+(NSString*)obtainStoreID;

+(NSString*)DataTOjsonString:(id)object;


///将以为数组转化为二维数组  array：一维数组    section: 二维数组中的子数组的个数
+(NSMutableArray*)toTowSectionArrayWithOneSectionArray:(NSMutableArray*)array withSection:(NSInteger)section;

+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
// 清除WKWebView缓存
+ (void)deleteWebCache;

@end
