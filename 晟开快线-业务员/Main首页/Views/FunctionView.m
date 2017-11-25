//
//  FunctionView.m
//  晟开快线-业务员
//
//  Created by 胡隆海 on 17/11/16.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "FunctionView.h"

#define ImageEdgeInsets UIEdgeInsetsMake(SCREEN_W*0.01, SCREEN_W*0.05, SCREEN_W*0.09, SCREEN_W*0.05)
#define TitleEdgeInsets UIEdgeInsetsMake(SCREEN_W*0.1, -SCREEN_W*0.3, 0, SCREEN_W*0.01)


@interface FunctionView()
@end

@implementation FunctionView {
    UIButton * placeOrderButton;     // 开单
    UIButton * accountMoneyButton;   // 交账
    UIButton * searchOrderButton;    // 搜索
    UIButton * collectionMoneyButton;// 代收
    UIButton * orderButton;          // 订单
    UIButton * financeButton;        // 财务
    UIButton * invoiceButton;        // 发货单
    UIButton * arriveButton;         // 即达单
    UIButton * loadingButton;        // 装车
    UIButton * sendOrderButton;        // 历史记录
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    CGFloat buttonSize = SCREEN_W/5;
    
    placeOrderButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonSize, buttonSize)];
    placeOrderButton.backgroundColor = [UIColor whiteColor];
    [placeOrderButton setTitle:@"开单" forState:UIControlStateNormal];
    [placeOrderButton setImage:[UIImage imageNamed:@"kd-h"] forState:UIControlStateNormal];
    [placeOrderButton setImage:[UIImage imageNamed:@"kd"] forState:UIControlStateSelected];
    [placeOrderButton setImageEdgeInsets:ImageEdgeInsets];
    [placeOrderButton setTitleEdgeInsets:TitleEdgeInsets];
    [placeOrderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    placeOrderButton.titleLabel.font = [UIFont systemFontOfSize:14];
    hAddEvent(placeOrderButton, placeOrderEvent);
    [self addSubview:placeOrderButton];
    
    accountMoneyButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W*0.2, 0, buttonSize, buttonSize)];
    accountMoneyButton.backgroundColor = [UIColor whiteColor];
    [accountMoneyButton setTitle:@"交账" forState:UIControlStateNormal];
    [accountMoneyButton setImage:[UIImage imageNamed:@"jz-h"] forState:UIControlStateNormal];
    [accountMoneyButton setImage:[UIImage imageNamed:@"jz"] forState:UIControlStateSelected];
    [accountMoneyButton setImageEdgeInsets:ImageEdgeInsets];
    [accountMoneyButton setTitleEdgeInsets:TitleEdgeInsets];
    [accountMoneyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    accountMoneyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    hAddEvent(accountMoneyButton, accountMoneyEvent);
    [self addSubview:accountMoneyButton];
    
    searchOrderButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W*0.4, 0, buttonSize, buttonSize)];
    searchOrderButton.backgroundColor = [UIColor whiteColor];
    [searchOrderButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchOrderButton setImage:[UIImage imageNamed:@"ss-h"] forState:UIControlStateNormal];
    [searchOrderButton setImage:[UIImage imageNamed:@"ss"] forState:UIControlStateSelected];
    [searchOrderButton setImageEdgeInsets:ImageEdgeInsets];
    [searchOrderButton setTitleEdgeInsets:TitleEdgeInsets];
    [searchOrderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    searchOrderButton.titleLabel.font = [UIFont systemFontOfSize:14];
    hAddEvent(searchOrderButton, searchOrderEvent);
    [self addSubview:searchOrderButton];
    
    collectionMoneyButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W*0.6, 0, buttonSize, buttonSize)];
    collectionMoneyButton.backgroundColor = [UIColor whiteColor];
    [collectionMoneyButton setTitle:@"代收" forState:UIControlStateNormal];
    [collectionMoneyButton setImage:[UIImage imageNamed:@"ds-h"] forState:UIControlStateNormal];
    [collectionMoneyButton setImage:[UIImage imageNamed:@"ds"] forState:UIControlStateSelected];
    [collectionMoneyButton setImageEdgeInsets:ImageEdgeInsets];
    [collectionMoneyButton setTitleEdgeInsets:TitleEdgeInsets];
    [collectionMoneyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    collectionMoneyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    hAddEvent(collectionMoneyButton, collectionMoneyEvent);
    [self addSubview:collectionMoneyButton];
    
    orderButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W*0.8, 0, buttonSize, buttonSize)];
    orderButton.backgroundColor = [UIColor whiteColor];
    [orderButton setTitle:@"订单" forState:UIControlStateNormal];
    [orderButton setImage:[UIImage imageNamed:@"sd-h"] forState:UIControlStateNormal];
    [orderButton setImage:[UIImage imageNamed:@"sd"] forState:UIControlStateSelected];
    [orderButton setImageEdgeInsets:ImageEdgeInsets];
    [orderButton setTitleEdgeInsets:TitleEdgeInsets];
    [orderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    orderButton.titleLabel.font = [UIFont systemFontOfSize:14];
    hAddEvent(orderButton, orderListEvent);
    [self addSubview:orderButton];
    
    //--------------------------------------
    
    financeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, buttonSize, buttonSize, buttonSize)];
    financeButton.backgroundColor = [UIColor whiteColor];
    [financeButton setTitle:@"财务" forState:UIControlStateNormal];
    [financeButton setImage:[UIImage imageNamed:@"cw-h"] forState:UIControlStateNormal];
    [financeButton setImage:[UIImage imageNamed:@"cw"] forState:UIControlStateSelected];
    [financeButton setImageEdgeInsets:ImageEdgeInsets];
    [financeButton setTitleEdgeInsets:TitleEdgeInsets];
    [financeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    financeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    hAddEvent(financeButton, financeEvent);
    [self addSubview:financeButton];
    
    invoiceButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W*0.2, buttonSize, buttonSize, buttonSize)];
    invoiceButton.backgroundColor = [UIColor whiteColor];
    [invoiceButton setTitle:@"发货单" forState:UIControlStateNormal];
    [invoiceButton setImage:[UIImage imageNamed:@"fhd-h"] forState:UIControlStateNormal];
    [invoiceButton setImage:[UIImage imageNamed:@"fhd"] forState:UIControlStateSelected];
    invoiceButton.selected = YES;
    [invoiceButton setImageEdgeInsets:ImageEdgeInsets];
    [invoiceButton setTitleEdgeInsets:TitleEdgeInsets];
    [invoiceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    invoiceButton.titleLabel.font = [UIFont systemFontOfSize:14];
    hAddEvent(invoiceButton, invoiceListEvent);
    [self addSubview:invoiceButton];
    
    arriveButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W*0.4, buttonSize, buttonSize, buttonSize)];
    arriveButton.backgroundColor = [UIColor whiteColor];
    [arriveButton setTitle:@"即达单" forState:UIControlStateNormal];
    [arriveButton setImage:[UIImage imageNamed:@"jdd-h"] forState:UIControlStateNormal];
    [arriveButton setImage:[UIImage imageNamed:@"jdd"] forState:UIControlStateSelected];
    [arriveButton setImageEdgeInsets:ImageEdgeInsets];
    [arriveButton setTitleEdgeInsets:TitleEdgeInsets];
    [arriveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    arriveButton.titleLabel.font = [UIFont systemFontOfSize:14];
    hAddEvent(arriveButton, arriveListEvent);
    [self addSubview:arriveButton];
    
    loadingButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W*0.6, buttonSize, buttonSize, buttonSize)];
    loadingButton.backgroundColor = [UIColor whiteColor];
    [loadingButton setTitle:@"装车" forState:UIControlStateNormal];
    [loadingButton setImage:[UIImage imageNamed:@"zc-h"] forState:UIControlStateNormal];
    [loadingButton setImage:[UIImage imageNamed:@"zc"] forState:UIControlStateSelected];
    [loadingButton setImageEdgeInsets:ImageEdgeInsets];
    [loadingButton setTitleEdgeInsets:TitleEdgeInsets];
    [loadingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loadingButton.titleLabel.font = [UIFont systemFontOfSize:14];
    hAddEvent(loadingButton, loadingListEvent);
    [self addSubview:loadingButton];
    
    sendOrderButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W*0.8, buttonSize, buttonSize, buttonSize)];
    sendOrderButton.backgroundColor = [UIColor whiteColor];
    [sendOrderButton setTitle:@"派单" forState:UIControlStateNormal];
    [sendOrderButton setImage:[UIImage imageNamed:@"pd-h"] forState:UIControlStateNormal];
    [sendOrderButton setImage:[UIImage imageNamed:@"pd"] forState:UIControlStateSelected];
    [sendOrderButton setImageEdgeInsets:ImageEdgeInsets];
    [sendOrderButton setTitleEdgeInsets:TitleEdgeInsets];
    [sendOrderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sendOrderButton.titleLabel.font = [UIFont systemFontOfSize:14];
    hAddEvent(sendOrderButton, sendOrderEvent);
    [self addSubview:sendOrderButton];
        
    UIButton * pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pushButton.frame = CGRectMake(SCREEN_W/3, self.height-24, SCREEN_W/3, 20);
    pushButton.backgroundColor = [UIColor redColor];
    hAddEvent(pushButton, pushMainViewEvent);
//    [self addSubview:pushButton];
    
    }
    return self;
}

