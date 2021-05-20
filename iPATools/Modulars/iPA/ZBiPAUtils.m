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
#import "ZBLibManager.h"
#import "NSString+ZBKit.h"
#import "UIApplication+ZBKit.h"

@implementation ZBiPAUtils

+ (void)installIPAWithModel:(ZBiPAModel *)model {
    
    NSString *name = model.name.zb_isNull ? @"app" : model.name;
    NSString *bundleid = model.bundleid.zb_isNull ? @"com.apple.app" : model.bundleid;

    NSString * url = localHost.a(@":").a(@(WaitSignIPA_Port)).a(@"/").a(WaitSignIPA_Path).a(@"/").a(model._id).a(@".ipa");
    
    NSString *paramsStr = [NSString stringWithFormat:@"%@|%@|%@",name,bundleid,url];
    
    NSString *base64ParamsStr = [paramsStr zb_base64];
    
    NSString *urlEncodeStr = [base64ParamsStr zb_urlEncode];
    
    NSLog(@"Params: %@\nbase64Str:%@\nUrlEncode:%@", paramsStr,base64ParamsStr,urlEncodeStr);

    NSString *plistStr = [NSString stringWithFormat:@"https://ios-ipa-server.vercel.app/api/plist/%@", urlEncodeStr];
    
    NSString *appUrlString = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",[plistStr zb_urlEncode]];

    NSLog(@"Install Plist is %@",plistStr);
    
    [UIApplication zb_openURL:appUrlString];
}

@end
