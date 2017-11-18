//
//  PlaceOrderView.m
//  晟开快线-业务员
//
//  Created by 胡隆海 on 17/11/16.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "PlaceOrderView.h"

@implementation PlaceOrderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createWebView];
    }
    return self;
}

-(void)createWebView{
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_W, SCREEN_H-(SCREEN_W/5*2+64))];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.navigationDelegate = self;
    NSString * path = [[NSString alloc] init];
    path = [NSString stringWithFormat:@"http://skit-hz.com/book/SKKX/order.html"];
    
    NSURL * url = [[NSURL alloc] initWithString:path];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    //    _webView.dataDetectorTypes = UIDataDetectorTypeNone; //隐藏链接下划线
    _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addSubview:_webView];
    
}

#pragma mark- Delegate Webview
//1.准备加载页面
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"2准备加载页面");
}
//2.内容开始加载(view的过渡动画可在此方法中加载)
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"2内容开始加载");
}
//3.页面加载完成(view的过渡动画的移除可在此方法中进行)
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"2页面加载完成");
}
//4.页面加载失败
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"2页面加载失败");
}

@end
