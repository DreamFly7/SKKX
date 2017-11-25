//
//  MainViewController.m
//  晟开快线-业务员
//
//  Created by 胡隆海 on 17/11/16.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "MainViewController.h"
#import "FunctionView.h"
#import "PlaceOrderView.h"      // 开单界面
#import "AccountMoneyView.h"    // 交账界面
#import "QRCodeScanViewController.h" // 扫描二维码
#import "PrintOrderViewController.h" // 打印订单
#import "SearchOrderView.h"     // 搜索界面
#import "CollectionMoneyView.h" // 代收界面
#import "OrderListView.h"       // 订单界面
#import "FinanceView.h"         // 财务界面
#import "InvoiceListView.h"     // 发货单界面
#import "ArriveListView.h"      // 即达单界面
#import "LoadingListView.h"     // 装车界面
#import "SendOrderView.h"       // 派单界面

#define ImageEdgeInsets UIEdgeInsetsMake(SCREEN_W*0.05, SCREEN_W*0.08, SCREEN_W*0.1, SCREEN_W*0.08)
#define TitleEdgeInsets UIEdgeInsetsMake(SCREEN_W*0.1, -SCREEN_W*0.3, 0, 0)

@interface MainViewController ()
@property (nonatomic, strong) FunctionView      * functionView; // 功能按钮区
@property (nonatomic, strong) PlaceOrderView    * placeOrderView;
@property (nonatomic, strong) AccountMoneyView  * accountMoneyView;
@property (nonatomic, strong) SearchOrderView   * searchOrderView;
@property (nonatomic, strong) CollectionMoneyView   * collectionMoneyView;
@property (nonatomic, strong) OrderListView         * orderListView;
@property (nonatomic, strong) FinanceView           * financeView;
@property (nonatomic, strong) InvoiceListView       * invoiceListView;
@property (nonatomic, strong) ArriveListView        * arriveListView;
@property (nonatomic, strong) LoadingListView       * loadingListView;
@property (nonatomic, strong) SendOrderView         * sendOrderView;

@property (nonatomic, strong) UIBarButtonItem * leftBarItem; // 隐藏与显示
@property (nonatomic, assign) BOOL isPushUpTime; // 整个视图推送上去为YES 否则为NO

@end

@implementation MainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"晟开快线";
        self.view.backgroundColor = ColorWhite;
        hSetBackButton(@"");
        _isPushUpTime = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightBtn];
    [self createMainView];
}


- (void)addRightBtn {
    
    _leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏" style:UIBarButtonItemStylePlain target:self action:@selector(pushMainView)];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = _leftBarItem;
    
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOutbtn)];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}

- (void)createMainView {
    // 功能按钮区
    _functionView = [[FunctionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_W/5*2+20)];
    _functionView.backgroundColor = [UIColor whiteColor];
    _functionView.layer.borderWidth = 0;
    _functionView.layer.borderColor = ColorFontGrayLittle.CGColor;
    __weak typeof(self) weakSelf = self;
    _functionView.functionBlock = ^(NSUInteger functionNum) {
        [weakSelf functionMainEvent:functionNum];
    };
    _functionView.pushBlock = ^() {
        [weakSelf pushMainView];
    };
    [self.view addSubview:_functionView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor redColor]    .CGColor,
                             (__bridge id)[UIColor yellowColor] .CGColor,
                             (__bridge id)[UIColor blueColor]   .CGColor];
    gradientLayer.locations = @[@0.3, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, SCREEN_W/5*2+60, SCREEN_W, 2);
    [self.view.layer addSublayer:gradientLayer];

    [self createAllFunctionView];
    
    
    // 接收通知
    // 获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    // 添加当前类对象为一个观察者，接收来自用户中心切换版本时候的通知
    [center addObserver:self selector:@selector(sweepQrCodeEvent) name:@"scanning" object:nil];  // 交账扫描二维码
    [center addObserver:self selector:@selector(sweepQrCodeEvent) name:@"loading" object:nil];   // 装车扫描二维码
    [center addObserver:self selector:@selector(printOrderEvent) name:@"printOrder" object:nil]; // 打印订单
    
}

#pragma mark -- 分线程加载界面

- (void)createAllFunctionView {
    /* 使用GCD返回主线程 进行UI层面的赋值 */
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _invoiceListView    = [[InvoiceListView alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+64,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
        [self invoiceListEvent]; // 默认首页
        [self gainPlistPath];
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
//            _placeOrderView     = [[PlaceOrderView       alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
//            _accountMoneyView   = [[AccountMoneyView     alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
//            _searchOrderView    = [[SearchOrderView      alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
//            _collectionMoneyView = [[CollectionMoneyView alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
//            _orderListView      = [[OrderListView        alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
//            _financeView        = [[FinanceView          alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
//            _arriveListView     = [[ArriveListView       alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
//            _loadingListView    = [[LoadingListView      alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
//            _sendOrderView      = [[SendOrderView        alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            
//        });
    });
}

#pragma mark -- 功能键的调用方法集结

