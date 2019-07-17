//
//  MESegmentedControlViewController.m
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MESegmentedControlViewController.h"

@interface MESegmentedControlViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong) NSArray * btns;//所有的按钮
@property(nonatomic,strong) UIButton * currentBtn;//当前选中的button
@property(nonatomic,strong) UIView * line;//按钮下边的细线
@property(nonatomic,strong) UIScrollView * scrollView;//添加所有的子控制器view
@property(nonatomic,strong) UIView * topView;//所有button的父试图
@end

@implementation MESegmentedControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}
- (UIView *)topView
{
    if (_topView) {
        return _topView;
    }
    _topView = [UIView new];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.height.mas_equalTo(50);
    }];
    UIView * btmLine = [UIView new];
    btmLine.backgroundColor = [UIColor colorWithWhite:228/255.0 alpha:1];
    [_topView addSubview:btmLine];
    [btmLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self->_topView);
        make.height.mas_equalTo(1);
    }];
    self.line = [UIView new];
    self.line.backgroundColor = [UIColor redColor];
    [_topView addSubview:self.line];
    return _topView;
}
- (UIScrollView *)scrollView
{
    if (_scrollView) {
        return _scrollView;
    }
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    [self addScrollView];
    return _scrollView;
}
- (void)addScrollView
{
    if (_scrollView.superview) {
        return;
    }
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view);
        }
    }];
}
//返回一个button
- (UIButton *)btnWithTitle:(NSString *)btnTitle
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn addTarget:self action:@selector(clickSegmentBtn:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
//点击button
- (void)clickSegmentBtn:(UIButton *)btn
{
    if (btn == self.currentBtn) {
        return;
    }
    UIButton * preBtn = self.currentBtn;
    preBtn.selected = false;
    self.currentBtn = btn;
    self.currentBtn.selected = true;
    [UIView animateWithDuration:0.25 animations:^{
        CGPoint center = self.line.center;
        center.x = btn.center.x;
        self.line.center = center;
        preBtn.transform = CGAffineTransformScale(preBtn.transform, 13.0/15, 13.0/15);
        self.currentBtn.transform = CGAffineTransformScale(self.currentBtn.transform, 15.0/13, 15.0/13);
    } completion:^(BOOL finished) {
        self.scrollView.contentOffset = CGPointMake(kScreenWidth * btn.tag, 0);
        [self addChildVcViewIntoScrollView:btn.tag];
    }];
}
- (void)addChildVcViewIntoScrollView:(NSUInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
    
    // 如果view已经被加载过，就直接返回
    if (childVc.isViewLoaded) return;
    
    // 取出index位置对应的子控制器view
    UIView *childVcView = childVc.view;
   // childVcView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255.0)/255.0 green:arc4random_uniform(255.0)/255.0 blue:arc4random_uniform(255.0)/255.0 alpha:1];
    // 设置子控制器view的frame
    childVcView.frame = CGRectMake(index * kScreenWidth, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
    // 添加子控制器的view到scrollView中
    [self.scrollView addSubview:childVcView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x/kScreenWidth;
    UIButton * btn = self.btns[index];
    [self clickSegmentBtn:btn];
}
//添加子控制器
- (void)setChildVcNames:(NSArray *)childVcNames
{
    if (_childVcNames == childVcNames || childVcNames == nil) {
        return;
    }
    _childVcNames = childVcNames;
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    for (NSString * vcName in childVcNames) {
        Class class = NSClassFromString(vcName);
        if (class != nil) {
            [self addChildViewController:[class new]];
        }
    }
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * childVcNames.count, 0);
    [self addChildVcViewIntoScrollView:0];
}
-(void)setBtnTitles:(NSArray *)btnTitles
{
    if (_btnTitles == btnTitles || btnTitles == nil) {
        return;
    }
    _btnTitles = btnTitles;
    NSInteger count = _btnTitles.count;
    if (count == 0) {
        return;
    } else {
        CGFloat btnW = kScreenWidth/count;
        NSMutableArray * arr = [NSMutableArray new];
        for (NSInteger i = 0; i < count; i ++)
        {
            @autoreleasepool {
            UIButton * btn = [self btnWithTitle:_btnTitles[i]];
            [self.topView addSubview:btn];
            btn.tag = i;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.top.bottom.mas_equalTo(self.topView);
                 make.width.mas_equalTo(btnW);
                 make.left.mas_equalTo(self.topView).offset(btnW * i);
                }];
               [arr addObject:btn];
           }
        }
        self.btns = arr;
        self.currentBtn = arr.firstObject;
        self.currentBtn.transform = CGAffineTransformScale(self.currentBtn.transform, 15.0/13, 15.0/13);
        self.currentBtn.selected = YES;
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.topView);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(54);
        make.centerX.mas_equalTo(self.currentBtn);
    }];
  }
}

@end
