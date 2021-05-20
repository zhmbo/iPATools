//
//  ZBLibManager.h
//  iPATools
//
//  Created by jumbo on 2021/5/18.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *localHost = @"http://127.0.0.1";
static NSInteger WaitSignIPA_Port = 10001;
static NSString *WaitSignIPA_Path = @"WaitSignIPA";

@interface ZBLibManager : NSObject

+ (instancetype)shared;

- (void)setupLibsWithWindow:(UIWindow *)window;

-(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler;
@end

NS_ASSUME_NONNULL_END
