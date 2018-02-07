//
//  PrintTool.m
//  晟开快线-业务员
//
//  Created by 胡隆海 on 18/1/22.
//  Copyright © 2018年 胡隆海. All rights reserved.
//

#import "PrintTool.h"

@implementation PrintTool

// 扫描打印机
- (void)scanStartEvent:(UIView *)printView {
    _connectPeripheral = nil;
    _uartLib = [[UartLib alloc] init];
    [_uartLib setUartDelegate:self];
    [MBProgressHUD showMessage:@"正在搜索附近蓝牙打印机" toView:printView];
    [_uartLib scanStart];
}

// 停止扫描打印机
- (void)scanStopEvent {
    [MBProgressHUD hideHUD];
    [_uartLib scanStop];
}

// 连接打印机
- (void)connectEvent1 {
    NSLog(@"连接蓝牙设备");
    [_uartLib connectPeripheral:_connectPeripheral];
}

// 断开链接打印机
- (void)disConnectEvent1 {
    [_uartLib scanStop];
    [_uartLib disconnectPeripheral:_connectPeripheral];
}

#pragma mark -- UartDelegate
/****************************************************************************/
/*                       UartDelegate Methods                        */
/****************************************************************************/
- (void) didScanedPeripherals:(NSMutableArray  *)foundPeripherals;
{
    NSLog(@"didScanedPeripherals扫描出的打印机数量：%lu", (unsigned long)[foundPeripherals count]);
    if ((unsigned long)[foundPeripherals count] != 0) {
        [self scanStopEvent]; // 停止扫描打印机
        _connectPeripheral = [foundPeripherals objectAtIndex:0];
        
    }
    CBPeripheral * peripheral;
    
    for (peripheral in foundPeripherals) {
        NSLog(@"--Peripheral打印机的名字:%@", [peripheral name]);
    }
    
    if ([foundPeripherals count] > 0) {
        
        if ([_connectPeripheral name] == nil) {
            NSLog(@"没有搜索到打印机");
        }else{
            // 扫描打印机成功
//            NSString * bluetoothStr  = @"搜索到蓝牙打印机：";
//            NSString * connectPeripheralName = [_connectPeripheral name];
//            NSString * bluetoothNameStr = [bluetoothStr stringByAppendingString:connectPeripheralName];
            
            [self connectEvent1]; // 扫描出来就开始打印
            
        }
    }else{
        _connectPeripheral = nil;
    }
}

- (void) didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"连接打印机成功");
    
    // 打印代收凭证·
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
        
    }
}


- (void) didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"断开连接");
    [self disConnectEvent1];
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
    
//    if (alertView == connectAlertView) {
        switch (buttonIndex) {
            case 0:
                NSLog(@"Cancel Button Pressed");
                [_uartLib scanStop];
                [_uartLib disconnectPeripheral:_connectPeripheral];
                break;
                
            default:
                break;
        }
//    }
    
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
    
    [_uartLib sendValue:_connectPeripheral sendData:cmdData type:CBCharacteristicWriteWithResponse];
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
        
        [_uartLib sendValue:_connectPeripheral sendData:data type:CBCharacteristicWriteWithResponse];
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
    
    [_uartLib sendValue:_connectPeripheral sendData:cmdData type:CBCharacteristicWriteWithResponse];
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
        
        [_uartLib sendValue:_connectPeripheral sendData:data type:CBCharacteristicWriteWithResponse];
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
    
    [_sendDataArray addObject:printFormat];
    
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
    
    [_sendDataArray addObject:printFormat];
    
    caPrintFmt[0] = 0x1b;
    caPrintFmt[1] = 0x40;
    
    //caPrintFmt[] = ;
    //caPrintFmt[] = ;
    printFormat = [NSData dataWithBytes:caPrintFmt length:2];
    NSLog(@"format:%@", printFormat);
    
    [_sendDataArray addObject:printFormat];
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
        
        [_sendDataArray addObject:subData];
    }
}


@end
