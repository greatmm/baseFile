//
//  MEShareTool.m
//  moree
//
//  Created by moyi on 2019/7/4.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MEShareTool.h"

@implementation MEShareTool
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType viewController:(UIViewController *)viewController
{
    
}
+ (void)shareWebPageWithPlatformType:(UMSocialPlatformType)platformType viewController:(UIViewController *)viewController title:(NSString *)title des:(NSString *)des webpageUrl:(NSString *)webpageUrl
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    NSString * nickName = @"赛事狗";
    NSString * t = [NSString stringWithFormat:@"%@邀请您到赛事狗一起参加电竞嘉年华啦~",nickName];
    NSString * d = @"天天参加锦标赛就得奖励，赛事狗就是这么实在";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:t descr:d thumImage:[UIImage imageNamed:@"shareIcon"]];
    NSString * w = @"https://www.matchgo.co/";
    w = [w stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];;
    //设置网页地址
    shareObject.webpageUrl = w;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:viewController completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"分享错误原因：%@",error);
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"分享结果:%@--%@",resp.message,resp.originalResponse);
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}
@end
