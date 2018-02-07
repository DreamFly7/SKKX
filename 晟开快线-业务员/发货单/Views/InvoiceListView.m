//
//  InvoiceListView.m
//  晟开快线-业务员
//
//  Created by 胡隆海 on 17/11/16.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "InvoiceListView.h"

@implementation InvoiceListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createScrollView];
        [self createWebView];
        [self createWebViewJavascriptBridgeOne];
        [self createWebViewJavascriptBridgeTwo];
        // 获取通知中心单例对象
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        // 添加当前类对象为一个观察者，接收来自Main上拉下拉的通知
        [center addObserver:self selector:@selector(changeUpWebHeight) name:@"pushUp" object:nil];  // WEB加长
        [center addObserver:self selector:@selector(changeDownWebHeight) name:@"pushDown" object:nil];  // WEB缩短
    }
    return self;
}

- (void)createScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, self.height)];
    _scrollView.contentSize = CGSizeMake(SCREEN_W*3, self.height);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
}

-(void)createWebView{
    _webViewOne = [[WKWebView alloc] init];
    _webViewOne.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-(SCREEN_W/5*2+64));
    _webViewOne.backgroundColor = [UIColor whiteColor];
    _webViewOne.navigationDelegate = self;
    // 滑动返回
    _webViewOne.allowsBackForwardNavigationGestures = YES;
    _webViewOne.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_scrollView addSubview:_webViewOne];
    
    _webViewTwo = [[WKWebView alloc] init];
    _webViewTwo.frame = CGRectMake(SCREEN_W, 0, SCREEN_W, SCREEN_H-(SCREEN_W/5*2+64));
    _webViewTwo.backgroundColor = [UIColor whiteColor];
    _webViewTwo.navigationDelegate = self;
    _webViewTwo.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_scrollView addSubview:_webViewTwo];
    
    _webViewThree = [[WKWebView alloc] init];
    _webViewThree.frame = CGRectMake(SCREEN_W*2, 0, SCREEN_W, SCREEN_H-(SCREEN_W/5*2+64));
    _webViewThree.backgroundColor = [UIColor whiteColor];
    _webViewThree.navigationDelegate = self;
    _webViewThree.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_scrollView addSubview:_webViewThree];
    
    [MBProgressHUD showMessage:@"正在加载数据中....."];
}

- (void)changeUpWebHeight {
    _webViewOne.frame   = CGRectMake(0, 0, SCREEN_W, SCREEN_H-64-50);
    _webViewTwo.frame   = CGRectMake(SCREEN_W, 0, SCREEN_W, SCREEN_H-64-50);
    _webViewThree.frame = CGRectMake(SCREEN_W*2, 0, SCREEN_W, SCREEN_H-64-50);
}

- (void)changeDownWebHeight {
    _webViewOne.frame   = CGRectMake(0, 0, SCREEN_W, SCREEN_H-(SCREEN_W/5*2+64));
    _webViewTwo.frame   = CGRectMake(SCREEN_W, 0, SCREEN_W, SCREEN_H-(SCREEN_W/5*2+64));
    _webViewThree.frame = CGRectMake(SCREEN_W*2, 0, SCREEN_W, SCREEN_H-(SCREEN_W/5*2+64));
}

#pragma mark -- Delegate Webview
//1.准备加载页面
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"1准备加载页面");
}
//2.内容开始加载(view的过渡动画可在此方法中加载)
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"1内容开始加载");
}
//3.页面加载完成(view的过渡动画的移除可在此方法中进行)
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"1页面加载完成");
    // 移除HUD
    [MBProgressHUD hideHUD];
}
//4.页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"1页面加载失败");
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
    [self insertSubview:refreshButton aboveSubview:_webViewOne];
}

- (void)refreshEvent {
    NSLog(@"刷新界面");
    NSDictionary * dict = @{@"functionNum":@"6"};
    //创建一个消息对象 在MainVC接收并再次请求数据
    NSNotification * notice = [NSNotification notificationWithName:@"refreshNotice" object:nil userInfo:dict];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}

#pragma mark -- Delegate ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"滚动偏移量：%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat currentPostionX = scrollView.contentOffset.x;
    if (currentPostionX == 0) {
        NSDictionary * dict = @{@"currentPostionX":@"0"};
        //创建一个消息对象 在MainVC接收并改变发货单的字符
        NSNotification * notice = [NSNotification notificationWithName:@"fahuodan" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notice];
    } else if (currentPostionX == SCREEN_W) {
        NSDictionary * dict = @{@"currentPostionX":@"375"};
        //创建一个消息对象 在MainVC接收并改变发货单的字符
        NSNotification * notice = [NSNotification notificationWithName:@"fahuodan" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notice];
    } else if (currentPostionX == SCREEN_W*2) {
        NSDictionary * dict = @{@"currentPostionX":@"750"};
        //创建一个消息对象 在MainVC接收并改变发货单的字符
        NSNotification * notice = [NSNotification notificationWithName:@"fahuodan" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notice];
    }
}

