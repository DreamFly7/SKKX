//
//  NewPringViewController.h
//  晟开快线-业务员
//
//  Created by 胡隆海 on 18/1/22.
//  Copyright © 2018年 胡隆海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPringViewController : UIViewController

- (void)startPrint; // 打印订单

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


- (void)printCollectionEvent; // 打印代收凭证

@property (nonatomic, strong) NSString * idStr;     // 序列号
@property (nonatomic, strong) NSString * userName;  // 开单员
@property (nonatomic, strong) NSString * dateStr;   // 日期
@property (nonatomic, strong) NSString * bankName;  // 开户银行
@property (nonatomic, strong) NSString * bankUserName;  // 银行开户名
@property (nonatomic, strong) NSString * bankNumberStr; // 银行卡号
@property (nonatomic, strong) NSString * moneyStr2;      // 金额

@end
