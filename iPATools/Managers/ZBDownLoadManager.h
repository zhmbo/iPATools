//
//  ZBDownLoadManager.h
//  iPATools
//
//  Created by jumbo on 2021/5/22.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCDownloadSession.h"

NS_ASSUME_NONNULL_BEGIN

#define WaitSignIPA_RootPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject stringByAppendingPathComponent:WaitSignIPA_Path]

static NSString *localHost = @"http://127.0.0.1";
static NSInteger WaitSignIPA_Port = 10001;
static NSString *WaitSignIPA_Path = @"WaitSignIPA";

@interface ZBDownLoadManager : NSObject

+ (void)saveItemWithURL:(NSURL *)url ;

+ (void)addCompletionHandler:(BGCompletedHandler)handler identifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
