//
//  DefineTools.h
//  晟开快线(业务员版)
//
//  Created by 胡隆海 on 17/1/9.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#ifndef DefineTools_h
#define DefineTools_h

#define USER_DEFAULT         [NSUserDefaults standardUserDefaults]
#define Key4VisitorLogin     @"Key4VisitorLogin"
#define AESKey               @"0000000000000000"

// 当前系统
#define hSystemVersion       [[[UIDevice currentDevice] systemVersion]floatValue]

// 屏幕宽、高
#define    SCREEN_W          [UIScreen mainScreen].bounds.size.width
#define    SCREEN_H          [UIScreen mainScreen].bounds.size.height
// 布局
#define UIViewWithFrame(x,y,w,h) [[UIView alloc] initWithFrame:CGRectMake((x), (y), (w), (h))];
#define UIImageViewWithFrame(x,y,w,h) [[UIImageView alloc] initWithFrame:CGRectMake((x), (y), (w), (h))]
#define UILabelWithFrame(x,y,w,h) [[UILabel alloc] initWithFrame:CGRectMake((x), (y), (w), (h))]

// 字体
#define hFontSize(size)                 [UIFont systemFontOfSize:size]
#define hBoldFontSize(size)             [UIFont boldSystemFontOfSize:size]

// RGB颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
// RGB颜色带透明度
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// 添加颜色
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ColorMain                  HEXCOLOR(0x008DFA)
#define ColorFontBlack             HEXCOLOR(0x393A3F)
#define ColorLine                  HEXCOLOR(0xCFCFCF)
#define ColorFontGray              HEXCOLOR(0x9C9B9F)
#define ColorFontGrayLittle        HEXCOLOR(0xBBBBBB)
#define ColorFontOrange            HEXCOLOR(0xFF6117)
#define ColorBackground            HEXCOLOR(0xEEF8FD)
#define ColorWhite                 [UIColor whiteColor]

// 判断字符串是否为空
#define NULL_STR(str) (str == nil || (NSNull *)str == [NSNull null] || str.length == 0)

// 添加事件
#define hAddEvent(OBJ,SELECTOR)  [OBJ addTarget:self action:@selector(SELECTOR) forControlEvents:UIControlEventTouchUpInside]

// 界面跳转
#define hPopViewController                 [self.navigationController popViewControllerAnimated:YES]
#define hPushViewController(vc)            [self.navigationController pushViewController:vc animated:YES]
// 模态推送
#define hPresentView(vc)                   [self presentViewController:vc animated:YES completion:nil];
// 模态返回上一层界面
#define hDismissView                       [self dismissViewControllerAnimated:YES completion:nil]

#define hSetBackButton(str) {\
self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:nil];\
[[UINavigationBar appearance] setTintColor:RGBCOLOR(42, 143, 240)];\
}\

// 手势
#define hAddGestureSingleTabWithParams(VIEW,METHOD,ISCancelsTouchesInView){\
VIEW.userInteractionEnabled = YES;\
UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(METHOD)];\
singleTap.cancelsTouchesInView = ISCancelsTouchesInView;\
[VIEW addGestureRecognizer:singleTap];\
}\

#define hAddGestureSingleTab(VIEW,METHOD){\
VIEW.userInteractionEnabled = YES;\
UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(METHOD)];\
singleTap.numberOfTapsRequired = 1;\
singleTap.numberOfTouchesRequired = 1;\
singleTap.cancelsTouchesInView = NO;\
[VIEW addGestureRecognizer:singleTap];\
}\

// Set Size
#define hSetHeight(view,h) {\
CGRect frame = view.frame;\
frame.size.height = h;\
view.frame = frame;\
}\

#define hSetWidth(view,w) {\
CGRect frame = view.frame;\
frame.size.width = w;\
view.frame = frame;\
}\

#define hSetX(view,xx) {\
CGRect frame = view.frame;\
frame.origin.x = xx;\
view.frame = frame;\
}\

#define hSetY(view,yy) {\
CGRect frame = view.frame;\
frame.origin.y = yy;\
view.frame = frame;\
}\

#define hSetRight(view,right){\
float w = view.frame.size.width;\
float x = right-w;\
CGRect frame = view.frame;\
frame.origin.x = x;\
view.frame = frame;\
}\

//边角弧度
#define hRadiusCornerWithParams(VIEW,RADIUS,BORDER_WIDTH,BORDER_COLOR) {\
CALayer *vLayer = [VIEW layer];\
[vLayer setMasksToBounds:YES];\
[vLayer setCornerRadius:RADIUS];\
[vLayer setBorderWidth:BORDER_WIDTH];\
[vLayer setBorderColor:[BORDER_COLOR CGColor]];\
}\

#define hRadiusCornerWithRadius(VIEW,RADIUS) {\
CALayer *vLayer = [VIEW layer];\
[vLayer setMasksToBounds:YES];\
[vLayer setCornerRadius:RADIUS];\
}\

#define instructionsStr @"1.托运人要如实申报货物名称，并对其真实性负责，本公司不承运国家规定的违禁品及危险品，如托运人假报货名或在货物内夹带国家法令禁运的物品，造成一切损失托运人自行承担且本公司有权追究法律责任。\n2.托运人的货物包装要符合行业标准和运输标准，对怕压、玻璃制品及易碎货物要钉木箱，方可运输，如不按规定包装而出现损坏情况，由托运人自行承担，本公司一律不给予赔偿。\n3.为避免货物破损情况后的异议，请在发货前把货物的内外包装处理好，如在客户收到货物前，外包装无损坏，本公司一律不给予赔偿。\n4.客户所运货物，不参加保价，如发生丢失问题,按照货物运费的3-10倍进行理赔。\n5.发货后请尽快与收货方确认到货，查货请于发货后72小时内。"

#define daishouStr @"注意事项：请仔细核对银行、卡号、开户名，有退货未提等，如有差错，在此收据开出之日40天内查询，逾期概不负责。\n查询电话：18968132297\n此单仅为客户查账使用，不作为打款依据，打款后不收回此订单。\n"

#endif /* DefineTools_h */
