//
//  ZBiPATableViewCell.h
//  iPATools
//
//  Created by jumbo on 2021/5/15.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBTableViewCell.h"

@class
YCDownloadItem,
ZBiPAModel,
ZBTableViewCell;

NS_ASSUME_NONNULL_BEGIN

@interface ZBiPATableViewCell : ZBTableViewCell

@property (nonatomic, assign) NSUInteger status;

@property (nonatomic, strong) YCDownloadItem *item;

@end

NS_ASSUME_NONNULL_END