#pragma mark -- createWebViewJavascriptBridge

- (void)createWebViewJavascriptBridgeOne {
    //初始化  WebViewJavascriptBridge
    if (_bridgeOne) { return; }
    [WebViewJavascriptBridge enableLogging];
    
    _bridgeOne = [WebViewJavascriptBridge bridgeForWebView:_webViewOne];
    [_bridgeOne setWebViewDelegate:self];
    
    //请求加载html，注意：这里h5加载完，会自动执行一个调用oc的方法
    [self loadExamplePageOne:_webViewOne];
    [self loadExamplePageTwo:_webViewTwo];
    [self loadExamplePageThree:_webViewThree];
    
    //申明js调用oc方法的处理事件，这里写了后，h5那边只要请求了，oc内部就会响应
    [self JS2OCOne];
}

- (void)createWebViewJavascriptBridgeTwo {
    //初始化  WebViewJavascriptBridge
    if (_bridgeTwo) { return; }
    [WebViewJavascriptBridge enableLogging];
    
    _bridgeTwo = [WebViewJavascriptBridge bridgeForWebView:_webViewTwo];
    [_bridgeTwo setWebViewDelegate:self];
    
    //申明js调用oc方法的处理事件，这里写了后，h5那边只要请求了，oc内部就会响应
    [self JS2OCTwo];
}


- (void)loadExamplePageOne:(WKWebView*)webView {
    NSString * path = [[NSString alloc] init];
    path = [NSString stringWithFormat:@"http://123.206.24.66:8888/formal/shipping.html"];
    NSURL * url = [[NSURL alloc] initWithString:path];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)loadExamplePageTwo:(WKWebView*)webView {
    NSString * path = [[NSString alloc] init];
    path = [NSString stringWithFormat:@"http://123.206.24.66:8888/formal/da.html"];
    NSURL * url = [[NSURL alloc] initWithString:path];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)loadExamplePageThree:(WKWebView*)webView {
    NSString * path = [[NSString alloc] init];
    path = [NSString stringWithFormat:@"http://123.206.24.66:8888/formal/arrive.html"];
    NSURL * url = [[NSURL alloc] initWithString:path];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

-(void)JS2OCOne{
    /*
     含义：JS调用OC
     @param registerHandler 要注册的事件名称(比如这里我们为loginAction)
     @param handel 回调block函数 当后台触发这个事件的时候会执行block里面的代码
     */
    [_bridgeOne registerHandler:@"loginAction" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data js页面传过来的参数  假设这里是用户名和姓名，字典格式
        NSLog(@"JS调用OC，并传值过来");
        
        // 利用data参数处理自己的逻辑
        NSString * dataStr = (NSString *)data;
        NSLog(@"JS调用OC返回的data：%@",dataStr);
        if ([dataStr isKindOfClass:[NSString class]]) {
            //创建一个消息对象 在首页接收跳转扫描二维码
            NSNotification * notice = [NSNotification notificationWithName:@"loading" object:nil userInfo:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter] postNotification:notice];
        } else {
            NSDictionary * dict = (NSDictionary *)data;
            NSNotification * notice = [NSNotification notificationWithName:@"printOrder" object:nil userInfo:dict];
            [[NSNotificationCenter defaultCenter] postNotification:notice];
        }
        // responseCallback 给js的回复
        responseCallback(@"报告，oc已收到js的请求");
    }];
}

-(void)JS2OCTwo{
    /*
     含义：JS调用OC
     @param registerHandler 要注册的事件名称(比如这里我们为loginAction)
     @param handel 回调block函数 当后台触发这个事件的时候会执行block里面的代码
     */
    [_bridgeTwo registerHandler:@"loginAction" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data js页面传过来的参数  假设这里是用户名和姓名，字典格式
        NSLog(@"JS调用OC，并传值过来");
        
        // 利用data参数处理自己的逻辑
//        NSString * dataStr = (NSString *)data;

        // 创建一个消息对象 在首页接收跳转扫描二维码
        NSNotification * notice = [NSNotification notificationWithName:@"arrive" object:nil userInfo:nil];
        // 发送消息
        [[NSNotificationCenter defaultCenter] postNotification:notice];
        // responseCallback 给js的回复
        responseCallback(@"报告，oc已收到js的请求");
    }];
}

@end
