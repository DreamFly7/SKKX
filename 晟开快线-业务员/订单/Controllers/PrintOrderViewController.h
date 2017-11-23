//
//  PrintOrderViewController.h
//  晟开快线(业务员版)
//
//  Created by 胡隆海 on 17/2/21.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrintOrderViewController : UIViewController
@property (nonatomic, strong) NSString * orderNumberStr; // 单号
@property (nonatomic, strong) NSString * userNameStr;    // 制单人
@property (nonatomic, strong) NSString * timeStr;        // 日期
@property (nonatomic, strong) NSString * startCityStr;   // 出发地
@property (nonatomic, strong) NSString * endCityStr;     // 目的地
@property (nonatomic, strong) NSString * startCompanyStr;// 寄件公司
@property (nonatomic, strong) NSString * startIphoneStr; // 寄件电话
@property (nonatomic, strong) NSString * startAddressStr;// 寄件地址
@property (nonatomic, strong) NSString * endCompanyStr;  // 收件公司
@property (nonatomic, strong) NSString * endIphoneStr;   // 收件电话
@property (nonatomic, strong) NSString * endAddressStr;  // 收件地址
@property (nonatomic, strong) NSString * numberStr;      // 件数
@property (nonatomic, strong) NSString * freightStr;     // 运费
@property (nonatomic, strong) NSString * moneyStr;       // 代收
@property (nonatomic, strong) NSString * moneySumStr;    // 合计
@property (nonatomic, strong) NSString * payWayStr;      // 支付方式
@property (nonatomic, strong) NSString * noteStr;        // 备注
@property (nonatomic, strong) NSString * randomStr;      // 验证码
@end
