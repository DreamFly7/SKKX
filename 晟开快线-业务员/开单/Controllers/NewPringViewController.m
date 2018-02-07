//
//  NewPringViewController.m
//  晟开快线-业务员
//
//  Created by 胡隆海 on 18/1/22.
//  Copyright © 2018年 胡隆海. All rights reserved.
//

#import "NewPringViewController.h"
#import "UartLib.h"
#define MAX_CHARACTERISTIC_VALUE_SIZE 20

@interface NewPringViewController ()<UartDelegate>
{
    UartLib * uartLib;
    
    CBPeripheral   * connectPeripheral;
    
    UIAlertView    * connectAlertView;
    UIAlertView    * connectAlertView1;
    UIAlertView    * connectAlertView2;
    
    NSMutableArray * sendDataArray;
}
@property (nonatomic, strong) UILabel  * printerLabel;    // 打印机名字
@property (nonatomic, strong) UIButton * scanStartButton; // 扫描打印机
@property (nonatomic, strong) UIButton * scanStopButton;  // 停止扫描打印机
@property (nonatomic, strong) UIButton * printButton;     // 连接并打印
@property (nonatomic, strong) UIButton * disConnectButton;// 断开链接打印机

@property (nonatomic, strong) NSString * codeStr;


@end

@implementation NewPringViewController
//全局变量
static id _instance = nil;