// 开单
- (void)placeOrderEvent {
    NSLog(@"开始调用BLOCK");
    [self funtionButtonSelectEvent:0];
    if (self.functionBlock) {
        self.functionBlock(0);
    }
}
// 交账
- (void)accountMoneyEvent {
    NSLog(@"开始调用BLOCK");
    [self funtionButtonSelectEvent:1];
    if (self.functionBlock) {
        self.functionBlock(1);
    }
}
// 搜索
- (void)searchOrderEvent {
    NSLog(@"开始调用BLOCK");
    [self funtionButtonSelectEvent:2];
    if (self.functionBlock) {
        self.functionBlock(2);
    }
}
// 代收
- (void)collectionMoneyEvent {
    NSLog(@"开始调用BLOCK");
    [self funtionButtonSelectEvent:3];
    if (self.functionBlock) {
        self.functionBlock(3);
    }
}
// 订单
- (void)orderListEvent {
    NSLog(@"开始调用BLOCK");
    [self funtionButtonSelectEvent:4];
    if (self.functionBlock) {
        self.functionBlock(4);
    }
}
// 财务
- (void)financeEvent {
    NSLog(@"开始调用BLOCK");
    [self funtionButtonSelectEvent:5];
    if (self.functionBlock) {
        self.functionBlock(5);
    }
}
// 发货单
- (void)invoiceListEvent {
    NSLog(@"开始调用BLOCK");
    [self funtionButtonSelectEvent:6];
    if (self.functionBlock) {
        self.functionBlock(6);
    }
}
// 即达单
- (void)arriveListEvent {
    NSLog(@"开始调用BLOCK");
    [self funtionButtonSelectEvent:7];
    if (self.functionBlock) {
        self.functionBlock(7);
    }
}
// 装车
- (void)loadingListEvent {
    NSLog(@"开始调用BLOCK");
    [self funtionButtonSelectEvent:8];
    if (self.functionBlock) {
        self.functionBlock(8);
    }
}
// 历史记录
- (void)sendOrderEvent {
    NSLog(@"开始调用BLOCK");
    [self funtionButtonSelectEvent:9];
    if (self.functionBlock) {
        self.functionBlock(9);
    }
}

