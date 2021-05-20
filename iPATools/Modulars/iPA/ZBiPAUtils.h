//
//  ZBiPAUtils.h
//  iPATools
//
//  Created by jumbo on 2021/5/18.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZBiPAModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZBiPAUtils : NSObject

+ (void)installIPAWithModel:(ZBiPAModel *)model;

@end

NS_ASSUME_NONNULL_END
