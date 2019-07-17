//
//  MESegmentedControlViewController.h
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//
//分段控制控制器
#import "MEBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MESegmentedControlViewController : MEBaseViewController
@property(nonatomic,strong) NSArray * childVcNames;//子控制器名称数组
@property(nonatomic,strong) NSArray * btnTitles;//顶部按钮标题数组

@end

NS_ASSUME_NONNULL_END
