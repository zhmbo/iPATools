//
//  ZBHomeTableViewCell.m
//  iPATools
//
//  Created by jumbo on 2021/5/10.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBHomeTableViewCell.h"
#import "ZBiPAModel.h"
#import "YCDownloadItem.h"
#import "YCDownloadUtils.h"
@interface ZBHomeTableViewCell()<YCDownloadItemDelegate>

@property (weak, nonatomic) IBOutlet UIImageView    * iconImageView;
@property (weak, nonatomic) IBOutlet UILabel        * nameLabel;
@property (weak, nonatomic) IBOutlet UILabel        * sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel        * descLabel;
@property (weak, nonatomic) IBOutlet UIButton       * downloadButton;

@end

@implementation ZBHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    AnimatedButton *button = [[AnimatedButton alloc] init];
}

- (void)setModel:(ZBiPAModel *)model {
    _model = model;
    _nameLabel.text = model.name;
    _sizeLabel.text = model.size;
    _descLabel.text = model.desc;
}

- (void)setItem:(YCDownloadItem *)item {
    _item = item;
    _item.delegate = self;
    [self setDownloadStatus: item.downloadStatus];
}

- (void)setDownloadStatus:(YCDownloadStatus)status {
    NSString *statusStr = @"下载";
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
    [self.downloadButton setTitle:statusStr forState:UIControlStateNormal];
}

- (IBAction)downloadButtonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeCell:download:)]) {
        [self.delegate homeCell:self download:self.model];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// MARK: - YCDowloadItemDelegate

- (void)changeSizeLblDownloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize {

    NSString *size = [NSString stringWithFormat:@"%@ / %@",[YCDownloadUtils fileSizeStringFromBytes:downloadedSize], [YCDownloadUtils fileSizeStringFromBytes:totalSize]];
    
    float progress = 0;
    if (totalSize != 0) {
        progress = (float)downloadedSize / totalSize;
    }
    
    NSLog(@"%@ 下载进度：%f size:%@", _model.name, progress, size);
//    self.progressView.progress = progress;
    
    self.sizeLabel.text = size;
}

- (void)downloadItemStatusChanged:(YCDownloadItem *)item {
    [self setDownloadStatus: item.downloadStatus];
}

- (void)downloadItem:(YCDownloadItem *)item downloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize {
    
    [self changeSizeLblDownloadedSize:downloadedSize totalSize:totalSize];
}

- (void)downloadItem:(YCDownloadItem *)item speed:(NSUInteger)speed speedDesc:(NSString *)speedDesc {
//    self.speedLbl.text = speedDesc;
}


@end
