//
//  UIColor+ZBKit.h
//  iPATools
//
//  Created by jumbo on 2021/5/10.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZBKit)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert withAlpha:(CGFloat)alpha;

+ (UIColor *)colorWithRGBHex:(UInt32)hex;

+ (UIColor *)colorWithRGBAlphaHex:(UInt32)hex ;

+ (UIColor *)colorWithRGBHex:(UInt32)hex withAlpha:(CGFloat)alpha;

- (NSString *)hexadecimalFromUIColor;

@end

NS_ASSUME_NONNULL_END
