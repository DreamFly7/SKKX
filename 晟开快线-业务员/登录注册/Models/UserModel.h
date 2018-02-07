//
//  UserModel.h
//  晟开快线(业务员版)
//
//  Created by 胡隆海 on 17/1/9.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, strong)NSString * companyname;   // 公司名称
@property (nonatomic, strong)NSString * companyaddress;// 公司地址
@property (nonatomic, strong)NSString * companytel;    // 公司电话
@property (nonatomic, strong)NSString * userId;        // 用户id
@property (nonatomic, strong)NSString * userName;      // 用户名
@property (nonatomic, strong)NSString * cellphone;     // 用户电话
@property (nonatomic, strong)NSString * password;      // 用户密码
@property (nonatomic, strong)NSString * vipid;         // 用户vip 0普通用户 1管理员 2超级管理员 3
@property (nonatomic, strong)NSString * station;       // 用户网点

+ (id)sharedUser;
- (BOOL)saveToLocal;
- (BOOL)clearUserInfo;
@end
