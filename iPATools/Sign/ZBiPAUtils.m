//
//  ZBiPAUtils.m
//  iPATools
//
//  Created by jumbo on 2021/5/18.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBiPAUtils.h"
#import "ZBiPAModel.h"
#import <UIKit/UIKit.h>
#import "ZBDownLoadManager.h"
#import "NSString+ZBKit.h"
#import "UIApplication+ZBKit.h"

@implementation ZBiPAUtils

+ (void)installIPAWithModel:(ZBiPAModel *)model {
    
    NSString *name = model.name.zb_isNull ? @"app" : model.name;
    NSString *bundleid = model.bundleid.zb_isNull ? @"com.apple.app" : model.bundleid;

    NSString * url = localHost.a(@":").a(@(WaitSignIPA_Port)).a(@"/").a(WaitSignIPA_Path).a(@"/").a(model._id).a(@".ipa");
    
//    name = @"WoFang";
//    bundleid = @"jumbo.wo.fang";
//    url = @"http://ipa.itzhangbao.com/Sabrina.ipa";
    
    NSString *paramsStr = [NSString stringWithFormat:@"%@|%@|%@",name,bundleid,url];
    
    NSString *base64ParamsStr = [paramsStr zb_base64];
    
    NSString *urlEncodeStr = [base64ParamsStr zb_urlEncode];
    
    // fang｜com.apple.app｜http://ipa.itzhangbao.com/FanQieXiaoShuo.ipa
    
    NSLog(@"Params: %@\nbase64Str:%@\nUrlEncode:%@", paramsStr,base64ParamsStr,urlEncodeStr);
    
    // ZmFuZ%2B%2B9nGNvbS5hcHBsZS5hcHDvvZxodHRwOi8vaXBhLml0emhhbmdiYW8uY29tL0ZhblFpZVhpYW9TaHVvLmlwYQ%3D%3D

    NSString *plistStr = [NSString stringWithFormat:@"https://ios-ipa-server.vercel.app/api/plist/%@", urlEncodeStr];
    
    // https://ios-ipa-server.vercel.app/api/plist/ZmFuZ%2B%2B9nGNvbS5hcHBsZS5hcHDvvZxodHRwOi8vaXBhLml0emhhbmdiYW8uY29tL0ZhblFpZVhpYW9TaHVvLmlwYQ%3D%3D
    
    NSString *appUrlString = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",[plistStr zb_urlEncode]];
    
    //itms-services://?action=download-manifest&url=https://ios-ipa-server.vercel.app/api/plist/V29GYW5nfGp1bWJvLndvLmZhbmd8aHR0cDovL2lwYS5pdHpoYW5nYmFvLmNvbS9TYWJyaW5hLmlwYQ%3D%3D

    NSLog(@"Install Plist is %@",plistStr);
    
    [UIApplication zb_openURL:appUrlString];
}

@end
