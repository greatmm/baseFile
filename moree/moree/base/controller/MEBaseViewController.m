//
//  MEBaseViewController.m
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MEBaseViewController.h"

@interface MEBaseViewController ()
@property(nonatomic,strong) NSMutableArray * urlMD5s;//所有请求的url的md5编码
@end

@implementation MEBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255.0)/255.0 green:arc4random_uniform(255.0)/255.0 blue:arc4random_uniform(255.0)/255.0 alpha:1];
}
-(NSMutableArray *)urlMD5s
{
    if (_urlMD5s) {
        return _urlMD5s;
    }
    _urlMD5s = [NSMutableArray new];
    return _urlMD5s;
}
-(void)dealloc
{
    NSLog(@"%@--%s--%d--",NSStringFromClass([self class]),__func__,__LINE__);
}
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    if (nil != _urlMD5s && self.urlMD5s.count > 0) {
       [[NSNotificationCenter defaultCenter] postNotificationName:MECancelNetWorkNotification object:nil userInfo:@{MECancelNetWorkKey:self.urlMD5s}];
    }
    [super dismissViewControllerAnimated:flag completion:completion];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"当前网络--%ld--", [MENetWorkTool networkStatus]);
}
@end
