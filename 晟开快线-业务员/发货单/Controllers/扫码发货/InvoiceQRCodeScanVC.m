//
//  InvoiceQRCodeScanVC.m
//  晟开快线-业务员
//
//  Created by 胡隆海 on 17/12/5.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "InvoiceQRCodeScanVC.h"
#import <AVFoundation/AVFoundation.h>
#import "AccountMoneyViewController.h"

@interface InvoiceQRCodeScanVC ()<AVCaptureMetadataOutputObjectsDelegate>
//扫描框
@property (nonatomic, strong) UIView * view_bg;
//扫描线
@property (nonatomic, strong) CALayer * layer_scanLine;
//提示语
@property (nonatomic, strong) UILabel * lab_word;

@property (nonatomic, strong) NSTimer * timer;

//采集的设备
@property (nonatomic, strong) AVCaptureDevice * device;
//设备的输入
@property (nonatomic, strong) AVCaptureDeviceInput * input;
//输出
@property (nonatomic, strong) AVCaptureMetadataOutput * output;
//采集流
@property (nonatomic, strong) AVCaptureSession * session;
//窗口
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * previewLayer;
//扫描出的订单号
@property (nonatomic, strong) NSString * orderStr;

@end

@implementation InvoiceQRCodeScanVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"扫描发货";
        self.view.backgroundColor = ColorWhite;
        hSetBackButton(@"");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startScan];
}

#pragma mark - add subviews

- (void)addSubviews {
    
    [self.view addSubview:self.view_bg];
    
    [self.view addSubview:self.lab_word];
    
    [_view_bg.layer addSublayer:self.layer_scanLine];
    
}

#pragma mark - make constraints

- (void)makeConstraintsForUI {
    
    //    [_view_bg mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.size.mas_equalTo(CGSizeMake(0.7 * Screen_Width,  0.5 * (Screen_Height - 64)));
    //
    //        make.left.mas_equalTo(@(0.15 * Screen_Width));
    //
    //        make.top.mas_equalTo(@(0.25 * (Screen_Height - 64) - 32));
    //    }];
    //
    //    [_lab_word mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.size.mas_equalTo(CGSizeMake(Screen_Width, 21));
    //
    //        make.left.mas_equalTo(@0);
    //
    //        make.top.mas_equalTo(_view_bg.mas_bottom).with.offset(20);
    //    }];
    
    _view_bg.frame  = CGRectMake(SCREEN_W*0.15, SCREEN_H*0.2, SCREEN_W*0.7, SCREEN_H*0.5);
    _lab_word.frame = CGRectMake(SCREEN_W*0.1, SCREEN_H*0.81, SCREEN_W*0.8, 21);
    
}

#pragma mark - start saomiao

- (void)startScan {
    
    // Device 实例化设备   //获取摄像设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input 设备输入     //创建输入流
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    
    // Output 设备的输出  //创建输出流
    _output = [[AVCaptureMetadataOutput alloc] init];
    
    //设置代理   在主线程里刷新
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session         //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    // 二维码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode];
    
    // Preview 扫描窗口设置
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    _previewLayer.frame = CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64);
    
    _output.rectOfInterest = CGRectMake(0.15, 0.25, 0.7, 0.5);
    
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    //添加框和线
    [self addSubviews];
    
    [self makeConstraintsForUI];
    
    // Start 开始扫描   //开始捕获
    [_session startRunning];
    self.timer.fireDate = [NSDate distantPast];
    
}

#pragma mark - timer action

- (void)scanLineMove {
    
    CABasicAnimation * animation = [[CABasicAnimation alloc] init];
    
    //告诉系统要执行什么样的动画
    animation.keyPath = @"position";
    
    //设置通过动画  layer从哪到哪
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0.5 * (SCREEN_H - 64))];
    
    //动画时间
    animation.duration = 4.0;
    
    //设置动画执行完毕之后不删除动画
    animation.removedOnCompletion = NO;
    
    //设置保存动画的最新动态
    animation.fillMode = kCAFillModeForwards;
    
    //添加动画到layer
    [self.layer_scanLine addAnimation:animation forKey:nil];
    
}