//初始化方法
- (instancetype)init{
    // 只进行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"请搜索蓝牙打印机";
    [self createMainView];
    
    connectPeripheral = nil;
    
    uartLib = [[UartLib alloc] init];
    
    [uartLib setUartDelegate:self];
    
    connectAlertView2 = [[UIAlertView alloc] initWithTitle:@"打印" message: @"打印中...,请等待！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil,nil];
    connectAlertView1 = [[UIAlertView alloc] initWithTitle:@"扫描蓝牙设备" message: @"扫描中...,请等待！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil,nil];
    connectAlertView = [[UIAlertView alloc] initWithTitle:@"连接蓝牙设备" message: @"连接中...,请等待！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil,nil];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    sendDataArray = [[NSMutableArray alloc] init];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)0.02 target:self selector:@selector(sendDataTimer:) userInfo:nil repeats:YES];
    
}

- (void) sendDataTimer:(NSTimer *)timer {
    //NSLog(@"send data timer");
    
    if ([sendDataArray count] > 0) {
        NSData* cmdData;
        
        cmdData = [sendDataArray objectAtIndex:0];
        
        [uartLib sendValue:connectPeripheral sendData:cmdData type:CBCharacteristicWriteWithResponse];
        
        [sendDataArray removeObjectAtIndex:0];
    }
}

- (void)createMainView {
    
    _printerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_H*0.3, SCREEN_W, 30)];
    _printerLabel.font = hFontSize(16);
    _printerLabel.textAlignment = NSTextAlignmentCenter;
    _printerLabel.textColor = ColorFontBlack;
    _printerLabel.text = @"请搜索蓝牙打印机";
    [self.view addSubview:_printerLabel];
    
    _scanStartButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _scanStartButton.frame = CGRectMake(50, SCREEN_H*0.5, SCREEN_W-100, 40);
    _scanStartButton.layer.borderColor = [UIColor grayColor].CGColor;
    _scanStartButton.layer.borderWidth = 1;
    [_scanStartButton setTitle:@"扫描打印机" forState:UIControlStateNormal];
    [_scanStartButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _scanStartButton.backgroundColor = [UIColor clearColor];
    [_scanStartButton addTarget:self action:@selector(scanStartEvent1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_scanStartButton];
    
    _scanStopButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _scanStopButton.frame = CGRectMake(SCREEN_W*0.5+10, SCREEN_H*0.6, SCREEN_W*0.5-20, 30);
    _scanStopButton.layer.borderColor = [UIColor grayColor].CGColor;
    _scanStopButton.layer.borderWidth = 1;
    [_scanStopButton setTitle:@"停止扫描" forState:UIControlStateNormal];
    [_scanStopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _scanStopButton.backgroundColor = [UIColor clearColor];
    [_scanStopButton addTarget:self action:@selector(scanStopEvent) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_scanStopButton];
    
    _printButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _printButton.frame = CGRectMake(50, SCREEN_H*0.66, SCREEN_W-100, 40);
    _printButton.layer.borderColor = [UIColor grayColor].CGColor;
    _printButton.layer.borderWidth = 1;
    [_printButton setTitle:@"连接打印机" forState:UIControlStateNormal];
    [_printButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _printButton.backgroundColor = [UIColor clearColor];
    [_printButton addTarget:self action:@selector(connectEvent1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_printButton];
    
    _disConnectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _disConnectButton.frame = CGRectMake(50, SCREEN_H*0.8, SCREEN_W-100, 40);
    _disConnectButton.layer.borderColor = [UIColor grayColor].CGColor;
    _disConnectButton.layer.borderWidth = 1;
    [_disConnectButton setTitle:@"断开连接" forState:UIControlStateNormal];
    [_disConnectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _disConnectButton.backgroundColor = [UIColor clearColor];
    [_disConnectButton addTarget:self action:@selector(disConnectEvent1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_disConnectButton];
}

// 扫描打印机
- (void)scanStartEvent1 {
    NSLog(@"扫描打印机");
    [connectAlertView1 show];
    [uartLib scanStart];
}

// 停止扫描打印机
- (void)scanStopEvent {
    [uartLib scanStop];
}

// 连接打印机
- (void)connectEvent1 {
    NSLog(@"连接蓝牙设备");
    [connectAlertView show];
    [uartLib connectPeripheral:connectPeripheral];
    
}

// 断开链接打印机
- (void)disConnectEvent1 {
    NSLog(@"断开链接打印机");
    self.title = @"已断开连接";
    [uartLib disconnectPeripheral:connectPeripheral];
}

#pragma mark -- UartDelegate
/****************************************************************************/
/*                       UartDelegate Methods                        */
/****************************************************************************/
- (void) didScanedPeripherals:(NSMutableArray  *)foundPeripherals;
{
    [MBProgressHUD hideHUDForView:self.view];
    NSLog(@"didScanedPeripherals扫描出的打印机数量：%lu", (unsigned long)[foundPeripherals count]);
    if ((unsigned long)[foundPeripherals count] != 0) {
        [self scanStopEvent]; // 停止扫描打印机
        // 扫描打印机成功
        [connectAlertView1 dismissWithClickedButtonIndex:0 animated:YES]; // 警告框消失
        connectPeripheral = [foundPeripherals objectAtIndex:0];
    }
    CBPeripheral * peripheral;
    
    for (peripheral in foundPeripherals) {
        NSLog(@"--Peripheral打印机的名字:%@", [peripheral name]);
    }
    
    if ([foundPeripherals count] > 0) {
        
        if ([connectPeripheral name] == nil) {
            [[self printerLabel] setText:@"无打印机"];
        }else{
            // 扫描打印机成功
            [connectAlertView1 dismissWithClickedButtonIndex:0 animated:YES]; // 警告框消失
            NSString * bluetoothStr  = @"搜索到蓝牙打印机：";
            NSString * connectPeripheralName = [connectPeripheral name];
            NSString * bluetoothNameStr = [bluetoothStr stringByAppendingString:connectPeripheralName];
            [[self printerLabel] setText:bluetoothNameStr];
            self.title = bluetoothNameStr;
        }
    } else {
        [[self printerLabel] setText:nil];
        connectPeripheral = nil;
    }
}

- (void) didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"连接打印机成功");
    NSString * bluetoothStr  = @"成功连接到蓝牙打印机：";
    NSString * connectPeripheralName = [connectPeripheral name];
    NSString * bluetoothNameStr = [bluetoothStr stringByAppendingString:connectPeripheralName];
    [[self printerLabel] setText:bluetoothNameStr];
    self.title = bluetoothNameStr;
    [connectAlertView dismissWithClickedButtonIndex:0 animated:YES]; // 警告框消失
    // 连接打印机成功
    [[self printButton] setEnabled:TRUE];
    
}

- (void)dissmissConnectAlertView2 {
//    [self disConnectEvent1];
    [connectAlertView2 dismissWithClickedButtonIndex:0 animated:YES]; // 警告框消失
}

- (void) didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"断开连接");
    [self disConnectEvent1];
    //    [[self printButton] setEnabled:FALSE];
    [connectAlertView dismissWithClickedButtonIndex:0 animated:YES];
}

// 正在执行打印
- (void) didWriteData:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"didWriteData正在执行的打印机:%@", [peripheral name]);
}

- (void) didReceiveData:(CBPeripheral *)peripheral recvData:(NSData *)recvData
{
    NSLog(@"uart recv(%lu):%@", (unsigned long)[recvData length], recvData);
    [self promptDisplay:recvData];
}

- (void) didBluetoothPoweredOff{
    NSLog(@"手机蓝牙未开启");
}
- (void) didBluetoothPoweredOn{
    NSLog(@"蓝牙开启状态");
}

- (void) didRetrievePeripheral:(NSArray *)peripherals{
    NSLog(@"2222");
}

- (void) didRecvRSSI:(CBPeripheral *)peripheral RSSI:(NSNumber *)RSSI{
    NSLog(@"3333");
}
- (void) didDiscoverPeripheral:(CBPeripheral *)peripheral RSSI:(NSNumber *)RSSI{
    NSLog(@"4444");
}

- (void) didDiscoverPeripheralAndName:(CBPeripheral *)peripheral DevName:(NSString *)devName{
    NSLog(@"5555");
}

- (void) didrecvCustom:(CBPeripheral *)peripheral CustomerRight:(bool) bRight{
    NSLog(@"6666");
}


#pragma mark -- tools function
- (void) promptDisplay:(NSData *)recvData{
    
    NSString *hexStr=@"";
    
    hexStr = [[NSString alloc] initWithData:recvData encoding:NSASCIIStringEncoding];
    
}

#pragma mark -
#pragma mark UITextViewDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [textField resignFirstResponder];
    
    return YES;
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == connectAlertView) {
        switch (buttonIndex) {
            case 0:
                NSLog(@"Cancel Button Pressed");
                [uartLib scanStop];
                [uartLib disconnectPeripheral:connectPeripheral];
                break;
                
            default:
                break;
        }
    }
}


