//
//  MBProgressHUD+NJ.m
//  NJWisdomCard
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import "MBProgressHUD+NJ.h"

@implementation MBProgressHUD (NJ)

/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.7];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

/**
 *  显示错误信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.labelText = message;
    // 隐藏时候从父控件中移除
    HUD.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    HUD.dimBackground = YES;
//    //1,设置背景框的透明度  默认0.8
//    HUD.opacity = 1;
//    //2,设置背景框的背景颜色和透明度， 设置背景颜色之后opacity属性的设置将会失效
//    HUD.color = [UIColor redColor];
//    HUD.color = [HUD.color colorWithAlphaComponent:1];
//    //3,设置背景框的圆角值，默认是10
//    HUD.cornerRadius = 20.0;
//    //4,设置提示信息 信息颜色，字体
//    HUD.labelColor = [UIColor blueColor];
//    HUD.labelFont = [UIFont systemFontOfSize:13];
//    HUD.labelText = @"Loading...";
//    //5,设置提示信息详情 详情颜色，字体
//    HUD.detailsLabelColor = [UIColor blueColor];
//    HUD.detailsLabelFont = [UIFont systemFontOfSize:13];
//    HUD.detailsLabelText = @"LoadingLoading...";
//    //6，设置菊花颜色  只能设置菊花的颜色
//    HUD.activityIndicatorColor = [UIColor blackColor];
//    //7,设置一个渐变层
//    HUD.dimBackground = YES;
//    //8,设置动画的模式
//    HUD.mode = MBProgressHUDModeIndeterminate;
//    //9，设置提示框的相对于父视图中心点的便宜，正值 向右下偏移，负值左上
//    HUD.xOffset = -80;
//    HUD.yOffset = -100;
//    //10，设置各个元素距离矩形边框的距离
//    HUD.margin = 0;
//    //11，背景框的最小大小
//    HUD.minSize = CGSizeMake(50, 50);
//    //12设置背景框的实际大小   readonly
//    CGSize size = HUD.size;
//    //13,是否强制背景框宽高相等
//    HUD.square = YES;
//    //14,设置显示和隐藏动画类型  有三种动画效果，如下
//    //    HUD.animationType = MBProgressHUDAnimationFade; //默认类型的，渐变
//    //    HUD.animationType = MBProgressHUDAnimationZoomOut; //HUD的整个view后退 然后逐渐的后退
//    HUD.animationType = MBProgressHUDAnimationZoomIn; //和上一个相反，前近，最后淡化消失
//    //15,设置最短显示时间，为了避免显示后立刻被隐藏   默认是0
//    //    HUD.minShowTime = 10;
//    //16,
//    /*
//     // 这个属性设置了一个宽限期，它是在没有显示HUD窗口前被调用方法可能运行的时间。
//     // 如果被调用方法在宽限期内执行完，则HUD不会被显示。
//     // 这主要是为了避免在执行很短的任务时，去显示一个HUD窗口。
//     // 默认值是0。只有当任务状态是已知时，才支持宽限期。具体我们看实现代码。
//     @property (assign) float graceTime;
//     
//     // 这是一个标识位，标明执行的操作正在处理中。这个属性是配合graceTime使用的。
//     // 如果没有设置graceTime，则这个标识是没有太大意义的。在使用showWhileExecuting:onTarget:withObject:animated:方法时，
//     // 会自动去设置这个属性为YES，其它情况下都需要我们自己手动设置。
//     @property (assign) BOOL taskInProgress;
//     */
//    //17,设置隐藏的时候是否从父视图中移除，默认是NO
//    HUD.removeFromSuperViewOnHide = NO;
//    //18,进度指示器  模式是0，取值从0.0————1.0
//    //    HUD.progress = 0.5;
//    //19,隐藏时候的回调 隐藏动画结束之后
//    HUD.completionBlock = ^(){
//        NSLog(@"abnnfsfsf");
//    };
    return HUD;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

@end
