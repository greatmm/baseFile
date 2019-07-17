//
//  MEAlert.m
//  moree
//
//  Created by moyi on 2019/7/4.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MEAlert.h"

#import <UIImage+GIF.h>

@implementation MEAlert

+(void)showAnimateWithText:(nullable NSString *)text toView:(UIView *)hudView
{
    MBProgressHUD * hud = [[self class] hudWithMode:MBProgressHUDModeIndeterminate hudView:hudView];
    if (text) {
        hud.label.text = text;
        hud.label.textColor = [UIColor redColor];
        hud.label.font = [UIFont systemFontOfSize:15];
    }
    [hud showAnimated:YES];
}

+(void)showAnimateWithText:(NSString *)text
{
    [[self class] showAnimateWithText:text toView:[UIApplication sharedApplication].keyWindow];
}

+(void)showAnimateWithView:(UIView *)hudView
{
    [[self class] showAnimateWithText:nil toView:hudView];
}

+(void)showAnimate
{
    [[self class] showAnimateWithText:nil];
}

+(void)showText:(NSString *)text toView:(UIView *)hudView
{
    MBProgressHUD * hud = [[self class] hudWithMode:MBProgressHUDModeText hudView:hudView];
    if (text != nil) {
        hud.label.text = text;
        hud.label.textColor = [UIColor redColor];
        hud.label.font = [UIFont systemFontOfSize:15];
    }
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.5];
}

+(void)showText:(NSString *)text
{
    [[self class] showText:text toView:[UIApplication sharedApplication].keyWindow];
}
//取消动画
+(void)dismissWithView:(UIView *)hudView
{
    [MBProgressHUD hideHUDForView:hudView animated:YES];
}
+(void)dismiss
{
    [[self class] dismissWithView:[UIApplication sharedApplication].keyWindow];
}
//返回一个指示器
+(MBProgressHUD *)hudWithMode:(MBProgressHUDMode)mode hudView:(UIView *)hudView
{
    MBProgressHUD * hud = [MBProgressHUD HUDForView:hudView];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:hudView animated:YES];
    }
    hud.mode = mode;
//    hud.bezelView.backgroundColor = [UIColor clearColor];
//    hud.removeFromSuperViewOnHide = YES;
//    hud.bezelView.backgroundColor = [UIColor colorWithWhite:153/255.0 alpha:1];
    return hud;
}
+(void)showAnimateWithGifImageWithView:(UIView *)hudView
{
    MBProgressHUD * hud = [[self class] hudWithMode:MBProgressHUDModeCustomView hudView:hudView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"load.gif" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_imageWithGIFData:data];
    UIImageView * imgView = [[UIImageView alloc] init];
    imgView.image = image;
    hud.customView = imgView;
    [hud showAnimated:true];
}
@end
