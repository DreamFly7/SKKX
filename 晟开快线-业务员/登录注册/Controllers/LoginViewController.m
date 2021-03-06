//
//  LoginViewController.m
//  晟开快线-业务员
//
//  Created by 胡隆海 on 17/11/21.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "LoginViewController.h"
#import "NewPringViewController.h"

@interface LoginViewController ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView * webView;
@property WebViewJavascriptBridge * bridge;
@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"晟开快线";
        self.view.backgroundColor = ColorWhite;
        hSetBackButton(@"");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
    [self createWebViewJavascriptBridge];
}

-(void)createWebView{
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.navigationDelegate = self;
    _webView.scrollView.bounces = NO;
    // 滑动返回
    _webView.allowsBackForwardNavigationGestures = YES;
    _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    NSString * path = [[NSString alloc] init];
    path = [NSString stringWithFormat:@"http://123.206.24.66:8888/formal/login.html"];
    NSURL * url = [[NSURL alloc] initWithString:path];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:_webView];
    [MBProgressHUD showMessage:@"正在加载数据中....."];
}

#pragma mark- Delegate Webview
//1.准备加载页面
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"登录界面准备加载页面");
}
//2.内容开始加载(view的过渡动画可在此方法中加载)
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"登录界面内容开始加载");
}
//3.页面加载完成(view的过渡动画的移除可在此方法中进行)
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"登录界面页面加载完成");
    // 移除HUD
    [MBProgressHUD hideHUD];
    
}
//4.页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"3页面加载失败");
    // 移除HUD
    [MBProgressHUD hideHUD];
    // 提醒有没有新数据
    [MBProgressHUD showError:@"加载失败，请检查网络连接"];
    
    UIButton * refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshButton.frame = CGRectMake(SCREEN_W/3, SCREEN_H*0.6, SCREEN_W/3, 40);
    refreshButton.layer.masksToBounds = YES;
    refreshButton.layer.cornerRadius = 20;
    refreshButton.backgroundColor = RGBCOLOR(188, 188, 188);
    [refreshButton setTitle:@"重新加载" forState:UIControlStateNormal];
    [refreshButton setTitleColor:ColorFontBlack forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refreshEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:refreshButton aboveSubview:_webView];
}

- (void)refreshEvent {
    NSLog(@"刷新界面");
    //创建一个消息对象 在首页接收跳转界面
    NSNotification * notice = [NSNotification notificationWithName:@"loginFail" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}

#pragma mark -- createWebViewJavascriptBridge

- (void)createWebViewJavascriptBridge {
    //初始化  WebViewJavascriptBridge
    NSLog(@"收到了通知");
    if (_bridge) { return; }
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    
    //请求加载html，注意：这里h5加载完，会自动执行一个调用oc的方法
//    [self loadExamplePage:_webView];
    
    //申明js调用oc方法的处理事件，这里写了后，h5那边只要请求了，oc内部就会响应
    [self JS2OC];
    
    //模拟操作：2秒后，oc会调用js的方法
    //注意：这里厉害的是，我们不需要等待html加载完成，就能处理oc的请求事件；此外，webview的request 也可以在这个请求后面执行（可以把上面的[self loadExamplePage:webView]放到[self OC2JS]后面执行，结果是一样的）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self OC2JS];
    });
}

- (void)loadExamplePage:(WKWebView*)webView {
    
}

-(void)JS2OC{
    /*
     含义：JS调用OC
     @param registerHandler 要注册的事件名称(比如这里我们为loginAction)
     @param handel 回调block函数 当后台触发这个事件的时候会执行block里面的代码
     loginAction
     */
    [_bridge registerHandler:@"loginAction" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data js页面传过来的参数  假设这里是用户名和姓名，字典格式
        // 利用data参数处理自己的逻辑
        
        NSDictionary * dict = (NSDictionary *)data;
        NSLog(@"登录收到JS端返回的用户数据：%@",dict);
        UserModel * user = [UserModel sharedUser];
        [[UserModel sharedUser] clearUserInfo];
        user.companyname    = [NSString stringWithFormat:@"%@", dict[@"data"][@"corporateName"]];
        user.companyaddress = [NSString stringWithFormat:@"%@", dict[@"data"][@"companyAddress"]];
        user.companytel     = [NSString stringWithFormat:@"%@", dict[@"data"][@"companyTelephone"]];
        user.userId         = [NSString stringWithFormat:@"%@", dict[@"data"][@"id"]];
        user.userName       = [NSString stringWithFormat:@"%@", dict[@"data"][@"name"]];
        user.cellphone      = [NSString stringWithFormat:@"%@", dict[@"data"][@"telephone"]];
        user.password       = [NSString stringWithFormat:@"%@", dict[@"data"][@"password"]];
        user.vipid          = [NSString stringWithFormat:@"%@", dict[@"data"][@"privilege"]];
        user.station        = [NSString stringWithFormat:@"%@", dict[@"data"][@"dot"]];
        [[UserModel sharedUser] saveToLocal];
        
        //创建一个消息对象 在首页接收跳转界面
        NSNotification * notice = [NSNotification notificationWithName:@"loginSuccess" object:nil userInfo:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter] postNotification:notice];
        // responseCallback 给js的回复
        responseCallback(@"报告，oc已收到js的请求");
    }];
}

-(void)OC2JS{
    /*
     含义：OC调用JS
     @param callHandler 商定的事件名称,用来调用网页里面相应的事件实现
     @param data id类型,相当于我们函数中的参数,向网页传递函数执行需要的参数
     注意，这里callHandler分3种，根据需不需要传参数和需不需要后台返回执行结果来决定用哪个
     */
    
    [_bridge callHandler:@"registerAction" data:@"uid:123 pwd:123" responseCallback:^(id responseData) {
        NSLog(@"OC请求JS后接受的回调结果：%@",responseData);
    }];
}



@end
