//
//  ZBTableViewController.h
//  iPATools
//
//  Created by jumbo on 2021/5/10.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBBaseViewController.h"
#import "ZBTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBTableViewController : ZBBaseViewController
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *sourceData;

- (void)setupTableView;

- (void)registerClasses:(NSArray *)classes;

@end

NS_ASSUME_NONNULL_END
