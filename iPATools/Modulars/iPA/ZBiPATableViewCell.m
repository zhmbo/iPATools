//
//  ZBiPATableViewCell.m
//  iPATools
//
//  Created by jumbo on 2021/5/15.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBiPATableViewCell.h"
#import "ZBiPAModel.h"
#import "YCDownloadItem.h"
#import "YCDownloadUtils.h"

@interface ZBiPATableViewCell()<YCDownloadItemDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *speedProgress;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@end

@implementation ZBiPATableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(YCDownloadItem *)item {
    _item = item;
    _item.delegate = self;
    
    ZBiPAModel *mo = [ZBiPAModel modelWithData:item.extraData];
    self.nameLabel.text = mo.name;
//    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:mo.cover_url]];
    [self changeSizeLblDownloadedSize:item.downloadedSize totalSize:item.fileSize];
    [self setDownloadStatus:item.downloadStatus];
    self.speedLabel.hidden = !item.enableSpeed;
}

- (void)setDownloadStatus:(YCDownloadStatus)status {
    NSString *statusStr = @"正在等待";
    switch (status) {
        case YCDownloadStatusWaiting:
            statusStr = @"正在等待";
            break;
        case YCDownloadStatusDownloading:
            statusStr = @"正在下载";
            break;
        case YCDownloadStatusPaused:
            statusStr = @"暂停下载";
            break;
        case YCDownloadStatusFinished:
            statusStr = @"下载成功";
            break;
        case YCDownloadStatusFailed:
            statusStr = @"下载失败";
            break;
            
        default:
            break;
    }
    self.statusLabel.text = statusStr;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)changeSizeLblDownloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize {

    NSString *size = [NSString stringWithFormat:@"%@ / %@",[YCDownloadUtils fileSizeStringFromBytes:downloadedSize], [YCDownloadUtils fileSizeStringFromBytes:totalSize]];
    
    float progress = 0;
    if (totalSize != 0) {
        progress = (float)downloadedSize / totalSize;
    }
    
    NSLog(@"%@ 下载进度：%f size:%@", _item.fileId, progress, size);
    self.speedProgress.progress = progress;
    
    self.sizeLabel.text = size;
}

// MARK: - YCDowloadItemDelegate
- (void)downloadItemStatusChanged:(YCDownloadItem *)item {
    [self setDownloadStatus: item.downloadStatus];
}

- (void)downloadItem:(YCDownloadItem *)item downloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize {
    [self changeSizeLblDownloadedSize:downloadedSize totalSize:totalSize];
}

- (void)downloadItem:(YCDownloadItem *)item speed:(NSUInteger)speed speedDesc:(NSString *)speedDesc {
    self.speedLabel.text = speedDesc;
}

@end