- (void)functionMainEvent:(NSUInteger)functionNum {
    NSString * functionStr = [[NSString alloc] init];
    functionStr = [self readFunctionNumEvent];
    NSInteger functionN = [functionStr intValue];
    if (functionNum == functionN) { // 重复点击当前界面时
        return;
    }
    NSLog(@"成功调用BLOCK");
    switch (functionNum) {
        case 0:
            NSLog(@"开单事件调用");
            _placeOrderView     = [[PlaceOrderView       alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+64,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            [self placeOrderEvent];
            
            break;
        case 1:
            NSLog(@"交账事件调用");
            _accountMoneyView   = [[AccountMoneyView     alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+64,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            [self accountMoneyEvent];
            break;
        case 2:
            NSLog(@"搜索事件调用");
            _searchOrderView    = [[SearchOrderView      alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+64,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            [self searchOrderEvent];
            break;
        case 3:
            NSLog(@"代收事件调用");
            _collectionMoneyView = [[CollectionMoneyView alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+64,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            [self collectionMoneyEvent];
            break;
        case 4:
            NSLog(@"订单事件调用");
            _orderListView      = [[OrderListView        alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+64,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            [self orderListEvent];
            break;
        case 5:
            NSLog(@"财务事件调用");
            _financeView        = [[FinanceView          alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+64,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            [self financeEvent];
            break;
        case 6:
            NSLog(@"发货单事件调用");
            _invoiceListView    = [[InvoiceListView alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+64,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            [self invoiceListEvent];
            break;
        case 7:
            NSLog(@"即达单事件调用");
            _arriveListView     = [[ArriveListView       alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+64,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            [self arriveListEvent];
            break;
        case 8:
            NSLog(@"装车事件调用");
            _loadingListView    = [[LoadingListView      alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+64,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            [self loadingListEvent];
            break;
        case 9:
            NSLog(@"派单记录事件调用");
            _sendOrderView      = [[SendOrderView        alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+64,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            [self sendOrderEvent];
            break;
        default:
            break;
    }
}

#pragma mark -- 加载界面以及清除其他界面

// 开单
- (void)placeOrderEvent {
    NSLog(@"开单事件调用成功");
    [self.view addSubview:_placeOrderView];
    [self deallocView:_placeOrderView];
    [self writeFunctionNumEvent:@"0"];
}
// 交账
- (void)accountMoneyEvent {
    NSLog(@"交账事件调用成功");
    [self.view addSubview:_accountMoneyView];
    [self deallocView:_accountMoneyView];
    [self writeFunctionNumEvent:@"1"];
}

// 搜索
- (void)searchOrderEvent {
    NSLog(@"搜索事件调用成功");
    [self.view addSubview:_searchOrderView];
    [self deallocView:_searchOrderView];
    [self writeFunctionNumEvent:@"2"];
}
// 代收
- (void)collectionMoneyEvent {
    NSLog(@"代收事件调用成功");
    [self.view addSubview:_collectionMoneyView];
    [self deallocView:_collectionMoneyView];
    [self writeFunctionNumEvent:@"3"];
}
// 订单
- (void)orderListEvent {
    NSLog(@"订单事件调用成功");
    [self.view addSubview:_orderListView];
    [self deallocView:_orderListView];
    [self writeFunctionNumEvent:@"4"];
}
// 财务
- (void)financeEvent {
    NSLog(@"财务事件调用成功");
    [self.view addSubview:_financeView];
    [self deallocView:_financeView];
    [self writeFunctionNumEvent:@"5"];
}
// 发货单
- (void)invoiceListEvent {
    NSLog(@"发货单事件调用成功");
    [self.view addSubview:_invoiceListView];
    [self deallocView:_invoiceListView];
    [self writeFunctionNumEvent:@"6"];
}
// 即达单
- (void)arriveListEvent {
    NSLog(@"即达单事件调用成功");
    [self.view addSubview:_arriveListView];
    [self deallocView:_arriveListView];
    [self writeFunctionNumEvent:@"7"];
}

// 装车
- (void)loadingListEvent {
    NSLog(@"装车事件调用成功");
    [self.view addSubview:_loadingListView];
    [self deallocView:_loadingListView];
    [self writeFunctionNumEvent:@"8"];
}
// 派单
- (void)sendOrderEvent {
    NSLog(@"历史记录事件调用成功");
    [self.view addSubview:_sendOrderView];
    [self deallocView:_sendOrderView];
    [self writeFunctionNumEvent:@"9"];
}

#pragma mark -- 清除不显示的界面

// 清除不使用的视图View
-(void)deallocView:(UIView *)selfView {
    if (![_placeOrderView isMemberOfClass:[selfView class]]) {
        [_placeOrderView removeFromSuperview];
    }
    if (![_accountMoneyView isMemberOfClass:[selfView class]]) {
        [_accountMoneyView removeFromSuperview];
    }
    if (![_searchOrderView isMemberOfClass:[selfView class]]) {
        [_searchOrderView removeFromSuperview];
    }
    if (![_collectionMoneyView isMemberOfClass:[selfView class]]) {
        [_collectionMoneyView removeFromSuperview];
    }
    if (![_orderListView isMemberOfClass:[selfView class]]) {
        [_orderListView removeFromSuperview];
    }
    if (![_financeView isMemberOfClass:[selfView class]]) {
        [_financeView removeFromSuperview];
    }
    if (![_invoiceListView isMemberOfClass:[selfView class]]) {
        [_invoiceListView removeFromSuperview];
    }
    if (![_arriveListView isMemberOfClass:[selfView class]]) {
        [_arriveListView removeFromSuperview];
    }
    if (![_loadingListView isMemberOfClass:[selfView class]]) {
        [_loadingListView removeFromSuperview];
    }
    if (![_sendOrderView isMemberOfClass:[selfView class]]) {
        [_sendOrderView removeFromSuperview];
    }
}

#pragma mark -- 拉伸与收缩视图
- (void)pushMainView {
    NSLog(@"推动视图");
    // 设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    // 设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    // 使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    if (_isPushUpTime) {
        //设置视图移动的下移
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     self.view.frame.origin.y + ((SCREEN_W/5)*2)-50,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
        _leftBarItem.title = @"隐藏";
        _isPushUpTime = NO;
        //创建一个消息对象 通知WEB界面缩短
        NSNotification * notice = [NSNotification notificationWithName:@"pushDown" object:nil userInfo:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter] postNotification:notice];
    } else {
        //设置视图移动的上移
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     self.view.frame.origin.y - ((SCREEN_W/5)*2)+50,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
        _leftBarItem.title = @"显示";
        _isPushUpTime = YES;
        //创建一个消息对象 通知WEB界面加长
        NSNotification * notice = [NSNotification notificationWithName:@"pushUp" object:nil userInfo:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter] postNotification:notice];
    }
    //设置动画结束
    [UIView commitAnimations];
}

#pragma mark -- 跳转至扫描二维码界面
// 扫描二维码
- (void)sweepQrCodeEvent {
    QRCodeScanViewController * qrCodeView = [[QRCodeScanViewController alloc] init];
    NSLog(@"跳转至扫描二维码界面");
    qrCodeView.loading = NO;
    hPushViewController(qrCodeView);
}

#pragma mark -- 跳转至蓝牙打印以及传输打印的数据
// 蓝牙打印
- (void)printOrderEvent {
    PrintOrderViewController * printOrderView = [[PrintOrderViewController alloc] init];
    printOrderView.orderNumberStr = @"320788988";
    printOrderView.userNameStr    = @"胡隆海";
    printOrderView.timeStr        = @"2017.11.20";
    printOrderView.startCityStr   = @"成都";
    printOrderView.endCityStr     = @"重庆";
    printOrderView.startCompanyStr= @"晟开科技";
    printOrderView.startIphoneStr = @"18888888888";
    printOrderView.startAddressStr= @"四川省成都市高新区";
    printOrderView.endCompanyStr  = @"蚂蚁支付科技";
    printOrderView.endIphoneStr   = @"19999999999";
    printOrderView.endAddressStr  = @"重庆市渝北区";
    printOrderView.payWayStr      = @"1";
    printOrderView.numberStr      = @"66";
    printOrderView.freightStr     = @"55";
    printOrderView.moneyStr       = @"88.8";
    printOrderView.noteStr        = @"备注信息";
    printOrderView.moneySumStr    = @"188.8";
    printOrderView.randomStr      = @"4567";
    hPushViewController(printOrderView);
}

-(void)loginAction{
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:@"136"  forKey:@"telephone"];
    [params setValue:@"88888"  forKey:@"password"];
    
    [[HttpManage shareInstance] postLoginWithParmaeters:params Success:^(NSMutableDictionary *dic) {
        NSLog(@"登录返回信息：%@",dic);
    }];
}

// 1.获得文件路径
- (void)gainPlistPath {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    _plistFile     = [path stringByAppendingPathComponent:@"functionNum.plist"];
}
// 2.储存一个值
- (void)writeFunctionNumEvent:(NSString *)functionStr {
    NSMutableArray * array = [NSMutableArray array];
    [array insertObject:functionStr atIndex:0];
    NSLog(@"需要存储的数据%@",array);
    [array writeToFile:_plistFile atomically:YES];
}
// 3.取本地持久化的这个值
- (NSString *)readFunctionNumEvent {
    NSArray * result = [NSArray arrayWithContentsOfFile:_plistFile];
    NSLog(@"读取出来的数据%@",result);
    NSString * functionStr = result[0];
    return functionStr;
}

#pragma mark -- 注销账户
// 注销
- (void)onClickedOutbtn {
    //UIAlertController风格：UIAlertControllerStyleAlert
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                             message:@"是否注销"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"取消注销");
    }];
    [alertController addAction:cancelAction];
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self sureOutEvent];
    }];
    [alertController addAction:OKAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)sureOutEvent {
    NSLog(@"确定退出");
    //创建一个消息对象 在首页接收跳转界面
    NSNotification * notice = [NSNotification notificationWithName:@"logoutSuccess" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}

@end
