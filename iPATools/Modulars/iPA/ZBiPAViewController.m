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
#import "ZBDownLoadManager.h"

@interface ZBiPAViewController ()<UIDocumentPickerDelegate>

@end

@implementation ZBiPAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(tapAddBarButton:)];
    self.navigationItem.rightBarButtonItem = addItem;
    
    [self registerClasses: @[[ZBiPATableViewCell class]]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadTaskFinishedNoti:) name:kDownloadTaskFinishedNoti object:nil];
}

- (void)tapAddBarButton:(id)sender {
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.item"] inMode:UIDocumentPickerModeImport];
    documentPicker.delegate = self;
    [self presentViewController:documentPicker animated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
        [ZBDownLoadManager saveItemWithURL:urls.lastObject];
        [self reloadAllData];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadAllData];
}

- (void)reloadAllData {
    [self.sourceData removeAllObjects];
    NSMutableArray *downloadList = [NSMutableArray arrayWithArray:[YCDownloadManager downloadList]];
    NSMutableArray *finishList = [NSMutableArray arrayWithArray:[YCDownloadManager finishList]];
    [self.sourceData addObject:downloadList];
    [self.sourceData addObject:finishList];
    [self.tableView reloadData];
}

- (void)setupTableView {
    [super setupTableView];
    self.tableView.rowHeight = 112;
}

- (void)downloadTaskFinishedNoti:(NSNotification *)noti{
    YCDownloadItem *item = noti.object;
    if (item.downloadStatus == YCDownloadStatusFinished) {
        [self reloadAllData];
    }
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
