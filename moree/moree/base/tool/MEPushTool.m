//
//  MEPushTool.m
//  moree
//
//  Created by moyi on 2019/7/9.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MEPushTool.h"
#import <JPUSHService.h>
//#import <AdSupport/AdSupport.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface MEPushTool ()<JPUSHRegisterDelegate>

@property (nonatomic, assign) BOOL didEnterBackground;

@end

@implementation MEPushTool
+(instancetype)sharePushTool
{
    static MEPushTool * tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[MEPushTool alloc] init];
    });
    return tool;
}
-(instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:KKLoginNotification object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:KKLogoutNotification object:nil];
        
    }
    return self;
}

#pragma mark notification
-(void)appDidBecomeActive:(NSNotification *)noti
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService resetBadge];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.didEnterBackground = NO;
    });
}

-(void)appWillResignActive:(NSNotification *)noti
{
    
}
-(void)appDidEnterBackground:(NSNotification *)noti
{
    _didEnterBackground = YES;
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    [JPUSHService resetBadge];
}
#pragma mark 设置推送
-(void)startJPushWithLaunchOptions:(NSDictionary *)launchOptions
{
    //添加初始化APNs代码
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0,*)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    //添加初始化JPush代码
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
#warning 需要jPushAppKey,apsForProduction：测试环境写0，正式环境写1
    [JPUSHService setupWithOption:launchOptions appKey:@""
                          channel:@"appstore"
                 apsForProduction:0
            advertisingIdentifier:nil];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            self.registrationID = registrationID;
        } else {
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
}
-(void)registerDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
}
/** 注册用户通知 */
- (void)registerUserNotification{
    /*
     注册通知(推送)
     申请App需要接受来自服务商提供推送消息
     */
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        // 定义用户通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        // 定义用户通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        // 注册用户通知 - 根据用户通知设置
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}
#pragma mark tags/alies
//设置tags
- (void)jPushSetTags
{
    /*
    if ([KKDataTool token]) {
        [KKNetTool getBindAccountListSuccessBlock:^(NSDictionary *dic)
         {
             KKAutoArrayModel *model=[[KKAutoArrayModel alloc] initWithKey:@"d" bid:[KKBindingGamerModel class]];
             [model injectJSONData:dic];
             NSMutableArray *array=[@[] mutableCopy];
             for (KKBindingGamerModel *tmpData in model.arrayOutput) {
                 [array addObject:[tmpData getJPushInfo]];
                 
             }
             [self jPushSetTagsWithData:array];
         }erreorBlock:^(NSError *error)
         {
             
         }];
    }
    else
    {
        [self jPushSetTagsWithData:nil];
    }
     */
}
- (void)jPushSetTagsWithData:(NSArray *)tags
{
    NSSet *set=nil;
    if (tags) {
        set=[NSSet setWithArray:tags];
    }
    [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq){
        NSLog(@"JPUSHServiceSetTagResCode:%ld",(long)iResCode);
    } seq:1234];
}
- (void)jPushClearAlias:(void (^)(bool success,NSError *error))block
{
    
//    [KKNetTool postClearAliasSuccessBlock:^(NSDictionary *dic){
//        block(true,nil);
//    }erreorBlock:^(NSError *error) {
//        //重复3次
//        NSLog(@"清理别名失败 需要重复调用");
//        block(false,error);
//    }];
    
    
}
- (void)jPushSetAlias
{
//    NSString *str=[NSString stringWithFormat:@"u%@",[KKDataTool user].userId];
//    [JPUSHService setAlias:str completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq){
//        NSLog(@"JPUSHServiceSetAliseResCode:%ld",(long)iResCode);
//
//    } seq:1111];
}

#pragma mark 推送通知的处理
/** 自定义：APP被“推送”启动时处理推送消息处理（APP 未启动--》启动）*/
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions {
    if (nil == launchOptions)
        return;
    /*
     通过“远程推送”启动APP
     UIApplicationLaunchOptionsRemoteNotificationKey 远程推送Key
     */
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"\n>>>[Launching RemoteNotification]:%@", userInfo);
    }
}
-(BOOL)dealWithRemoteNotificationWithUserInfo:(NSDictionary *)userInfo
{
    UIApplicationState appState = [UIApplication sharedApplication].applicationState;
    if (appState == UIApplicationStateActive) {
        return NO;
    }
    NSLog(@"bzbzbz%@//dealWithRemoteNotificationWithUserInfo//",userInfo);
    return [self dealWithDictionary:userInfo[@"ext_message"]  type:MEPushNotificationBackground];
}

-(void)receiveMessageWithUserInfo:(NSDictionary *)userInfo
{
    NSLog(@"bzbzbz%@//receiveMessageWithUserInfo//",userInfo);
    [self dealWithDictionary:userInfo[@"ext_message"] type:MEPushNotificationForeground];
    
}
//透传
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    //接收到信息就进行逻辑
    NSDictionary * userInfo = [notification userInfo];
    NSLog(@"bzbzbz%@//networkDidReceiveMessage//",userInfo);
    [self dealWithDictionary:userInfo[@"content"] type:MEPushNotificationJPFNetwork];
}
//处理收到的消息
- (BOOL)dealWithDictionary:(NSDictionary *)dictioanry type:(MEPushType )type
{
    BOOL isDeal = NO;
    /*
    if ([HNUBZUtil checkStrEnable:dictioanry]) {
        dictioanry = [NSJSONSerialization JSONObjectWithData:[(NSString *)dictioanry dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }
    else if(![HNUBZUtil checkDictEnable:dictioanry])
    {
        return isDeal;
    }
    NSLog(@"bzbzbz%@//dealWithDictionary// type:%d",dictioanry,type);
    HNUPushModel *model=[[HNUPushModel alloc] initWithJSONDict:dictioanry];
    isDeal=true;
    switch (type) {
        case HNUPushNotificationBackground:
        {
            if (model.matchType==KKMatchTypeBattle) {
                [KKHouseTool enterRoomWithRoomid:model.matchid popToRootVC:NO];
            }
            if (model.matchType==KKMatchTypeChampionships) {
                [KKHouseTool enterChampionWihtCid:model.championid];
            }
            //后台进入 需要跳转到固定页面
        }
            break;
            
        default:
        {
            //            if ([KKDataTool shareTools].window) {
            //                <#statements#>
            //            }
            [[NSNotificationCenter defaultCenter] postNotificationName:KKViewNeedReloadNotification object:nil];
        }
            break;
    }
    __weak typeof(self) weakSelf = self;
    [self operateDelegate:^(id delegate) {
        if ([delegate respondsToSelector:@selector(pushManager:didReceivePushModel:type:)]) {
            [delegate pushManager:weakSelf didReceivePushModel:model type:type];
        }
    }];
     */
    return isDeal;
}
#pragma mark JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler API_AVAILABLE(ios(10.0)){
    // 前台收到信息逻辑 主要是站内通知
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSDictionary *userInfo = notification.request.content.userInfo;
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
        [self receiveMessageWithUserInfo:userInfo];
    }
    else {
        // 判断为本地通知
    }
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    // 后台点击逻辑
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    completionHandler();  // 系统要求执行这个方法
    [self dealWithRemoteNotificationWithUserInfo:userInfo];
}
// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}
@end
