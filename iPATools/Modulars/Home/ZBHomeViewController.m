//
//  ZBHomeViewController.m
//  iPATools
//
//  Created by jumbo on 2021/5/8.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBHomeViewController.h"
#import "ZBHomeTableViewCell.h"
#import "ZBiPAModel.h"

#import "YCDownloadSession.h"
#import "ZBiPAUtils.h"

@interface ZBHomeViewController ()
<
ZBHomeCellDelegate
>

@end

@implementation ZBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self registerClasses:@[[ZBHomeTableViewCell class]]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ipas.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *arrM = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray *models = [ZBiPAModel modelsWithArray:arrM];
    [self.sourceData addObject:models];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setupTableView {
    [super setupTableView];
    self.tableView.rowHeight = 112;
}
// MARK: - Home Cell Delegate
- (void)homeCell:(ZBHomeTableViewCell *)cell download:(ZBiPAModel *)model {
    YCDownloadItem *item = nil;
    if (model._id) {
        item = [YCDownloadManager itemWithFileId:model._id];
    }else if (model.url){
        item = [YCDownloadManager itemsWithDownloadUrl:model.url].firstObject;
    }
    if (!item) { // 第一次下载
        item = [YCDownloadItem itemWithUrl:model.url fileId:model._id];
        item.extraData = [ZBiPAModel dataWithModel:model];
        item.enableSpeed = true;
        item.fileExtension = model.extension;
        [YCDownloadManager startDownloadWithItem:item];
    }else { // 再次点击
        if (item.downloadStatus == YCDownloadStatusDownloading) {
            [YCDownloadManager pauseDownloadWithItem:item];
        }else if (item.downloadStatus == YCDownloadStatusPaused){
            [YCDownloadManager resumeDownloadWithItem:item];
        }else if (item.downloadStatus == YCDownloadStatusFailed){
            [YCDownloadManager resumeDownloadWithItem:item];
        }else if (item.downloadStatus == YCDownloadStatusWaiting){
            [YCDownloadManager pauseDownloadWithItem:item];
        }else if (item.downloadStatus == YCDownloadStatusFinished){
            [ZBiPAUtils installIPAWithModel:model];
        }
    }
    if (item.downloadedSize != YCDownloadStatusFinished) {
        [self.tableView reloadData];
    }
}

// MARK: - DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZBHomeTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:ZBHomeTableViewCell.identifier forIndexPath:indexPath];
    ZBiPAModel *model = self.sourceData[indexPath.section][indexPath.row];
    cell.model = model;
    cell.delegate = self;
    YCDownloadItem *item = nil;
    if (model._id) {
        item = [YCDownloadManager itemWithFileId:model._id];
    }else if (model.url) {
        item = [YCDownloadManager itemsWithDownloadUrl:model.url].firstObject;
    }
    cell.item = item;
    return cell;
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
