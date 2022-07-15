//
//  ZBLibsConfiguration.h
//  iPATools
//
//  Created by jumbo on 2021/5/18.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBLibsConfiguration : NSObject

+ (instancetype)shared;

- (void)configLibsWithWindow:(UIWindow *)window;

@end

NS_ASSUME_NONNULL_END
