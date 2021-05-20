//
//  ZBTableViewController.m
//  iPATools
//
//  Created by jumbo on 2021/5/10.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBTableViewController.h"
#import <Masonry/Masonry.h>

@interface ZBTableViewController ()

@end

@implementation ZBTableViewController

- (NSMutableArray<NSMutableArray *> *)sourceData {
    if (!_sourceData) {
        _sourceData = [[NSMutableArray alloc] init];
    }
    return _sourceData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableView];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self registerClasses:@[[ZBTableViewCell class]]];
    
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)registerClasses:(NSArray *)classes {
    for (Class class in classes) {
        NSString *classStr = NSStringFromClass(class);
        if ([UINib nibWithNibName:classStr bundle:nil]) {
            [self.tableView registerNib:[UINib nibWithNibName:classStr bundle:nil] forCellReuseIdentifier:classStr];
        }else {
            [self.tableView registerClass:class forCellReuseIdentifier:classStr];
        }
    }
}

// MARK: - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceData[section].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sourceData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZBTableViewCell class]) forIndexPath:indexPath];
}


// MARK: - Delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