// push视图
- (void)pushMainViewEvent {
    NSLog(@"调用push的block");
    if (self.pushBlock) {
        self.pushBlock();
    }
}


// 按钮状态
- (void)funtionButtonSelectEvent:(NSInteger)buttonNum {
    switch (buttonNum) {
        case 0:
            placeOrderButton     .selected = YES;
            accountMoneyButton   .selected = NO;
            searchOrderButton    .selected = NO;
            collectionMoneyButton.selected = NO;
            orderButton          .selected = NO;
            financeButton        .selected = NO;
            invoiceButton        .selected = NO;
            arriveButton         .selected = NO;
            loadingButton        .selected = NO;
            sendOrderButton      .selected = NO;
            break;
        case 1:
            placeOrderButton     .selected = NO;
            accountMoneyButton   .selected = YES;
            searchOrderButton    .selected = NO;
            collectionMoneyButton.selected = NO;
            orderButton          .selected = NO;
            financeButton        .selected = NO;
            invoiceButton        .selected = NO;
            arriveButton         .selected = NO;
            loadingButton        .selected = NO;
            sendOrderButton      .selected = NO;
            break;
        case 2:
            placeOrderButton     .selected = NO;
            accountMoneyButton   .selected = NO;
            searchOrderButton    .selected = YES;
            collectionMoneyButton.selected = NO;
            orderButton          .selected = NO;
            financeButton        .selected = NO;
            invoiceButton        .selected = NO;
            arriveButton         .selected = NO;
            loadingButton        .selected = NO;
            sendOrderButton      .selected = NO;
            break;
        case 3:
            placeOrderButton     .selected = NO;
            accountMoneyButton   .selected = NO;
            searchOrderButton    .selected = NO;
            collectionMoneyButton.selected = YES;
            orderButton          .selected = NO;
            financeButton        .selected = NO;
            invoiceButton        .selected = NO;
            arriveButton         .selected = NO;
            loadingButton        .selected = NO;
            sendOrderButton      .selected = NO;
            break;
        case 4:
            placeOrderButton     .selected = NO;
            accountMoneyButton   .selected = NO;
            searchOrderButton    .selected = NO;
            collectionMoneyButton.selected = NO;
            orderButton          .selected = YES;
            financeButton        .selected = NO;
            invoiceButton        .selected = NO;
            arriveButton         .selected = NO;
            loadingButton        .selected = NO;
            sendOrderButton      .selected = NO;
            break;
        case 5:
            placeOrderButton     .selected = NO;
            accountMoneyButton   .selected = NO;
            searchOrderButton    .selected = NO;
            collectionMoneyButton.selected = NO;
            orderButton          .selected = NO;
            financeButton        .selected = YES;
            invoiceButton        .selected = NO;
            arriveButton         .selected = NO;
            loadingButton        .selected = NO;
            sendOrderButton      .selected = NO;
            break;
        case 6:
            placeOrderButton     .selected = NO;
            accountMoneyButton   .selected = NO;
            searchOrderButton    .selected = NO;
            collectionMoneyButton.selected = NO;
            orderButton          .selected = NO;
            financeButton        .selected = NO;
            invoiceButton        .selected = YES;
            arriveButton         .selected = NO;
            loadingButton        .selected = NO;
            sendOrderButton      .selected = NO;
            break;
        case 7:
            placeOrderButton     .selected = NO;
            accountMoneyButton   .selected = NO;
            searchOrderButton    .selected = NO;
            collectionMoneyButton.selected = NO;
            orderButton          .selected = NO;
            financeButton        .selected = NO;
            invoiceButton        .selected = NO;
            arriveButton         .selected = YES;
            loadingButton        .selected = NO;
            sendOrderButton      .selected = NO;
            break;
        case 8:
            placeOrderButton     .selected = NO;
            accountMoneyButton   .selected = NO;
            searchOrderButton    .selected = NO;
            collectionMoneyButton.selected = NO;
            orderButton          .selected = NO;
            financeButton        .selected = NO;
            invoiceButton        .selected = NO;
            arriveButton         .selected = NO;
            loadingButton        .selected = YES;
            sendOrderButton      .selected = NO;
            break;
        case 9:
            placeOrderButton     .selected = NO;
            accountMoneyButton   .selected = NO;
            searchOrderButton    .selected = NO;
            collectionMoneyButton.selected = NO;
            orderButton          .selected = NO;
            financeButton        .selected = NO;
            invoiceButton        .selected = NO;
            arriveButton         .selected = NO;
            loadingButton        .selected = NO;
            sendOrderButton      .selected = YES;
            break;
            
        default:
            break;
    }
}

@end
