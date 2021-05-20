//
//  ZBiPAViewController.m
//  iPATools
//
//  Created by jumbo on 2021/5/8.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBiPAViewController.h"
#import "YCDownloadSession.h"
#import "ZBiPATableViewCell.h"
#import "ZBiPAModel.h"
#import "ZBiPAUtils.h"

@interface ZBiPAViewController ()

@end

@implementation ZBiPAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerClasses: @[[ZBiPATableViewCell class]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadAllData];
}

- (void)reloadAllData {
    [self.sourceData removeAllObjects];
    [self.sourceData addObject:[NSMutableArray arrayWithArray:[YCDownloadManager downloadList]]];
    [self.sourceData addObject:[NSMutableArray arrayWithArray:[YCDownloadManager finishList]]];
    [self.tableView reloadData];
}

- (void)setupTableView {
    [super setupTableView];
    self.tableView.rowHeight = 112;
}

// MARK: - DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZBiPATableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:ZBiPATableViewCell.identifier forIndexPath:indexPath];
    cell.item = self.sourceData[indexPath.section][indexPath.row];
    return cell;
}

// MARK: - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YCDownloadItem *item = self.sourceData[indexPath.section][indexPath.row];
    if (item.downloadStatus == YCDownloadStatusDownloading) {
        [YCDownloadManager pauseDownloadWithItem:item];
    }else if (item.downloadStatus == YCDownloadStatusPaused){
        [YCDownloadManager resumeDownloadWithItem:item];
    }else if (item.downloadStatus == YCDownloadStatusFailed){
        [YCDownloadManager resumeDownloadWithItem:item];
    }else if (item.downloadStatus == YCDownloadStatusWaiting){
        [YCDownloadManager pauseDownloadWithItem:item];
    }else if (item.downloadStatus == YCDownloadStatusFinished){
        ZBiPAModel *model = [ZBiPAModel modelWithData:item.extraData];
        [ZBiPAUtils installIPAWithModel:model];
    }
    if (item.downloadedSize != YCDownloadStatusFinished) {
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        YCDownloadItem *item = self.sourceData[indexPath.section][indexPath.row];
        [YCDownloadManager stopDownloadWithItem:item];
        
        [self.sourceData[indexPath.section] removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


@end
