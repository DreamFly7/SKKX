//
//  NSString+Plus.h
//
//  Created by Cp.Li on 15/4/23.
//  Copyright (c) 2015年 Cp.Li All rights reserved.
//

#import <Foundation/Foundation.h>

@class UILabel;
@class UIFont;

@interface NSString (Plus)

-(NSString*)trim;
+(NSString *)trim:(NSString *)str;

/**
 Start with specific string
 */
-(BOOL)startWith:(NSString*)string;
/**
 End with specific string
 */
-(BOOL)endWith:(NSString*)string;

-(BOOL)isChinese;

//大小写转换
-(NSString *)toLowercaseString;
-(NSString *)toUppercaseString;
-(NSString *)toCapitalizedString;

+(BOOL)isNull:(NSString *)str_;

//md5加密
-(NSString*)md5;


-(id)jsonDict;

//获取图片路径用的  将imageURL中####替换成需要的size （small , middle, thumb, original）
-(NSString *)getImgWithSize:(NSString*)size;

@end
