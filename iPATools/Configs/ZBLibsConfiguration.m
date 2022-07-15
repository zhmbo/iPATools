//
//  ZBLibsConfiguration.m
//  iPATools
//
//  Created by jumbo on 2021/5/18.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBLibsConfiguration.h"

// Download
#import "YCDownloadSession.h"
#import "HTTPServer.h"
#import "ZBiPAModel.h"
#import "ZBDownLoadManager.h"

@interface ZBLibsConfiguration()

@property (nonatomic, strong) HTTPServer * httpServer;
@property (nonatomic) UIBackgroundTaskIdentifier backgroundIdentify;

@end

@implementation ZBLibsConfiguration

+ (instancetype)shared {
    static id shared = nil;
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        shared = [ZBLibsConfiguration new];
    });
    return shared;
}

- (void)configLibsWithWindow:(UIWindow *)window {
    [self setUpDownload];
    [self setupServer];
}

-(void) setupServer {

    HTTPServer *_httpServer = [HTTPServer new];
    _httpServer.type = @"_tcp";
    _httpServer.port = WaitSignIPA_Port;
    _httpServer.documentRoot = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    [_httpServer start:nil];
    // 一定要持有
    self.httpServer = _httpServer;
    
    self.backgroundIdentify = UIBackgroundTaskInvalid;
    self.backgroundIdentify =
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        // 当时间快结束时，该方法会被调用。
        NSLog(@"Background handler called. Not running background tasks anymore.");
        
        [[UIApplication sharedApplication] endBackgroundTask:self.backgroundIdentify];
        
        self.backgroundIdentify = UIBackgroundTaskInvalid;
    }];
    
}

- (void)setUpDownload {
    YCDConfig *config = [YCDConfig new];
    config.saveRootPath = WaitSignIPA_RootPath;
    config.maxTaskCount = 2;
    config.taskCachekMode = YCDownloadTaskCacheModeKeep;
    config.launchAutoResumeDownload = true;
    [YCDownloadManager mgrWithConfig:config];
    [YCDownloadManager allowsCellularAccess:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadTaskFinishedNoti:) name:kDownloadTaskFinishedNoti object:nil];
}

// MARK: - notificaton
- (void)downloadTaskFinishedNoti:(NSNotification *)noti{
    YCDownloadItem *item = noti.object;
    if (item.downloadStatus == YCDownloadStatusFinished) {
        ZBiPAModel *mo = [ZBiPAModel modelWithData:item.extraData];
        NSString *detail = [NSString stringWithFormat:@"%@，已经下载完成！", mo.name];
        
        UILocalNotification *localNote = [[UILocalNotification alloc] init];
        localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0];
        localNote.alertBody = detail;
        localNote.alertAction = @"滑动来解锁";
        localNote.hasAction = NO;
        localNote.soundName = @"default";
        localNote.userInfo = @{@"type" : @1};
        [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    }
}

@end
