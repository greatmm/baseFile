//
//  METabBarController.m
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "METabBarController.h"
#import "MENavigationController.h"
@interface METabBarController ()

@end

@implementation METabBarController
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont boldSystemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
    item.titlePositionAdjustment = UIOffsetMake(0, -5);
    //    item.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildViewControllerWithArr:@[@{@"vcName":@"MEHomePageViewController",@"title":@"首页",@"imageName":@"homepage",@"selImageName":@"homepage_sel"},
  @{@"vcName":@"MEExaminationRoomViewController",@"title":@"考场",@"imageName":@"homepage",@"selImageName":@"homepage_sel"},
  @{@"vcName":@"MEQuestionBankViewController",@"title":@"题库",@"imageName":@"homepage",@"selImageName":@"homepage_sel"},
  @{@"vcName":@"MEBookStoreViewController",@"title":@"书城",@"imageName":@"homepage",@"selImageName":@"homepage_sel"},
  @{@"vcName":@"MEPersonalCenterViewController",@"title":@"个人中心",@"imageName":@"homepage",@"selImageName":@"homepage_sel"}]];
}
- (void)setupAllChildViewControllerWithArr:(NSArray *)vcArr
{
    for (NSDictionary * dict in vcArr) {
        UIViewController * vc = [NSClassFromString(dict[@"vcName"]) new];
        MENavigationController * nv = [[MENavigationController alloc] initWithRootViewController:vc];
        nv.tabBarItem.title = dict[@"title"];
        nv.tabBarItem.image = [UIImage imageNamed:dict[@"imageName"]];
        nv.tabBarItem.selectedImage = [UIImage imageNamed:dict[@"selImageName"]];
        [self addChildViewController:nv];
    }
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
//    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    return true;
}


@end
