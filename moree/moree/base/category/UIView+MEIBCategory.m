//
//  UIView+MEIBCategory.m
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "UIView+MEIBCategory.h"

@implementation UIView (MEIBCategory)

@dynamic borderC,borderW,cornerR;

- (void)setBorderW:(CGFloat)borderW
{
    self.layer.borderWidth = borderW;
}
- (void)setCornerR:(CGFloat)cornerR
{
    self.layer.cornerRadius = cornerR;
    self.layer.masksToBounds = true;
}
- (void)setBorderC:(UIColor *)borderC
{
    self.layer.borderColor = borderC.CGColor;
}

@end
