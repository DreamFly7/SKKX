//
//  AccountMoneyViewController.m
//  晟开快线-业务员
//
//  Created by 胡隆海 on 17/11/16.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "AccountMoneyViewController.h"

@interface AccountMoneyViewController ()
@property (nonatomic, strong) NSDictionary * orderMessageDataDic;// 订单信息
@property (nonatomic, strong) UILabel * lineLabel1;
@property (nonatomic, strong) UILabel * lineLabel2;
@property (nonatomic, strong) UILabel * lineLabel3;
@property (nonatomic, strong) UILabel * sendPersonalLabel;  // 寄件方
@property (nonatomic, strong) UILabel * receiptLabel;       // 收件方
@property (nonatomic, strong) UITextField * orderNumberTextField; // 订单号
@property (nonatomic, strong) UITextField * startSendTextField;   // 始发地
@property (nonatomic, strong) UITextField * endReceiptTextField;  // 目的地
@property (nonatomic, strong) UITextField * sendPhoneNumberTextField;// 寄件电话
@property (nonatomic, strong) UITextField * sendCompanyNameTextField;// 寄件公司名
@property (nonatomic, strong) UITextField * sendAddressTextField;    // 寄件地址
@property (nonatomic, strong) UITextView  * notesTextView;           // 配件名或备注
@property (nonatomic, strong) UITextField * receiptPhoneNumberTextField;// 收件电话
@property (nonatomic, strong) UITextField * receiptCompanyNameTextField;// 收件公司名
@property (nonatomic, strong) UITextField * receiptAddressTextField;    // 收件地址
@property (nonatomic, strong) UITextField * collectingTextField;// 代收
@property (nonatomic, strong) UITextField * numberTextField;    // 件数
@property (nonatomic, strong) UITextField * moneyTextField;     // 运费
@property (nonatomic, strong) UILabel     * notesLabel;         // 备注
@property (nonatomic, strong) UIButton    * changeButton;       // 修改按钮

@end

@implementation AccountMoneyViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"收  账";
        self.view.backgroundColor = ColorWhite;
        hSetBackButton(@"");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 搜索订单号
- (void)searchOrderData:(NSString *)orderStr {
//    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    [params setValue:orderStr forKey:@"waybill_id"];
//
//    [[HttpManage shareInstance] getOrderMessageWithParmarters:params Success:^(NSMutableDictionary *dic) {
//        
//        NSLog(@"请求成功之后的订单信息为：%@",dic);
//        NSLog(@"搜索订单%@",orderStr);
//        NSString * codeStr = [NSString stringWithFormat:@"%@",dic[@"code"]];
//        if ([codeStr isEqualToString:@"0"]) {
//            _orderMessageDataDic = dic[@"data"];
//            [self createView];
//        } else {
//            [Utils alertWithMessage:@"订单号有误"];
//        }
//    }];
}

