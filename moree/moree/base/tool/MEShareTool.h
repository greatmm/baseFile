//
//  MEShareTool.h
//  moree
//
//  Created by moyi on 2019/7/4.
//  Copyright © 2019 moreecare. All rights reserved.
//

//分享
#import <Foundation/Foundation.h>
#import <UMShare/UMShare.h>
NS_ASSUME_NONNULL_BEGIN

@interface MEShareTool : NSObject
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType viewController:(UIViewController *)viewController;
+ (void)shareWebPageWithPlatformType:(UMSocialPlatformType)platformType viewController:(UIViewController *)viewController title:(NSString *)title des:(NSString *)des webpageUrl:(NSString *)webpageUrl;
@end

NS_ASSUME_NONNULL_END
