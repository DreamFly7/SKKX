//
//  ArriveListView.m
//  晟开快线-业务员
//
//  Created by 胡隆海 on 17/11/16.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "ArriveListView.h"

@implementation ArriveListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createWebView];
        // 获取通知中心单例对象
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        // 添加当前类对象为一个观察者，接收来自Main上拉下拉的通知
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
    path = [NSString stringWithFormat:@"http://123.206.24.66:8888/formal/now_pay.html"];
    
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
    NSLog(@"8准备加载页面");
}
//2.内容开始加载(view的过渡动画可在此方法中加载)
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"8内容开始加载");
}
//3.页面加载完成(view的过渡动画的移除可在此方法中进行)
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"8页面加载完成");
    // 移除HUD
    [MBProgressHUD hideHUD];
}
//4.页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"7页面加载失败");
    // 移除HUD
    [MBProgressHUD hideHUD];
    // 提醒有没有新数据
    [MBProgressHUD showError:@"加载失败，请检查网络连接"];
    UIButton * refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshButton.frame = CGRectMake(SCREEN_W/3, SCREEN_H*0.5, SCREEN_W/3, 40);
    refreshButton.layer.masksToBounds = YES;
    refreshButton.layer.cornerRadius = 20;
    refreshButton.backgroundColor = RGBCOLOR(188, 188, 188);
    [refreshButton setTitle:@"重新加载" forState:UIControlStateNormal];
    [refreshButton setTitleColor:ColorFontBlack forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refreshEvent) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:refreshButton aboveSubview:_webView];
}

- (void)refreshEvent {
    NSLog(@"刷新界面");
    NSDictionary * dict = @{@"functionNum":@"7"};
    //创建一个消息对象 在MainVC接收并再次请求数据
    NSNotification * notice = [NSNotification notificationWithName:@"refreshNotice" object:nil userInfo:dict];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}


@end
