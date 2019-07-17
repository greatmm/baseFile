//
//  AppDelegate.m
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "AppDelegate.h"
#import "METabBarController.h"
#import "MEPushTool.h"
#import <IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setRootVc];
//    [self setUpJPushWithLaunchOptions:launchOptions];
    return YES;
}
//设置全局的键盘管理
- (void)setKeyboard
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = NO; // 是否显示占位文字
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}
//开启极光推送
- (void)setUpJPushWithLaunchOptions:(NSDictionary *)launchOptions
{
    [[MEPushTool sharePushTool] registerUserNotification];
    //处理远程通知启动 APP
    [[MEPushTool sharePushTool] receiveNotificationByLaunchingOptions:launchOptions];
    //推送通知
    [[MEPushTool sharePushTool] startJPushWithLaunchOptions:launchOptions];
}
- (void)listenNetWorkingStatus{
    
//    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
//
//    // Tell the reachability that we DON'T want to be reachable on 3G/EDGE/CDMA
//    reach.reachableOnWWAN = NO;
//
//    // Here we set up a NSNotification observer. The Reachability that caused the notification
//    // is passed in the object parameter
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(reachabilityChanged:)
//                                                 name:kReachabilityChangedNotification
//                                               object:nil];
//
//    [reach startNotifier];
   /*
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //开始监听
    [manager startMonitoring];
    //监听改变
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"--%ld--",status);
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
        }
    }];
//    [manager stopMonitoring];
    */
}
//设置window与根控制器
- (void)setRootVc
{
    self.window = [UIWindow new];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = [METabBarController new];
    [self.window makeKeyAndVisible];
}
//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[MEPushTool sharePushTool] registerDeviceToken:deviceToken];
}
/** APP已经接收到“远程”通知(推送) - (App运行在后台/App运行在前台) */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    //点击通知栏进入app ios10之前的处理
    if (kSystemVersion < 10.0) {
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            [[MEPushTool sharePushTool] receiveMessageWithUserInfo:userInfo];
        } else {
            [[MEPushTool sharePushTool] dealWithRemoteNotificationWithUserInfo:userInfo];
        }
    }
    completionHandler(UIBackgroundFetchResultNewData);
}
//注册通知失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
