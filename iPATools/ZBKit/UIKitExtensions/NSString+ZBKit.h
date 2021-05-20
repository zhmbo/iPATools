//
//  NSString+ZBKit.h
//  iPATools
//
//  Created by jumbo on 2021/5/20.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZBKit)

- (NSString *(^)(id newValue))a;

- (NSString *)zb_urlEncode;

- (NSString *)zb_base64;

- (BOOL)zb_isNull;

@end

NS_ASSUME_NONNULL_END