#pragma mark - AVCaptureMetadataOutputObjects delegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    //得到解析到的结果
    NSString * stringValue;
    
    if (metadataObjects.count > 0) {
        
        AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects.firstObject;
        
        stringValue = metadataObject.stringValue;
    }
    
    NSArray * strArray = [stringValue componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
    if (strArray.count == 1) {
        
    } else {
        [Utils alertWithMessage:@"请勿扫描代收凭证联的二维码"];
        return;
    }
    
    //停止扫描
    [_session stopRunning];
    self.timer.fireDate = [NSDate distantFuture];
    
    // 跳转到收账界面
    // [self searchOrderData:stringValue];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"是否确定发货？" message:[NSString stringWithFormat:@"订单号：%@", stringValue] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_session startRunning];
        
        self.timer.fireDate = [NSDate distantPast];
        
    }];
    
    UIAlertAction * actioneReStart = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_previewLayer removeFromSuperlayer];
        
        [self.timer invalidate];
        
        _timer = nil;
        
        _orderStr = stringValue;
        
        [self accountRequestEvent]; // 进行发货
        
    }];
    
    
    [alertController addAction:actionCancel];
    
    [alertController addAction:actioneReStart];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - setter and getter

- (UIView *)view_bg {
    
    if (!_view_bg) {
        
        _view_bg = [[UIView alloc] init];
        
        _view_bg.layer.borderColor = [UIColor whiteColor].CGColor;
        
        _view_bg.layer.borderWidth = 1.0;
    }
    
    return _view_bg;
}

- (CALayer *)layer_scanLine {
    
    if (!_layer_scanLine) {
        
        CALayer * layer = [[CALayer alloc] init];
        
        layer.bounds = CGRectMake(0, 0, 0.7 * SCREEN_W, 1);
        
        layer.backgroundColor = [UIColor greenColor].CGColor;
        
        //起点
        layer.position = CGPointMake(0, 0);
        
        //定位点
        layer.anchorPoint = CGPointMake(0, 0);
        
        _layer_scanLine = layer;
    }
    
    return _layer_scanLine;
}

- (UILabel *)lab_word {
    
    if (!_lab_word) {
        
        _lab_word = [[UILabel alloc] init];
        
        _lab_word.textAlignment = NSTextAlignmentCenter;
        
        _lab_word.textColor = [UIColor whiteColor];
        
        _lab_word.font = hFontSize(13);
        
        _lab_word.text = @"将二维码/条码放入框内，即可进行扫描";
    }
    
    return _lab_word;
}

- (NSTimer *)timer {
    
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(scanLineMove) userInfo:nil repeats:YES];
        
        [_timer fire];
    }
    
    return _timer;
}

#pragma mark -- 收账的网络请求
- (void)accountRequestEvent {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:_orderStr      forKey:@"orderid"];
    NSLog(@"请求参数%@",params);
    [[HttpManage shareInstance] postLoadingUrlWithParmaeters:params Success:^(NSMutableDictionary *dic) {
        NSLog(@"收账返回数据：%@",dic);
        NSString * codeStr = [NSString stringWithFormat:@"%@",dic[@"code"]];
        NSString * message = [NSString stringWithFormat:@"%@",dic[@"message"]];
        if ([codeStr isEqualToString:@"1"]) {
            [Utils alertWithMessage:@"发货成功"];
            //创建一个消息对象 刷新交账界面
            NSDictionary * dict = @{@"functionNum":@"6"};
            //创建一个消息对象 在MainVC接收并再次请求数据
            NSNotification * notice = [NSNotification notificationWithName:@"refreshNotice" object:nil userInfo:dict];
            //发送消息
            NSLog(@"发送消息");
            [[NSNotificationCenter defaultCenter] postNotification:notice];
            [self startScan];
        } else {
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * actioneReStart = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self startScan];
            }];
            [alertController addAction:actioneReStart];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

@end
