//
//  CollectionPrintViewController.m
//  晟开快线-业务员
//
//  Created by 胡隆海 on 18/1/5.
//  Copyright © 2018年 胡隆海. All rights reserved.
//

#import "CollectionPrintViewController.h"
#import "UartLib.h"
#define MAX_CHARACTERISTIC_VALUE_SIZE 20
@interface CollectionPrintViewController ()<UartDelegate>
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

@implementation CollectionPrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"打印订单";
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
    
    //开始扫描蓝牙设备
    [self scanStartEvent];
    [connectAlertView1 show];
    
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
    [self.view addSubview:_printerLabel];
    
    _scanStartButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _scanStartButton.frame = CGRectMake(50, SCREEN_H*0.5, SCREEN_W-100, 40);
    _scanStartButton.layer.borderColor = [UIColor grayColor].CGColor;
    _scanStartButton.layer.borderWidth = 1;
    [_scanStartButton setTitle:@"扫描打印机" forState:UIControlStateNormal];
    [_scanStartButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _scanStartButton.backgroundColor = [UIColor clearColor];
    [_scanStartButton addTarget:self action:@selector(scanStartEvent) forControlEvents:UIControlEventTouchUpInside];
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
    [_printButton setTitle:@"连接打印" forState:UIControlStateNormal];
    [_printButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _printButton.backgroundColor = [UIColor clearColor];
    [_printButton addTarget:self action:@selector(connectEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_printButton];
    
    _disConnectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _disConnectButton.frame = CGRectMake(50, SCREEN_H*0.8, SCREEN_W-100, 40);
    _disConnectButton.layer.borderColor = [UIColor grayColor].CGColor;
    _disConnectButton.layer.borderWidth = 1;
    [_disConnectButton setTitle:@"断开连接" forState:UIControlStateNormal];
    [_disConnectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _disConnectButton.backgroundColor = [UIColor clearColor];
    [_disConnectButton addTarget:self action:@selector(disConnectEvent) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:_disConnectButton];
}

// 扫描打印机
- (void)scanStartEvent {
    [MBProgressHUD showMessage:@"正在搜索附近蓝牙打印机" toView:self.view];
    [uartLib scanStart];
}

// 停止扫描打印机
- (void)scanStopEvent {
    NSLog(@"停止扫描打印机");
    [uartLib scanStop];
}

// 连接打印机
- (void)connectEvent {
    NSLog(@"连接蓝牙设备");
    [uartLib connectPeripheral:connectPeripheral];
    [connectAlertView show];
    
}

// 断开链接打印机
- (void)disConnectEvent {
    NSLog(@"断开打印机");
//    [uartLib scanStop];
//    [uartLib disconnectPeripheral:connectPeripheral];
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
            
        }
    }else{
        [[self printerLabel] setText:nil];
        connectPeripheral = nil;
    }
}

- (void) didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"连接打印机成功");
    // 连接打印机成功
    [[self printButton] setEnabled:TRUE];
    [connectAlertView dismissWithClickedButtonIndex:0 animated:YES];
    [connectAlertView2 show];
    
    // 打印代收凭证·
    [self printContentData11];
    [self performSelector:@selector(printInstructionsEvent1) withObject:nil afterDelay:0.6f];
    [self performSelector:@selector(printLine1) withObject:nil afterDelay:1.1f];
    
    [self performSelector:@selector(printContentData22) withObject:nil afterDelay:4.0f];
    [self performSelector:@selector(printInstructionsEvent2) withObject:nil afterDelay:5.6f];
    [self performSelector:@selector(printLine1) withObject:nil afterDelay:6.2f];
    
    [self performSelector:@selector(dissmissConnectAlertView22)  withObject:nil afterDelay:10.0f];
    [self performSelector:@selector(backViewAction1)              withObject:nil afterDelay:10.1f];

}

- (void)backViewAction1 {
    //创建一个消息对象 打印完成的时候返回到发货单界面
    NSNotification * notice = [NSNotification notificationWithName:@"returnDaiShou" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)dissmissConnectAlertView22 {
    [self disConnectEvent];
    [connectAlertView2 dismissWithClickedButtonIndex:0 animated:YES]; // 警告框消失
}

- (void) didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"断开连接");
    [self disConnectEvent];
    //    [[self printButton] setEnabled:FALSE];
    [[self printerLabel] setText:@""];
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

#pragma mark -- tools function
- (void) promptDisplay:(NSData *)recvData{
    //    NSString *prompt;
    
    NSString *hexStr=@"";
    
    hexStr = [[NSString alloc] initWithData:recvData encoding:NSASCIIStringEncoding];
}

- (void) didBluetoothPoweredOff{
    //    [[[UIAlertView alloc] initWithTitle:@"蓝牙" message: @"手机蓝牙未打开" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil] show];
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

#pragma mark -- 打印内容

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
    NSString * curPrint55 = [curPrint5 stringByAppendingString:_moneyStr];
    
    float floatNum = [_moneyStr floatValue];
    float poundage = floatNum*0.005;      // 手续费
    float newMoney = floatNum - poundage; // 打款金额
    NSString * poundageStr = [NSString stringWithFormat:@"%.3f",poundage]; // 手续费
    NSString * newMoneyStr = [NSString stringWithFormat:@"%.3f",newMoney]; // 打款金额
    
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
    NSString * curPrint55 = [curPrint5 stringByAppendingString:_moneyStr];
    
    float floatNum = [_moneyStr floatValue];
    float poundage = floatNum*0.005;      // 手续费
    float newMoney = floatNum - poundage; // 打款金额
    NSString * poundageStr = [NSString stringWithFormat:@"%.3f",poundage]; // 手续费
    NSString * newMoneyStr = [NSString stringWithFormat:@"%.3f",newMoney]; // 打款金额
    
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

@end
