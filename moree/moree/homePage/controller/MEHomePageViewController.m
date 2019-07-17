//
//  MEHomePageViewController.m
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MEHomePageViewController.h"
//#import "MEPlayerViewController.h"
#import "MESegmentedControlViewController.h"
@interface MEHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableView;
@end

@implementation MEHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    /*
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
//        if (@available(iOS 11.0, *)) {
//            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
//            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
//        } else {
//            make.top.bottom.mas_equalTo(self.view);
//        }
    }];
    */
}
- (UITableView *)tableView
{
    UIScrollView * scrollView;
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
//    if (@available(iOS 11.0, *)) {
//        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    return _tableView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.navigationController pushViewController:[[NSClassFromString(@"MEBaseTableViewController") alloc] init] animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  //  [self.navigationController pushViewController:[[NSClassFromString(@"MEBaseViewController") alloc] init] animated:YES];
//    return;
//    MESegmentedControlViewController * vc = [MESegmentedControlViewController new];
//    vc.btnTitles = @[@"淘宝",@"天猫",@"京东",@"拼多多",@"苏宁易购"];
//    vc.childVcNames = @[@"MEBaseViewController",@"MEBaseViewController",@"MEBaseViewController",@"MEBaseViewController",@"MEBaseViewController"];
//    [self.navigationController pushViewController:vc animated:true];
//    NSArray * arr = [self valueForKeyPath:@"urlMD5s"];
}
@end