- (void)startPrint {
    // 打印代收凭证·
    _codeStr = [[_orderNumberStr stringByAppendingString:@","] stringByAppendingString:_randomStr];
    NSLog(@"有验证码的订单号：%@",_codeStr);
    if ([_codeStr isEqual:[NSNull null]]) {
        [Utils alertWithMessage:@"二维码数据有误，请重新打印"];
        return;
    }
    [self printContentData1];
    [self performSelector:@selector(printCredentials)       withObject:nil afterDelay:0.1f];
    [self performSelector:@selector(printNote)              withObject:nil afterDelay:0.15f];
    [self performSelector:@selector(printCodeQR)            withObject:nil afterDelay:0.2f];
    [self performSelector:@selector(printCustomer)          withObject:nil afterDelay:0.3f];
    [self performSelector:@selector(printInstructionsEvent) withObject:nil afterDelay:0.4f];
    [self performSelector:@selector(printContentDataNULL)   withObject:nil afterDelay:0.5f];
    [self performSelector:@selector(printLine)              withObject:nil afterDelay:0.6f];
    
    if ([_payWayStr isEqualToString:@"1"]) { // 寄付打印存根联
        // 打印存根联
        [self performSelector:@selector(printContentData1)      withObject:nil afterDelay:7.0f];
        [self performSelector:@selector(printStub)              withObject:nil afterDelay:7.1f];
        [self performSelector:@selector(printNote)              withObject:nil afterDelay:7.15f];
        [self performSelector:@selector(printQR)                withObject:nil afterDelay:7.2f];
        [self performSelector:@selector(printCustomer)          withObject:nil afterDelay:7.3f];
        [self performSelector:@selector(printContentDataNULL)   withObject:nil afterDelay:7.4f];
        [self performSelector:@selector(printLine)              withObject:nil afterDelay:7.5f];
        
        // 打印收货人签名
        [self performSelector:@selector(printContentData1)      withObject:nil afterDelay:12.0f];
        [self performSelector:@selector(printConsignee)         withObject:nil afterDelay:12.1f];
        [self performSelector:@selector(printNote)              withObject:nil afterDelay:12.15f];
        [self performSelector:@selector(printQR)                withObject:nil afterDelay:12.2f];
        [self performSelector:@selector(printCustomer)          withObject:nil afterDelay:12.3f];
        [self performSelector:@selector(printContentDataNULL)   withObject:nil afterDelay:12.4f];
        [self performSelector:@selector(printLine)              withObject:nil afterDelay:12.5f];
        
        // 打印客户存根联
        [self performSelector:@selector(printContentData1)      withObject:nil afterDelay:14.0f];
        [self performSelector:@selector(printCustomerStub)      withObject:nil afterDelay:14.1f];
        [self performSelector:@selector(printNote)              withObject:nil afterDelay:14.15f];
        [self performSelector:@selector(printQR)                withObject:nil afterDelay:14.2f];
        [self performSelector:@selector(printCustomer)          withObject:nil afterDelay:14.3f];
        [self performSelector:@selector(printContentDataNULL)   withObject:nil afterDelay:14.5f];
        [self performSelector:@selector(printLine)              withObject:nil afterDelay:14.6f];
        
//        [self performSelector:@selector(dissmissConnectAlertView2)  withObject:nil afterDelay:23.0f];
//        [self performSelector:@selector(backViewAction)             withObject:nil afterDelay:23.1f];
        
    } else {  // 到付
        // 打印收货人签名
        [self performSelector:@selector(printContentData1)      withObject:nil afterDelay:7.0f];
        [self performSelector:@selector(printConsignee)         withObject:nil afterDelay:7.1f];
        [self performSelector:@selector(printNote)              withObject:nil afterDelay:7.15f];
        [self performSelector:@selector(printQR)                withObject:nil afterDelay:7.2f];
        [self performSelector:@selector(printCustomer)          withObject:nil afterDelay:7.3f];
        [self performSelector:@selector(printContentDataNULL)   withObject:nil afterDelay:7.4f];
        [self performSelector:@selector(printLine)              withObject:nil afterDelay:7.5f];
        
        // 打印客户存根联
        [self performSelector:@selector(printContentData1)      withObject:nil afterDelay:9.0f];
        [self performSelector:@selector(printCustomerStub)      withObject:nil afterDelay:9.1f];
        [self performSelector:@selector(printNote)              withObject:nil afterDelay:9.15f];
        [self performSelector:@selector(printQR)                withObject:nil afterDelay:9.2f];
        [self performSelector:@selector(printCustomer)          withObject:nil afterDelay:9.3f];
        [self performSelector:@selector(printContentDataNULL)   withObject:nil afterDelay:9.5f];
        [self performSelector:@selector(printLine)              withObject:nil afterDelay:9.6f];
        
//        [self performSelector:@selector(dissmissConnectAlertView2)  withObject:nil afterDelay:18.0f];
//        [self performSelector:@selector(backViewAction)             withObject:nil afterDelay:18.1f];
    }
}