// 收账界面  装车界面
- (void)createView {
    
    // 寄件方
    _sendPersonalLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5+70-64, SCREEN_W/2, 20)];
    _sendPersonalLabel.text = @"寄件方";
    _sendPersonalLabel.font = [UIFont systemFontOfSize:14];
    _sendPersonalLabel.textColor = [UIColor blackColor];
    _sendPersonalLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_sendPersonalLabel];
    
    _lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30+70-64, SCREEN_W, 1)];
    _lineLabel1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_lineLabel1];
    
    NSArray * nameArray1 = @[@"电话:",@"单位名称:",@"寄件地址:"];
    NSArray * nameArray2 = @[@"电话:",@"单位名称:",@"收件地址:"];
    
    for (NSInteger index = 0; index < 3; index ++) {
        
        UILabel * sendNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, SCREEN_H*0.07*index+35+80-64, 65, 30)];
        sendNameLabel.text = nameArray1[index];
        sendNameLabel.font = [UIFont systemFontOfSize:14];
        sendNameLabel.textColor = [UIColor blackColor];
        sendNameLabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:sendNameLabel];
    }
    
    // TextField
    _sendPhoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 35+80-64, SCREEN_W*0.37, 30)];
    _sendPhoneNumberTextField.text = self.orderMessageDataDic[@"consignor_tel"];
    //    _sendPhoneNumberTextField.placeholder = @"请输入发件方电话号码";
    _sendPhoneNumberTextField.font = hFontSize(12);
    _sendPhoneNumberTextField.textColor = [UIColor colorWithRed:0.243 green:0.246 blue:0.246 alpha:1.000];
    _sendPhoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _sendPhoneNumberTextField.keyboardType = UIKeyboardTypeDefault;
    _sendPhoneNumberTextField.backgroundColor = [UIColor whiteColor];
    _sendPhoneNumberTextField.borderStyle = UITextBorderStyleBezel;
    _sendPhoneNumberTextField.enabled = NO;
    [self.view addSubview:_sendPhoneNumberTextField];
    
    UILabel * startSendNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W*0.4+50, 35+80-64, 65, 30)];
    startSendNameLabel.text = @"始发地:";
    startSendNameLabel.font = [UIFont systemFontOfSize:14];
    startSendNameLabel.textColor = [UIColor blackColor];
    startSendNameLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:startSendNameLabel];
    
    _startSendTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_W*0.4+120, 35+80-64, SCREEN_W*0.25, 30)];
    _startSendTextField.text = self.orderMessageDataDic[@"origin"];
    _startSendTextField.font = hFontSize(12);
    _startSendTextField.textColor = [UIColor colorWithRed:0.243 green:0.246 blue:0.246 alpha:1.000];
    _startSendTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _startSendTextField.keyboardType = UIKeyboardTypeDefault;
    _startSendTextField.backgroundColor = [UIColor whiteColor];
    _startSendTextField.borderStyle = UITextBorderStyleBezel;
    _startSendTextField.enabled = NO;
    [self.view addSubview:_startSendTextField];
    
    _sendCompanyNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, SCREEN_H*0.07+35+80-64, SCREEN_W*0.8, 30)];
    _sendCompanyNameTextField.text = self.orderMessageDataDic[@"consignor_company"];
    //    _sendCompanyNameTextField.placeholder = @"请输入寄件方单位名称";
    _sendCompanyNameTextField.font = hFontSize(12);
    _sendCompanyNameTextField.textColor = [UIColor colorWithRed:0.243 green:0.246 blue:0.246 alpha:1.000];
    _sendCompanyNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _sendCompanyNameTextField.keyboardType = UIKeyboardTypeDefault;
    _sendCompanyNameTextField.backgroundColor = [UIColor whiteColor];
    _sendCompanyNameTextField.borderStyle = UITextBorderStyleBezel;
    _sendCompanyNameTextField.enabled = NO;
    [self.view addSubview:_sendCompanyNameTextField];
    
    _sendAddressTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, SCREEN_H*0.14+35+80-64, SCREEN_W*0.8, 30)];
    _sendAddressTextField.text = self.orderMessageDataDic[@"consignor_address"];
    //    _sendAddressTextField.placeholder = @"请输入寄件方详细地址";
    _sendAddressTextField.font = hFontSize(12);
    _sendAddressTextField.textColor = [UIColor colorWithRed:0.243 green:0.246 blue:0.246 alpha:1.000];
    _sendAddressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _sendAddressTextField.keyboardType = UIKeyboardTypeDefault;
    _sendAddressTextField.backgroundColor = [UIColor whiteColor];
    _sendAddressTextField.borderStyle = UITextBorderStyleBezel;
    _sendAddressTextField.enabled = NO;
    [self.view addSubview:_sendAddressTextField];
    
    // 收件方
    _receiptLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, SCREEN_H*0.3+70-64, SCREEN_W/2, 20)];
    _receiptLabel.text = @"收件方";
    _receiptLabel.font = [UIFont systemFontOfSize:14];
    _receiptLabel.textColor = [UIColor blackColor];
    _receiptLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_receiptLabel];
    
    _lineLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_H*0.3+25+70-64, SCREEN_W, 1)];
    _lineLabel2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_lineLabel2];
    
    for (NSInteger index = 0; index < 3; index ++) {
        UILabel * receiptNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, SCREEN_H*0.07*index+SCREEN_H*0.35+80-64, 65, 30)];
        receiptNameLabel.text = nameArray2[index];
        receiptNameLabel.font = [UIFont systemFontOfSize:14];
        receiptNameLabel.textColor = [UIColor blackColor];
        receiptNameLabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:receiptNameLabel];
    }
    
    // TextField
    _receiptPhoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, SCREEN_H*0.35+80-64, SCREEN_W*0.37, 30)];
    _receiptPhoneNumberTextField.text = self.orderMessageDataDic[@"consignee_tel"];
    //    _receiptPhoneNumberTextField.placeholder = @"请输入收件方电话号码";
    _receiptPhoneNumberTextField.font = hFontSize(12);
    _receiptPhoneNumberTextField.textColor = [UIColor colorWithRed:0.243 green:0.246 blue:0.246 alpha:1.000];
    _receiptPhoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _receiptPhoneNumberTextField.keyboardType = UIKeyboardTypeDefault;
    _receiptPhoneNumberTextField.backgroundColor = [UIColor whiteColor];
    _receiptPhoneNumberTextField.borderStyle = UITextBorderStyleBezel;
    _receiptPhoneNumberTextField.enabled = NO;
    [self.view addSubview:_receiptPhoneNumberTextField];
    
    UILabel * endReceiptNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W*0.4+50, SCREEN_H*0.35+80-64, 65, 30)];
    endReceiptNameLabel.text = @"目的地:";
    endReceiptNameLabel.font = [UIFont systemFontOfSize:14];
    endReceiptNameLabel.textColor = [UIColor blackColor];
    endReceiptNameLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:endReceiptNameLabel];
    
    _endReceiptTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_W*0.4+120, SCREEN_H*0.35+80-64, SCREEN_W*0.25, 30)];
    _endReceiptTextField.text = self.orderMessageDataDic[@"destination"];
    //    _endReceiptTextField.placeholder = @"";
    _endReceiptTextField.font = hFontSize(12);
    _endReceiptTextField.textColor = [UIColor colorWithRed:0.243 green:0.246 blue:0.246 alpha:1.000];
    _endReceiptTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _endReceiptTextField.keyboardType = UIKeyboardTypeDefault;
    _endReceiptTextField.backgroundColor = [UIColor whiteColor];
    _endReceiptTextField.borderStyle = UITextBorderStyleBezel;
    _endReceiptTextField.enabled = NO;
    [self.view addSubview:_endReceiptTextField];
    
    _receiptCompanyNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, SCREEN_H*0.42+80-64, SCREEN_W*0.8, 30)];
    _receiptCompanyNameTextField.text = self.orderMessageDataDic[@"consignee_company"];
    //    _receiptCompanyNameTextField.placeholder = @"请输入收件方单位名称";
    _receiptCompanyNameTextField.font = hFontSize(12);
    _receiptCompanyNameTextField.textColor = [UIColor colorWithRed:0.243 green:0.246 blue:0.246 alpha:1.000];
    _receiptCompanyNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _receiptCompanyNameTextField.keyboardType = UIKeyboardTypeDefault;
    _receiptCompanyNameTextField.backgroundColor = [UIColor whiteColor];
    _receiptCompanyNameTextField.borderStyle = UITextBorderStyleBezel;
    _receiptCompanyNameTextField.enabled = NO;
    [self.view addSubview:_receiptCompanyNameTextField];
    
    _receiptAddressTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, SCREEN_H*0.49+80-64, SCREEN_W*0.8, 30)];
    _receiptAddressTextField.text = self.orderMessageDataDic[@"consignee_address"];
    //    _receiptAddressTextField.placeholder = @"请输入收件方详细地址";
    _receiptAddressTextField.font = hFontSize(12);
    _receiptAddressTextField.textColor = [UIColor colorWithRed:0.243 green:0.246 blue:0.246 alpha:1.000];
    _receiptAddressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _receiptAddressTextField.keyboardType = UIKeyboardTypeDefault;
    _receiptAddressTextField.backgroundColor = [UIColor whiteColor];
    _receiptAddressTextField.borderStyle = UITextBorderStyleBezel;
    _receiptAddressTextField.enabled = NO;
    [self.view addSubview:_receiptAddressTextField];
    
    // 线
    _lineLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_H*0.55+25+64-64, SCREEN_W, 1)];
    _lineLabel3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_lineLabel3];
    
    // 代收
    UILabel * collectingLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, SCREEN_H*0.57+25+64-64, 40, 30)];
    collectingLabel.text = @"代收:";
    collectingLabel.font = [UIFont systemFontOfSize:14];
    collectingLabel.textColor = [UIColor blackColor];
    collectingLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:collectingLabel];
    
    _collectingTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, SCREEN_H*0.57+25+64-64, SCREEN_W*0.8, 30)];
    NSString * collectingStr = [NSString stringWithFormat:@"%@",self.orderMessageDataDic[@"price"]];
    _collectingTextField.text = [collectingStr stringByAppendingString:@"元"];
    _collectingTextField.font = hFontSize(12);
    _collectingTextField.textColor = [UIColor colorWithRed:0.243 green:0.246 blue:0.246 alpha:1.000];
    _collectingTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _collectingTextField.keyboardType = UIKeyboardTypeDefault;
    _collectingTextField.backgroundColor = [UIColor whiteColor];
    _collectingTextField.borderStyle = UITextBorderStyleBezel;
    _collectingTextField.enabled = NO;
    [self.view addSubview:_collectingTextField];
    
    NSArray * labelArray = @[@"件数:",@"运费:"];
    for (NSInteger index = 0; index < 2; index ++) {
        UILabel * collectingLabel = [[UILabel alloc] initWithFrame:CGRectMake(5+SCREEN_W/2*index, SCREEN_H*0.67+64-64, 40, 30)];
        collectingLabel.text = labelArray[index];
        collectingLabel.font = [UIFont systemFontOfSize:14];
        collectingLabel.textColor = [UIColor blackColor];
        collectingLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:collectingLabel];
    }
    
    _numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, SCREEN_H*0.67+64-64, SCREEN_W*0.3, 30)];
    NSString * numberStr = [NSString stringWithFormat:@"%@",self.orderMessageDataDic[@"number"]];
    _numberTextField.text = [numberStr stringByAppendingString:@"件"];
    _numberTextField.font = hFontSize(12);
    _numberTextField.textColor = [UIColor colorWithRed:0.243 green:0.246 blue:0.246 alpha:1.000];
    _numberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _numberTextField.keyboardType = UIKeyboardTypeDefault;
    _numberTextField.backgroundColor = [UIColor whiteColor];
    _numberTextField.borderStyle = UITextBorderStyleBezel;
    _numberTextField.enabled = NO;
    [self.view addSubview:_numberTextField];
    
    _moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(45+SCREEN_W/2, SCREEN_H*0.67+64-64, SCREEN_W*0.3, 30)];
    NSString * moneyStr = [NSString stringWithFormat:@"%@",self.orderMessageDataDic[@"freight"]];
    _moneyTextField.text = [moneyStr stringByAppendingString:@"元"];
    _moneyTextField.font = hFontSize(12);
    _moneyTextField.textColor = [UIColor colorWithRed:0.243 green:0.246 blue:0.246 alpha:1.000];
    _moneyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _moneyTextField.keyboardType = UIKeyboardTypeDefault;
    _moneyTextField.backgroundColor = [UIColor whiteColor];
    _moneyTextField.borderStyle = UITextBorderStyleBezel;
    _moneyTextField.enabled = NO;
    [self.view addSubview:_moneyTextField];
    
    _notesLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, SCREEN_H*0.72, SCREEN_W-10, SCREEN_H*0.1)];
    NSString * noteName = @"备注：";
    NSString * notesLabelStr = [noteName stringByAppendingString:self.orderMessageDataDic[@"remark"]];
    _notesLabel.text = notesLabelStr;
    _notesLabel.font = hFontSize(14);
    _notesLabel.textColor = ColorFontBlack;
    _notesLabel.numberOfLines = 0;
    //        _notesLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_notesLabel];
    
    _changeButton = [[UIButton alloc] initWithFrame:CGRectMake(30, SCREEN_H*0.84, SCREEN_W-60, SCREEN_H*0.06)];
    NSString * conditionNum = [NSString stringWithFormat:@"%@",self.orderMessageDataDic[@"condition"]];

    if ([conditionNum isEqualToString:@"3"]) {
        [_changeButton setTitle:@"已收账" forState:UIControlStateNormal];
        [_changeButton setBackgroundColor:[UIColor grayColor]];
    } else {
        [_changeButton setTitle:@"收账" forState:UIControlStateNormal];
        [_changeButton setBackgroundColor:RGBCOLOR(80, 152, 235)];
    }
    [_changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_changeButton addTarget:self action:@selector(changeOrderState) forControlEvents:UIControlEventTouchUpInside];

}


@end
