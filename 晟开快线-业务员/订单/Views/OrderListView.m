//
//  OrderListView.m
//  晟开快线-业务员
//
//  Created by 胡隆海 on 17/11/16.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "OrderListView.h"

@implementation OrderListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createWebView];
        // 获取通知中心单例对象
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        // 添加当前类对象为一个观察者，接收来自用户中心切换版本时候的通知
        [center addObserver:self selector:@selector(changeUpWebHeight) name:@"pushUp" object:nil];  // WEB加长
        [center addObserver:self selector:@selector(changeDownWebHeight) name:@"pushDown" object:nil];  // WEB缩短
    }
    return self;
}

-(void)createWebView{
    _webView = [[WKWebView alloc] init];
    _webView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-(SCREEN_W/5*2+64));
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.navigationDelegate = self;
    NSString * path = [[NSString alloc] init];
    path = [NSString stringWithFormat:@"http://skit-hz.com/book/SKKX/do.html"];
    
    NSURL * url = [[NSURL alloc] initWithString:path];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addSubview:_webView];
    [MBProgressHUD showMessage:@"正在加载数据中....."];
}

- (void)changeUpWebHeight {
    _webView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-64-50);
}

- (void)changeDownWebHeight {
    _webView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-(SCREEN_W/5*2+64));
}

#pragma mark- Delegate Webview
//1.准备加载页面
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"6准备加载页面");
}
//2.内容开始加载(view的过渡动画可在此方法中加载)
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"6内容开始加载");
}
//3.页面加载完成(view的过渡动画的移除可在此方法中进行)
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"6页面加载完成");
    // 移除HUD
    [MBProgressHUD hideHUD];
}
//4.页面加载失败
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"6页面加载失败");
    // 提醒有没有新数据
    [MBProgressHUD showError:@"加载失败"];
}



@end
