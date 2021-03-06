//
//  AppDelegate.m
//  晟开快线-业务员
//
//  Created by 胡隆海 on 17/11/16.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self toLoginVc];
    //启动蒲公英更新检查SDK
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:@"a31bca4e260ef197a7c9cf06668ae4f3"];
    [[PgyUpdateManager sharedPgyManager] checkUpdate];
    [[PgyUpdateManager sharedPgyManager] updateLocalBuildNumber];
    
    // 接收通知
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，接收来自登录中心切换版本时候的通知
    [center addObserver:self selector:@selector(toMainVc) name:@"loginSuccess" object:nil];
    [center addObserver:self selector:@selector(toLoginVc) name:@"logoutSuccess" object:nil];
    [center addObserver:self selector:@selector(toLoginVc) name:@"loginFail" object:nil];
    return YES;
}

// 主界面
-(void)toMainVc{
    MainViewController * VC = [[MainViewController alloc]init];
    UINavigationController * NAV = [[UINavigationController alloc] initWithRootViewController:VC];
    NAV.navigationBar.barTintColor = ColorWhite;
    [NAV.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(42, 143, 240)}];
    self.window.rootViewController = NAV;
}

// 登录界面
- (void)toLoginVc {
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    UINavigationController * NAV = [[UINavigationController alloc] initWithRootViewController:loginVC];
    NAV.navigationBar.barTintColor = ColorWhite;
    [NAV.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(42, 143, 240)}];
    self.window.rootViewController = NAV;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"进入后台");
    //创建一个消息对象 通知界面正常
    NSNotification * notice = [NSNotification notificationWithName:@"applicationDidBecomeActive" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"进入前台");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"退出APP");
}




@end
