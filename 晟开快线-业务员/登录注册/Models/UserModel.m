//
//  UserModel.m
//  晟开快线(业务员版)
//
//  Created by 胡隆海 on 17/1/9.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "UserModel.h"
#import "DefineTools.h"
#import "DefineService.h"

static UserModel *singletonUser = nil;

@implementation UserModel


+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (!singletonUser) {
            singletonUser = [super allocWithZone:zone];
            return singletonUser;
        }
    }
    return nil;
}

#pragma mark - public methods.....
+ (id)sharedUser
{
    @synchronized (self){
        if (!singletonUser) {
            singletonUser = [[UserModel alloc] init];
            return singletonUser;
        }
    }
    return singletonUser;
}

- (id)init
{
    if (self = [super init]) {
        
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        NSLog(@"dateString:%@",dateString);
        
        _companyname        = [USER_DEFAULT objectForKey:@"corporateName"];
        _companyaddress     = [USER_DEFAULT objectForKey:@"companyAddress"];
        _companytel         = [USER_DEFAULT objectForKey:@"companyTelephone"];
        _userId             = [USER_DEFAULT objectForKey:@"id"];
        _userName           = [USER_DEFAULT objectForKey:@"name"];
        _cellphone          = [USER_DEFAULT objectForKey:@"telephone"];
        _password           = [USER_DEFAULT objectForKey:@"password"];
        _vipid              = [USER_DEFAULT objectForKey:@"privilege"];
        _station            = [USER_DEFAULT objectForKey:@"dot"];
        
    }
    return self;
}

- (BOOL)saveToLocal{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    
    [USER_DEFAULT setObject:_companyname    forKey:@"corporateName"];
    [USER_DEFAULT setObject:_companyaddress forKey:@"companyAddress"];
    [USER_DEFAULT setObject:_companytel     forKey:@"companyTelephone"];
    [USER_DEFAULT setObject:_userId         forKey:@"id"];
    [USER_DEFAULT setObject:_userName       forKey:@"name"];
    [USER_DEFAULT setObject:_cellphone      forKey:@"telephone"];
    [USER_DEFAULT setObject:_password       forKey:@"password"];
    [USER_DEFAULT setObject:_vipid          forKey:@"privilege"];
    [USER_DEFAULT setObject:_station        forKey:@"dot"];

    [USER_DEFAULT synchronize];
    
    return YES;
}


- (BOOL)clearUserInfo{
    
    [USER_DEFAULT setObject:@"" forKey:@"corporateName"];
    [USER_DEFAULT setObject:@"" forKey:@"companyAddress"];
    [USER_DEFAULT setObject:@"" forKey:@"companyTelephone"];
    [USER_DEFAULT setObject:@"" forKey:@"id"];
    [USER_DEFAULT setObject:@"" forKey:@"name"];
    [USER_DEFAULT setObject:@"" forKey:@"telephone"];
    [USER_DEFAULT setObject:@"" forKey:@"password"];
    [USER_DEFAULT setObject:@"" forKey:@"privilege"];
    [USER_DEFAULT setObject:@"" forKey:@"dot"];

    [USER_DEFAULT synchronize];
    
    return YES;
}


@end
