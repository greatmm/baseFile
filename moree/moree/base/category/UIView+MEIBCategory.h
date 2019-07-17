//
//  UIView+MEIBCategory.h
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MEIBCategory)

@property (nonatomic, assign) IBInspectable CGFloat borderW;
@property (nonatomic, assign) IBInspectable CGFloat cornerR;
@property (nonatomic, strong) IBInspectable UIColor * borderC;

@end

NS_ASSUME_NONNULL_END
