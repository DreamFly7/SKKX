//
//  InvoiceListView.h
//  晟开快线-业务员
//
//  Created by 胡隆海 on 17/11/16.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoiceListView : UIView<WKNavigationDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) WKWebView * webViewOne;
@property (nonatomic, strong) WKWebView * webViewTwo;
@property (nonatomic, strong) WKWebView * webViewThree;
@property WebViewJavascriptBridge * bridgeOne;
@property WebViewJavascriptBridge * bridgeTwo;
@end
