//
//  MEBaseTableViewController.h
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MEBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MEBaseTableViewController : MEBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableView;
@end

NS_ASSUME_NONNULL_END
