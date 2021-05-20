//
//  ZBHomeTableViewCell.h
//  iPATools
//
//  Created by jumbo on 2021/5/10.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBTableViewCell.h"
@class
ZBHomeTableViewCell,
ZBiPAModel,
YCDownloadItem;

NS_ASSUME_NONNULL_BEGIN

@protocol ZBHomeCellDelegate <NSObject>

- (void)homeCell:(ZBHomeTableViewCell *)cell download:(ZBiPAModel *)model;

@end

@interface ZBHomeTableViewCell : ZBTableViewCell

@property (nonatomic, strong) ZBiPAModel *model;

@property (nonatomic, weak) id <ZBHomeCellDelegate> delegate;

@property (nonatomic, strong) YCDownloadItem *item;
@end

NS_ASSUME_NONNULL_END
