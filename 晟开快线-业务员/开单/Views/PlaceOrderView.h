//
//  PlaceOrderView.h
//  晟开快线-业务员
//
//  Created by 胡隆海 on 17/11/16.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface PlaceOrderView : UIView<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView * webView;
@end
