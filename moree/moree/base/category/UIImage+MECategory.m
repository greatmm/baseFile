//
//  UIImage+MECategory.m
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "UIImage+MECategory.h"

@implementation UIImage (MECategory)
- (UIImage *)imageScaledToSize:(CGSize)size
{
    size.height/=self.scale;
    size.width/=self.scale;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
@end
