//
//  NSString+Plus.m
//
//  Created by Cp.Li on 15/4/23.
//  Copyright (c) 2015年 Cp.Li All rights reserved.
//

#import "NSString+Plus.h"

#import "Imports.h"

#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

static inline BOOL isempty(id thing) {
    return thing == nil
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0)
    || [thing isKindOfClass:[NSNull class]];
}

@implementation NSString (Plus)


+(NSString *)trim:(NSString *)str{
    
    if ([NSString isNull:str]) {
        return nil;
    }
    
    NSString *trimmedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([NSString isNull:trimmedString]) {
        return nil;
    }else {
        return trimmedString;
    }
    
}

-(NSString *)getImgWithSize:(NSString*)size{
    
   return [self stringByReplacingOccurrencesOfString:@"####" withString:size];
}


//去掉首尾空格
-(NSString *)trim{
    
    if ([NSString isNull:self]) {
        return Nil;
    }
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//以。。。开始
-(BOOL)startWith:(NSString*)string{
    
    NSRange range = [self rangeOfString:string];
    if (range.length >0 && range.location == 0) {
        return YES;
    }
    else {
        return NO;
    }
}

//以。。。结束
-(BOOL)endWith:(NSString*)string{
    
    NSRange range = [self rangeOfString:string options:NSBackwardsSearch];
    if (range.length >0 && ((range.length+range.location) ==self.length) ) {
        return YES;
    }
    else {
        return NO;
    }
    
}

//是否是中文
-(BOOL)isChinese{
    return ![self canBeConvertedToEncoding: NSASCIIStringEncoding];
}

//转成小写
-(NSString *)toLowercaseString{
    if ([NSString isNotNull:self]) {
        return [self lowercaseString];
    }else{
        return Nil;
    }
}

//转成大写
-(NSString *)toUppercaseString{
    if ([NSString isNotNull:self]) {
        return [self uppercaseString];
    }else{
        return Nil;
    }
}

-(NSString *)toCapitalizedString{
    if ([NSString isNotNull:self]) {
        return [self capitalizedString];
    }else{
        return Nil;
    }
}



+(BOOL)isNull:(NSString *)str_{
    return isempty(str_);
}

+(BOOL)isNotNull:(NSString *)string{
    return ![NSString isNull:string];
}



/**
 * Mutable JSON
 */
-(id)jsonDict{
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    
    NSMutableDictionary * result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (error != nil) return nil;
    [result se_removeNulls];
    return result;
}

-(NSString*)md5{
    
    const char * cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    // This is the md5 call
    return[NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",        result[0], result[1], result[2], result[3],         result[4], result[5], result[6], result[7],        result[8], result[9], result[10], result[11],        result[12], result[13], result[14], result[15]];
}


@end
