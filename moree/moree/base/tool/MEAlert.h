//
//  MEAlert.h
//  moree
//
//  Created by moyi on 2019/7/4.
//  Copyright © 2019 moreecare. All rights reserved.
//
#warning 缺图片及具体UI调整
#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MEAlert : NSObject
//不传view的默认显示在主window上
+(void)showAnimateWithText:(nullable NSString *)text toView:(UIView *)hudView;
+(void)showAnimateWithText:(nullable NSString *)text;
+(void)showAnimateWithView:(UIView *)hudView;
+(void)showAnimate;
+(void)showText:(NSString *)text toView:(UIView *)hudView;
+(void)showText:(NSString *)text;
+(void)dismissWithView:(UIView *)hudView;//消失
+(void)dismiss;//消失
+(MBProgressHUD *)hudWithMode:(MBProgressHUDMode)mode hudView:(UIView *)hudView;
@end

NS_ASSUME_NONNULL_END
