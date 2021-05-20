//
//  ZBLibManager.m
//  iPATools
//
//  Created by jumbo on 2021/5/18.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBLibManager.h"

// Download
#import "YCDownloadSession.h"
#import "ZBiPAModel.h"

#import "HTTPServer.h"

@interface ZBLibManager()

@property (nonatomic, strong) HTTPServer * httpServer;
@property (nonatomic) UIBackgroundTaskIdentifier backgroundIdentify;

@end

@implementation ZBLibManager

+ (instancetype)shared {
    static id shared = nil;
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        shared = [ZBLibManager new];
    });
    return shared;
}

- (void)setupLibsWithWindow:(UIWindow *)window {
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
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject;
    path = [path stringByAppendingPathComponent:WaitSignIPA_Path];
    YCDConfig *config = [YCDConfig new];
    config.saveRootPath = path;
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
        [self localPushWithTitle:@"YCDownloadSession" detail:detail];
    }
}

// MARK: - local push
- (void)localPushWithTitle:(NSString *)title detail:(NSString *)body  {
    if (title.length == 0) return;
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0];
    localNote.alertBody = body;
    localNote.alertAction = @"滑动来解锁";
    localNote.hasAction = NO;
    localNote.soundName = @"default";
    localNote.userInfo = @{@"type" : @1};
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}

-(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    [[YCDownloader downloader] addCompletionHandler:completionHandler identifier:identifier];
}

@end
