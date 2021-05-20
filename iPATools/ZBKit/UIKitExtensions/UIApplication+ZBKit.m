//
//  UIApplication+ZBKit.m
//  iPATools
//
//  Created by jumbo on 2021/5/20.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "UIApplication+ZBKit.h"

@implementation UIApplication (ZBKit)

+ (void)zb_openURL:(NSString *)urlString {
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

@end
