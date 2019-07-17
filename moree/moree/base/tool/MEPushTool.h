//
//  MEPushTool.h
//  moree
//
//  Created by moyi on 2019/7/9.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MEPushTool;

typedef NS_ENUM(NSUInteger, MEPushType) {
    MEPushNotificationBackground = 0,//后台推送
    MEPushNotificationForeground,//前台推送
    MEPushNotificationJPFNetwork//透传
};
//推送代理
@protocol MEPushDelegate <NSObject>

@optional
-(void)pushTool:(MEPushTool *_Nullable)pushtool didReceivePushModel:(id _Nullable )pushModel type:(MEPushType)type;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MEPushTool : NSObject

@property (nonatomic, strong) NSString *registrationID;////极光推送 用来和设备绑定

+(instancetype)sharePushTool;

-(void)registerDeviceToken:(NSData *)deviceToken;

-(void)startJPushWithLaunchOptions:(NSDictionary *)launchOptions;
/**
 处理推送通知点击事件
 @param userInfo 推送信息的userInfo
 @return 内部是否处理该通知
 */
- (BOOL)dealWithRemoteNotificationWithUserInfo:(NSDictionary*)userInfo;
/**
 处理站内通知
 @param userInfo 推送信息的userInfo
 */
-(void)receiveMessageWithUserInfo:(NSDictionary *)userInfo;
/** 注册用户通知 */
- (void)registerUserNotification;
/**
 处理远程通知启动 APP
 */
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions;
/**
 *  绑定/清除别名功能:后台可以根据别名进行推送
 *
 *  @param alias 别名字符串
 */
//-(void)setJPushAlias:(NSString*)alias;
//设置tags
- (void)jPushSetTags;
//设置registrationID
@end

NS_ASSUME_NONNULL_END
