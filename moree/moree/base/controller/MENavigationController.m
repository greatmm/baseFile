//
//  MENavigationController.m
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MENavigationController.h"
#import <objc/message.h>
@interface MENavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation MENavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    self.navigationBar.translucent = false;
    //    self.navigationBar.shadowImage = [UIImage new];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.interactivePopGestureRecognizer.delegate = self;
    // 自带的边缘返回手势UIScreenEdgePanGestureRecognizer，但只负责edge部分。换成全屏的UIPanGestureRecognizer
//    object_setClass(self.interactivePopGestureRecognizer, [UIPanGestureRecognizer class]);
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)goBack
{
    [self popViewControllerAnimated:true];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController * vc = [super popViewControllerAnimated:animated];
    if (nil != vc) {
        [self dealCancelKeysWithVcs:@[vc]];
    }
    return vc;
}
- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray * arr = [super popToViewController:viewController animated:animated];
    [self dealCancelKeysWithVcs:arr];
    return arr;
}
- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    NSArray * arr = [super popToRootViewControllerAnimated:animated];
    [self dealCancelKeysWithVcs:arr];
    return arr;
}
- (void)dealCancelKeysWithVcs:(NSArray *)vcArr
{
    if (nil == vcArr) {
        return;
    }
    NSMutableArray * cancelKeys = [NSMutableArray new];
    for (UIViewController * vc in vcArr) {
        if ([vc isKindOfClass:NSClassFromString(@"MEBaseViewController")]) {
            NSArray * arr = [vc valueForKeyPath:@"urlMD5s"];
            if (arr && arr.count) {
                [cancelKeys addObjectsFromArray:arr];
            }
        }
    }
    if (cancelKeys.count) {
        [self postCancelNetworkNoti:cancelKeys];
    }
}
- (void)postCancelNetworkNoti:(NSArray *)cancelKeys
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MECancelNetWorkNotification object:nil userInfo:@{MECancelNetWorkKey:cancelKeys}];
}
@end
