//
//  Define.h
//  晟开快线(业务员版)
//
//  Created by 胡隆海 on 17/1/9.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#ifndef Define_h
#define Define_h

//用户类型参数
#define Company                       0
#define RepairShop                    1
#define CarOwners                     2

//晟开快线服务器
#define RequestURL                  @"http://123.206.24.66:9999/skitchina3-1.0-SNAPSHOT"

//加密的key
#define AESKey                      @"/client/getKey"

//版本号
#define RequestVersion              @"/version/checkAppVersion"
//注册
#define RequestRegister             @"/user/addUser"
//登录
#define RequestLogin                @"/user/userLogin"

#endif /* Define_h */
