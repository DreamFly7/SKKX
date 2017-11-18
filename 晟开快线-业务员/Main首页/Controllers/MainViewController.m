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

@end

@implementation MainViewController

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
    [self createMainView];
}

- (void)createMainView {
    // 功能按钮区
    _functionView = [[FunctionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_W/5*2)];
    _functionView.backgroundColor = [UIColor whiteColor];
    _functionView.layer.borderWidth = 0;
    _functionView.layer.borderColor = ColorFontGrayLittle.CGColor;
    __weak typeof(self) weakSelf = self;
    _functionView.functionBlock = ^(NSUInteger functionNum) {
        [weakSelf functionMainEvent:functionNum];
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

    /* 使用GCD返回主线程 进行UI层面的赋值 */
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _invoiceListView    = [[InvoiceListView alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
        [self invoiceListEvent]; // 默认首页
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            _placeOrderView     = [[PlaceOrderView       alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            _accountMoneyView   = [[AccountMoneyView     alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            _searchOrderView    = [[SearchOrderView      alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            _collectionMoneyView = [[CollectionMoneyView alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            _orderListView      = [[OrderListView        alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            _financeView        = [[FinanceView          alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            _arriveListView     = [[ArriveListView       alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            _loadingListView    = [[LoadingListView      alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            _sendOrderView      = [[SendOrderView        alloc] initWithFrame:CGRectMake(0,SCREEN_W/5*2+44,SCREEN_W,SCREEN_H-(SCREEN_W/5*2))];
            
        });
    });

    // 接收通知
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，接收来自用户中心切换版本时候的通知
    [center addObserver:self selector:@selector(sweepQrCodeEvent) name:@"sweep" object:nil];
    
}

// 财务
- (void)functionMainEvent:(NSUInteger)functionNum {
    NSLog(@"成功调用BLOCK");
    switch (functionNum) {
        case 0:
            NSLog(@"开单事件调用");
            [self placeOrderEvent];
            break;
        case 1:
            NSLog(@"交账事件调用");
            [self accountMoneyEvent];
            break;
        case 2:
            NSLog(@"搜索事件调用");
            [self searchOrderEvent];
            break;
        case 3:
            NSLog(@"代收事件调用");
            [self collectionMoneyEvent];
            break;
        case 4:
            NSLog(@"订单事件调用");
            [self orderListEvent];
            break;
        case 5:
            NSLog(@"财务事件调用");
            [self financeEvent];
            break;
        case 6:
            NSLog(@"发货单事件调用");
            [self invoiceListEvent];
            break;
        case 7:
            NSLog(@"即达单事件调用");
            [self arriveListEvent];
            break;
        case 8:
            NSLog(@"装车事件调用");
            [self loadingListEvent];
            break;
        case 9:
            NSLog(@"派单记录事件调用");
            [self sendOrderEvent];
            break;
        default:
            break;
    }
}

// 开单
- (void)placeOrderEvent {
    NSLog(@"开单事件调用成功");
    [self.view addSubview:_placeOrderView];
    
}
// 交账
- (void)accountMoneyEvent {
    NSLog(@"交账事件调用成功");
    [self.view addSubview:_accountMoneyView];
}
// 扫描二维码
- (void)sweepQrCodeEvent {
    QRCodeScanViewController * qrCodeView = [[QRCodeScanViewController alloc] init];
    NSLog(@"跳转至扫描二维码界面");
    qrCodeView.loading = NO;
    hPushViewController(qrCodeView);
}
// 搜索
- (void)searchOrderEvent {
    NSLog(@"搜索事件调用成功");
    [self.view addSubview:_searchOrderView];
}
// 代收
- (void)collectionMoneyEvent {
    NSLog(@"代收事件调用成功");
    [self.view addSubview:_collectionMoneyView];
}
// 订单
- (void)orderListEvent {
    NSLog(@"订单事件调用成功");
    [self.view addSubview:_orderListView];
}
// 财务
- (void)financeEvent {
    NSLog(@"财务事件调用成功");
    [self.view addSubview:_financeView];
}
// 发货单
- (void)invoiceListEvent {
    NSLog(@"发货单事件调用成功");
    [self.view addSubview:_invoiceListView];
}
// 即达单
- (void)arriveListEvent {
    NSLog(@"即达单事件调用成功");
    [self.view addSubview:_arriveListView];
}
// 装车
- (void)loadingListEvent {
    [self.view addSubview:_loadingListView];
    NSLog(@"装车事件调用成功");
}
// 派单
- (void)sendOrderEvent {
    NSLog(@"历史记录事件调用成功");
    [self.view addSubview:_sendOrderView];
}




@end
