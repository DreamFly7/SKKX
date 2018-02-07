//
//  CollectionPrintViewController.h
//  晟开快线-业务员
//
//  Created by 胡隆海 on 18/1/5.
//  Copyright © 2018年 胡隆海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionPrintViewController : UIViewController
@property (nonatomic, strong) NSString * idStr;     // 序列号
@property (nonatomic, strong) NSString * userName;  // 开单员
@property (nonatomic, strong) NSString * dateStr;   // 日期
@property (nonatomic, strong) NSString * bankName;  // 开户银行
@property (nonatomic, strong) NSString * bankUserName;  // 银行开户名
@property (nonatomic, strong) NSString * bankNumberStr; // 银行卡号
@property (nonatomic, strong) NSString * moneyStr;      // 金额
@end