- (void)backViewAction {
    //创建一个消息对象 打印完成的时候返回到发货单界面
    NSNotification * notice = [NSNotification notificationWithName:@"returnFahuodan" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark -- 打印内容

// 打印客服电话
- (void)printCustomer {
    NSString * curPrintContent6 = @"客服电话：\n金通：89717901 88908366  新塘：89717790 88908355\n金恒德：0571-88908322    万品：0571-89717903\n投诉电话：15372038077    代收款查询：18968132297 ";
    if ([curPrintContent6 length]) {
        NSString *printed = [curPrintContent6 stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat2:printed];
    }
}

// 1.打印凭证
- (void)printCredentials {
    NSString * daiShouPingZhengStr = @"                   代收凭证\n";
    [self PrintWithFormat:daiShouPingZhengStr];
}

// 2.打印存根联
- (void)printStub {
    NSString * daiShouPingZhengStr = @"                    存根联\n";
    [self PrintWithFormat:daiShouPingZhengStr];
}

// 3.打印收货人签名
- (void)printConsignee {
    NSString * daiShouPingZhengStr = @"收货人(签名)：\n";
    [self PrintWithFormat:daiShouPingZhengStr];
}

// 4.打印客户存根联
- (void)printCustomerStub {
    NSString * daiShouPingZhengStr = @"                   客户存根联\n";
    [self PrintWithFormat:daiShouPingZhengStr];
}

// 5.打印备注
- (void)printNote {
    NSString * note = [NSString stringWithFormat:@"备注："];
    if (!(_noteStr == nil)) {
        NSString * curPrintContent66 = [note stringByAppendingFormat:@"%@",_noteStr];
        if ([curPrintContent66 length]) {
            NSString *printed = [curPrintContent66 stringByAppendingFormat:@"%c", '\n'];
            [self PrintWithFormat:printed];
        }
    } else {
        NSString * curPrintContent66 = [note stringByAppendingFormat:@"无"];
        if ([curPrintContent66 length]) {
            NSString *printed = [curPrintContent66 stringByAppendingFormat:@"%c", '\n'];
            [self PrintWithFormat:printed];
        }
    }
}

// 打印说明
- (void)printInstructionsEvent {
    NSString * instructions = instructionsStr;
    [self PrintWithFormat2:instructions];
}

// 打印空行
- (void)printContentDataNULL {
    
    NSString * curPrintContent = @"\n";
    if ([curPrintContent length]) {
        [self PrintWithFormat:curPrintContent];
    }
}
// 打印线条
- (void)printLine {
    NSString * curPrintContent = @"----------------------------------------------\n";
    if ([curPrintContent length]) {
        NSString *printed = [curPrintContent stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat:printed];
    }
}

// 打印1
- (void)printContentData1 {
    
    NSString * curPrintContent = @"\n                 晟开快线货运单";
    if ([curPrintContent length]) {
        NSString *printed = [curPrintContent stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat:printed];
    }
    
    NSString * curPrintContentTime = @"日期：";
    NSString * curPrintContentTime1 = [curPrintContentTime stringByAppendingString:_timeStr];
    NSString * curPrintContent2 = [curPrintContentTime1 stringByAppendingString:@"  制单人："];
    NSString * curPrintContent22 = [curPrintContent2 stringByAppendingString:_userNameStr];
    if ([curPrintContent22 length]) {
        NSString *printed = [curPrintContent22 stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat2:printed];
    }
    
    NSString * curPrintContent3 = @"始发地：";
    NSString * curPrintContent33 = [curPrintContent3 stringByAppendingString:_startCityStr];
    NSString * curPrintContent333 = [curPrintContent33 stringByAppendingString:@" - "];
    NSString * curPrintContent3333 = [curPrintContent333 stringByAppendingString:_endCityStr];
    
    NSString * curPrintContent1 = @"        单号：";
    NSString * curPrintContent11 = [curPrintContent1 stringByAppendingString:_orderNumberStr];
    NSString * curPrintContent111 = [curPrintContent3333 stringByAppendingString:curPrintContent11];
    
    if ([curPrintContent111 length]) {
        NSString * printed = [curPrintContent111 stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat:printed];
    }
    
    NSString * curPrintContent4 = @"发货方：";
    NSString * curPrintContent44      = [curPrintContent4 stringByAppendingString:_startCompanyStr];
    NSString * curPrintContent444     = [curPrintContent44 stringByAppendingString:@"        "];
    NSString * curPrintContent4444    = [curPrintContent444 stringByAppendingString:_startIphoneStr];
    NSString * curPrintContent44444   = [curPrintContent4444 stringByAppendingString:@"\n        "];
    NSString * curPrintContent444444  = [curPrintContent44444 stringByAppendingString:_startAddressStr];
    NSString * curPrintContent45      = [curPrintContent444444 stringByAppendingString:@"\n收货方："];
    NSString * curPrintContent455     = [curPrintContent45 stringByAppendingString:_endCompanyStr];
    NSString * curPrintContent4555    = [curPrintContent455 stringByAppendingString:@"        "];
    NSString * curPrintContent45555   = [curPrintContent4555 stringByAppendingString:_endIphoneStr];
    NSString * curPrintContent455555  = [curPrintContent45555 stringByAppendingString:@"\n        "];
    NSString * curPrintContent4555555 = [curPrintContent455555 stringByAppendingString:_endAddressStr];
    NSString * curPrintContent46      = [curPrintContent4555555 stringByAppendingString:@"\n件数："];
    NSString * curPrintContent466     = [curPrintContent46 stringByAppendingString:_numberStr];
    NSString * curPrintContent466666  = [curPrintContent466 stringByAppendingString:@"   代收："];
    NSString * curPrintContent4666666 = [curPrintContent466666 stringByAppendingString:_moneyStr];
    
    NSString * curPrintContent4666    = [curPrintContent4666666 stringByAppendingString:@"   运费："];
    NSString * curPrintContent46666   = [curPrintContent4666 stringByAppendingString:_freightStr];
    NSString * curPrintContent4666667 = [NSString stringWithFormat:@""];
    if ([_payWayStr isEqualToString:@"0"]) {
        curPrintContent4666667   = [curPrintContent46666 stringByAppendingString:@"   到付"];
    } else {
        curPrintContent4666667   = [curPrintContent46666 stringByAppendingString:@"   现付"];
    }
    
    if ([curPrintContent4666667 length]) {
        NSString *printed = [curPrintContent4666667 stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat:printed];
    }
    
    NSString * curPrintContent5 = @"                        合计：";
    NSString * curPrintContent55 = [curPrintContent5 stringByAppendingString:_moneySumStr];
    if ([curPrintContent55 length]) {
        NSString *printed = [curPrintContent55 stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat:printed];
    }
}

#pragma mark -- 打印代收单

- (void)printCollectionEvent {
    // 打印代收凭证·
    [self printContentData11];
    [self performSelector:@selector(printInstructionsEvent1) withObject:nil afterDelay:0.6f];
    [self performSelector:@selector(printLine1) withObject:nil afterDelay:1.1f];
    
    [self performSelector:@selector(printContentData22) withObject:nil afterDelay:4.0f];
    [self performSelector:@selector(printInstructionsEvent2) withObject:nil afterDelay:5.6f];
    [self performSelector:@selector(printLine1) withObject:nil afterDelay:6.2f];

}

// 打印说明
- (void)printInstructionsEvent1 {
    NSString * curPrintContent = @"                     客户联\n\n";
    NSString * instructions = [curPrintContent stringByAppendingFormat:daishouStr];
    [self PrintWithFormat2:instructions];
}

- (void)printInstructionsEvent2 {
    NSString * curPrintContent = @"                     存根联\n\n";
    NSString * instructions = [curPrintContent stringByAppendingFormat:daishouStr];
    [self PrintWithFormat2:instructions];
}

// 打印线条
- (void)printLine1 {
    NSString * curPrintContent = @"\n----------------------------------------------\n";
    if ([curPrintContent length]) {
        NSString *printed = [curPrintContent stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat:printed];
    }
}

// 打印1
- (void)printContentData11 {
    
    NSString * curPrintContent = @"\n           晟开快线代收款单据       NO_";
    NSString * cur1 = [curPrintContent stringByAppendingString:_idStr];
    if ([cur1 length]) {
        NSString * printed = [cur1 stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat:printed];
    }
    
    NSString * curPrintContentTime = @"开单员：";
    NSString * curPrintContentTime1 = [curPrintContentTime stringByAppendingString:_userName];
    NSString * curPrintContent2 = [curPrintContentTime1 stringByAppendingString:@"        日期："];
    NSString * curPrintContent22 = [curPrintContent2 stringByAppendingString:_dateStr];
    if ([curPrintContent22 length]) {
        NSString * printed = [curPrintContent22 stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat2:printed];
    }
    
    NSString * curPrintContent3 = @"开户银行：";
    NSString * curPrintContent33 = [curPrintContent3 stringByAppendingString:_bankName];
    
    NSString * curPrintContent1 = @"\n银行开户名：";
    NSString * curPrintContent11 = [curPrintContent1 stringByAppendingString:_bankUserName];
    NSString * curPrintContent111 = [curPrintContent33 stringByAppendingString:curPrintContent11];
    
    NSString * curPrintContent4 = @"\n银行卡号：";
    NSString * curPrintContent44 = [curPrintContent4 stringByAppendingString:_bankNumberStr];
    NSString * curPrintContent1111 = [curPrintContent111 stringByAppendingString:curPrintContent44];
    
    if ([curPrintContent1111 length]) {
        NSString * printed = [curPrintContent1111 stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat:printed];
    }
    
    NSString * curPrint5 = @"代收款金额：";
    NSString * curPrint55 = [curPrint5 stringByAppendingString:_moneyStr2];
    
    float floatNum = [_moneyStr2 floatValue]; // 原金额
    
    float poundage = floatNum*0.005;      // 手续费
    // 手续费 打款金额四舍五入
    int poundageInt = (int)(poundage+0.5);
    
    float newMoney = floatNum - poundageInt; // 打款金额
    int newMoneyInt = (int)newMoney;
    
    NSString * poundageStr = [NSString stringWithFormat:@"%d",poundageInt]; // 手续费
    NSString * newMoneyStr = [NSString stringWithFormat:@"%d",newMoneyInt]; // 打款金额
    
    NSString * curPrint6 = @"元          手续费：";
    NSString * curPrint66 = [curPrint6 stringByAppendingString:poundageStr];
    NSString * curPrint666 = [curPrint55 stringByAppendingString:curPrint66];
    
    NSString * curPrint7 = @"元\n                        结算金额：";
    NSString * curPrint77 = [curPrint7 stringByAppendingString:newMoneyStr];
    NSString * curPrint777 = [curPrint666 stringByAppendingString:curPrint77];
    
    if ([curPrint777 length]) {
        NSString * printed = [curPrint777 stringByAppendingFormat:@"元%c", '\n'];
        [self PrintWithFormat:printed];
    }
    
    NSString * curPrint8 = @"\n收款单位：";
    NSString * curPrint88 = [curPrint8 stringByAppendingString:@""];
    
    NSString * curPrint9 = @"\n\n收款单位电话：";
    NSString * curPrint99 = [curPrint9 stringByAppendingString:@""];
    NSString * curPrint999 = [curPrint88 stringByAppendingString:curPrint99];
    
    if ([curPrint999 length]) {
        NSString * printed = [curPrint999 stringByAppendingFormat:@"%c%c", '\n','\n'];
        [self PrintWithFormat2:printed];
    }
}

// 打印2
- (void)printContentData22 {
    
    NSString * curPrintContent = @"\n           晟开快线代收款单据       NO_";
    NSString * cur1 = [curPrintContent stringByAppendingString:_idStr];
    if ([cur1 length]) {
        NSString * printed = [cur1 stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat:printed];
    }
    
    NSString * curPrintContentTime = @"开单员：";
    NSString * curPrintContentTime1 = [curPrintContentTime stringByAppendingString:_userName];
    NSString * curPrintContent2 = [curPrintContentTime1 stringByAppendingString:@"        日期："];
    NSString * curPrintContent22 = [curPrintContent2 stringByAppendingString:_dateStr];
    if ([curPrintContent22 length]) {
        NSString * printed = [curPrintContent22 stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat2:printed];
    }
    
    NSString * curPrintContent3 = @"开户银行：";
    NSString * curPrintContent33 = [curPrintContent3 stringByAppendingString:_bankName];
    
    NSString * curPrintContent1 = @"\n银行开户名：";
    NSString * curPrintContent11 = [curPrintContent1 stringByAppendingString:_bankUserName];
    NSString * curPrintContent111 = [curPrintContent33 stringByAppendingString:curPrintContent11];
    
    NSString * curPrintContent4 = @"\n银行卡号：";
    NSString * curPrintContent44 = [curPrintContent4 stringByAppendingString:_bankNumberStr];
    NSString * curPrintContent1111 = [curPrintContent111 stringByAppendingString:curPrintContent44];
    
    if ([curPrintContent1111 length]) {
        NSString * printed = [curPrintContent1111 stringByAppendingFormat:@"%c", '\n'];
        [self PrintWithFormat:printed];
    }
    
    NSString * curPrint5 = @"代收款金额：";
    NSString * curPrint55 = [curPrint5 stringByAppendingString:_moneyStr2];
    
    float floatNum = [_moneyStr2 floatValue];
    
    float poundage = floatNum*0.005;      // 手续费
    // 手续费 打款金额四舍五入
    int poundageInt = (int)(poundage+0.5);
    
    float newMoney = floatNum - poundageInt; // 打款金额
    int newMoneyInt = (int)newMoney;
    
    NSString * poundageStr = [NSString stringWithFormat:@"%d",poundageInt]; // 手续费
    NSString * newMoneyStr = [NSString stringWithFormat:@"%d",newMoneyInt]; // 打款金额
    
    NSString * curPrint6 = @"元          手续费：";
    NSString * curPrint66 = [curPrint6 stringByAppendingString:poundageStr];
    NSString * curPrint666 = [curPrint55 stringByAppendingString:curPrint66];
    
    NSString * curPrint7 = @"元\n                        结算金额：";
    NSString * curPrint77 = [curPrint7 stringByAppendingString:newMoneyStr];
    NSString * curPrint777 = [curPrint666 stringByAppendingString:curPrint77];
    
    if ([curPrint777 length]) {
        NSString * printed = [curPrint777 stringByAppendingFormat:@"元%c", '\n'];
        [self PrintWithFormat:printed];
    }
    
    NSString * curPrint8 = @"\n收款单位：";
    NSString * curPrint88 = [curPrint8 stringByAppendingString:@""];
    
    NSString * curPrint9 = @"\n\n收款单位电话：";
    NSString * curPrint99 = [curPrint9 stringByAppendingString:@""];
    NSString * curPrint999 = [curPrint88 stringByAppendingString:curPrint99];
    
    NSString * curPrint0 = @"\n                        签字：";
    NSString * curPrint00 = [curPrint0 stringByAppendingString:@""];
    NSString * curPrint000 = [curPrint999 stringByAppendingString:curPrint00];
    
    if ([curPrint000 length]) {
        NSString * printed = [curPrint000 stringByAppendingFormat:@"%c%c", '\n','\n'];
        [self PrintWithFormat2:printed];
    }
}

// 大字体
- (void) PrintWithFormat:(NSString *)printContent{
#define MAX_CHARACTERISTIC_VALUE_SIZE 20
    NSData  *data	= nil;
    NSUInteger i;
    NSUInteger strLength;
    NSUInteger cellCount;
    NSUInteger cellMin;
    NSUInteger cellLen;
    
    Byte caPrintFmt[5];
    
    /*初始化命令：ESC @ 即0x1b,0x40*/
    caPrintFmt[0] = 0x1b;
    caPrintFmt[1] = 0x40;
    
    /*字符设置命令：ESC ! n即0x1b,0x21,n*/
    caPrintFmt[2] = 0x1b;
    caPrintFmt[3] = 0x21;
    
    //    caPrintFmt[4] = 0x18;
    caPrintFmt[4] = 0x18;
    //    caPrintFmt[5] = 0x18;
    //    caPrintFmt[6] = 0x18;
    
    NSData *cmdData =[[NSData alloc] initWithBytes:caPrintFmt length:5];
    
    [uartLib sendValue:connectPeripheral sendData:cmdData type:CBCharacteristicWriteWithResponse];
    NSLog(@"format:%@", cmdData);
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //NSData *data = [curPrintContent dataUsingEncoding:enc];
    //NSLog(@"dd:%@", data);
    //NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    //NSLog(@"str:%@", retStr);
    
    strLength = [printContent length];
    if (strLength < 1) {
        return;
    }
    
    cellCount = (strLength%MAX_CHARACTERISTIC_VALUE_SIZE)?(strLength/MAX_CHARACTERISTIC_VALUE_SIZE + 1):(strLength/MAX_CHARACTERISTIC_VALUE_SIZE);
    for (i=0; i<cellCount; i++) {
        cellMin = i*MAX_CHARACTERISTIC_VALUE_SIZE;
        if (cellMin + MAX_CHARACTERISTIC_VALUE_SIZE > strLength) {
            cellLen = strLength-cellMin;
        }
        else {
            cellLen = MAX_CHARACTERISTIC_VALUE_SIZE;
        }
        
        //NSLog(@"print:%d,%d,%d,%d", strLength,cellCount, cellMin, cellLen);
        NSRange rang = NSMakeRange(cellMin, cellLen);
        NSString *strRang = [printContent substringWithRange:rang];
        NSLog(@"print:%@", strRang);
        
        data = [strRang dataUsingEncoding: enc];
        //data = [strRang dataUsingEncoding: NSUTF8StringEncoding];
        NSLog(@"print:%@", data);
        //data = [strRang dataUsingEncoding: NSUTF8StringEncoding];
        //NSLog(@"print:%@", data);
        
        [uartLib sendValue:connectPeripheral sendData:data type:CBCharacteristicWriteWithResponse];
    }
}

//原字体
- (void) PrintWithFormat2:(NSString *)printContent{
#define MAX_CHARACTERISTIC_VALUE_SIZE 20
    NSData  *data	= nil;
    NSUInteger i;
    NSUInteger strLength;
    NSUInteger cellCount;
    NSUInteger cellMin;
    NSUInteger cellLen;
    
    Byte caPrintFmt[5];
    
    /*初始化命令：ESC @ 即0x1b,0x40*/
    caPrintFmt[0] = 0x1b;
    caPrintFmt[1] = 0x40;
    
    /*字符设置命令：ESC ! n即0x1b,0x21,n*/
    caPrintFmt[2] = 0x1b;
    caPrintFmt[3] = 0x21;
    
    caPrintFmt[4] = 0x00;
    
    NSData *cmdData =[[NSData alloc] initWithBytes:caPrintFmt length:5];
    
    [uartLib sendValue:connectPeripheral sendData:cmdData type:CBCharacteristicWriteWithResponse];
    NSLog(@"format:%@", cmdData);
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //NSData *data = [curPrintContent dataUsingEncoding:enc];
    //NSLog(@"dd:%@", data);
    //NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    //NSLog(@"str:%@", retStr);
    
    strLength = [printContent length];
    if (strLength < 1) {
        return;
    }
    
    cellCount = (strLength%MAX_CHARACTERISTIC_VALUE_SIZE)?(strLength/MAX_CHARACTERISTIC_VALUE_SIZE + 1):(strLength/MAX_CHARACTERISTIC_VALUE_SIZE);
    for (i=0; i<cellCount; i++) {
        cellMin = i*MAX_CHARACTERISTIC_VALUE_SIZE;
        if (cellMin + MAX_CHARACTERISTIC_VALUE_SIZE > strLength) {
            cellLen = strLength-cellMin;
        }
        else {
            cellLen = MAX_CHARACTERISTIC_VALUE_SIZE;
        }
        
        //NSLog(@"print:%d,%d,%d,%d", strLength,cellCount, cellMin, cellLen);
        NSRange rang = NSMakeRange(cellMin, cellLen);
        NSString *strRang = [printContent substringWithRange:rang];
        NSLog(@"print:%@", strRang);
        
        data = [strRang dataUsingEncoding: enc];
        
        //data = [strRang dataUsingEncoding: NSUTF8StringEncoding];
        NSLog(@"print:%@", data);
        //data = [strRang dataUsingEncoding: NSUTF8StringEncoding];
        //NSLog(@"print:%@", data);
        
        [uartLib sendValue:connectPeripheral sendData:data type:CBCharacteristicWriteWithResponse];
    }
}
// 打印二维码
- (void)printQR {
    // 打印二维码
    [self printTwoDimenCode:_orderNumberStr];
}

// 打印二维码 多一个验证码
- (void)printCodeQR {
    // 打印二维码
    [self printTwoDimenCode:_codeStr];
}

- (void) printTwoDimenCode:(NSString *)printContent{
    NSData *printFormat;
    Byte caPrintFmt[500];
    
    caPrintFmt[0] = 0x1b;
    caPrintFmt[1] = 0x40;
    caPrintFmt[2] = 0x1d;
    caPrintFmt[3] = 0x28;
    caPrintFmt[4] = 0x6b;
    caPrintFmt[5] = 0x03;
    caPrintFmt[6] = 0x00;
    caPrintFmt[7] = 0x31;
    caPrintFmt[8] = 0x43;
    caPrintFmt[9] = 0x08;
    caPrintFmt[10] = 0x1d;
    caPrintFmt[11] = 0x28;
    caPrintFmt[12] = 0x6b;
    caPrintFmt[13] = 0x03;
    caPrintFmt[14] = 0x00;
    caPrintFmt[15] = 0x31;
    caPrintFmt[16] = 0x45;
    caPrintFmt[17] = 0x30;
    
    //caPrintFmt[] = ;
    //caPrintFmt[] = ;
    printFormat = [NSData dataWithBytes:caPrintFmt length:18];
    NSLog(@"format:%@", printFormat);
    
    [sendDataArray addObject:printFormat];
    
    NSInteger nLength = [printContent length];
    nLength += 3;
    
    caPrintFmt[0] = 0x1d;
    caPrintFmt[1] = 0x28;
    caPrintFmt[2] = 0x6b;
    caPrintFmt[3] = nLength & 0xFF;
    caPrintFmt[4] = (nLength >> 8) & 0xFF;
    caPrintFmt[5] = 0x31;
    caPrintFmt[6] = 0x50;
    caPrintFmt[7] = 0x30;
    
    NSData *printData = [printContent dataUsingEncoding: NSASCIIStringEncoding];
    Byte *printByte = (Byte *)[printData bytes];
    
    nLength -= 3;
    for (int  i = 0; i<nLength; i++) {
        caPrintFmt[8+i] = *(printByte+i);
    }
    
    printFormat = [NSData dataWithBytes:caPrintFmt length:nLength+8];
    
    NSLog(@"format:%@", printFormat);
    
    [self printLongData:printFormat];
    //[sendDataArray addObject:printFormat];
    
    caPrintFmt[0] = 0x1b;
    caPrintFmt[1] = 0x61;
    caPrintFmt[2] = 0x01;
    caPrintFmt[3] = 0x1d;
    caPrintFmt[4] = 0x28;
    caPrintFmt[5] = 0x6b;
    caPrintFmt[6] = 0x03;
    caPrintFmt[7] = 0x00;
    caPrintFmt[8] = 0x31;
    caPrintFmt[9] = 0x52;
    caPrintFmt[10] = 0x30;
    caPrintFmt[11] = 0x1d;
    caPrintFmt[12] = 0x28;
    caPrintFmt[13] = 0x6b;
    caPrintFmt[14] = 0x03;
    caPrintFmt[15] = 0x00;
    caPrintFmt[16] = 0x31;
    caPrintFmt[17] = 0x51;
    caPrintFmt[18] = 0x30;
    
    //caPrintFmt[] = ;
    //caPrintFmt[] = ;
    printFormat = [NSData dataWithBytes:caPrintFmt length:19];
    NSLog(@"format:%@", printFormat);
    
    [sendDataArray addObject:printFormat];
    
    caPrintFmt[0] = 0x1b;
    caPrintFmt[1] = 0x40;
    
    //caPrintFmt[] = ;
    //caPrintFmt[] = ;
    printFormat = [NSData dataWithBytes:caPrintFmt length:2];
    NSLog(@"format:%@", printFormat);
    
    [sendDataArray addObject:printFormat];
}

- (void) printLongData:(NSData *)printContent{
    NSUInteger i;
    NSUInteger strLength;
    NSUInteger cellCount;
    NSUInteger cellMin;
    NSUInteger cellLen;
    
    strLength = [printContent length];
    if (strLength < 1) {
        return;
    }
    
    cellCount = (strLength%MAX_CHARACTERISTIC_VALUE_SIZE)?(strLength/MAX_CHARACTERISTIC_VALUE_SIZE + 1):(strLength/MAX_CHARACTERISTIC_VALUE_SIZE);
    for (i=0; i<cellCount; i++) {
        cellMin = i*MAX_CHARACTERISTIC_VALUE_SIZE;
        if (cellMin + MAX_CHARACTERISTIC_VALUE_SIZE > strLength) {
            cellLen = strLength-cellMin;
        }
        else {
            cellLen = MAX_CHARACTERISTIC_VALUE_SIZE;
        }
        
        NSLog(@"print:%lu,%lu,%lu,%lu", (unsigned long)strLength,(unsigned long)cellCount, (unsigned long)cellMin, (unsigned long)cellLen);
        NSRange rang = NSMakeRange(cellMin, cellLen);
        NSData *subData = [printContent subdataWithRange:rang];
        
        NSLog(@"print:%@", subData);
        //data = [strRang dataUsingEncoding: NSUTF8StringEncoding];
        //NSLog(@"print:%@", data);
        
        [sendDataArray addObject:subData];
    }
}




@end
