//
//  FunctionView.h
//  晟开快线-业务员
//
//  Created by 胡隆海 on 17/11/16.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionView : UIView
// 第一步定义, Block作为property属性
/*
 void: Block的返回值为空，即无返回值；
 functionBlock: Block的作为对象属性时的属性名；
 (NSString * str): Block的参数是NSString实例对象
 */
@property (nonatomic, strong) void(^functionBlock)(NSUInteger functionNum);

@property (nonatomic, strong) void(^pushBlock)();

@end
