//
//  ZBDownLoadManager.m
//  iPATools
//
//  Created by jumbo on 2021/5/22.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBDownLoadManager.h"
#import "ZBTabBarController.h"
#import "ZBiPAModel.h"

@implementation ZBDownLoadManager

+ (void)saveItemWithURL:(NSURL *)url {
    
    if (url == nil) {
        return;
    }
    
    NSMutableString *localPath = [[NSMutableString alloc] initWithString:[url.absoluteString stringByRemovingPercentEncoding]];
    if ([localPath hasPrefix:@"file:///private"]) {
      [localPath replaceOccurrencesOfString:@"file:///private" withString:@"" options:NSCaseInsensitiveSearch  range:NSMakeRange(0, localPath.length)];
    }
    
    // iPA
    if ([[localPath pathExtension] isEqualToString:@"ipa"]) {
        
        ZBiPAModel *model = [ZBiPAModel new];
        model.name = [localPath componentsSeparatedByString:@"/"].lastObject;
        model._id = [YCDownloadUtils md5ForString:[NSUUID UUID].UUIDString];
        model.extension = [localPath pathExtension];
        
        YCDownloadItem *item = [YCDownloadItem itemWithUrl:localPath fileId:model._id];
        item.extraData = [ZBiPAModel dataWithModel:model];
        item.taskId = [YCDownloadUtils md5ForString:[NSString stringWithFormat:@"%@-%@",localPath,model._id]];
        item.enableSpeed = true;
        item.fileExtension = model.extension;
        item.uid = @"YCDownloadUID";
        item.downloadStatus = YCDownloadStatusFinished;
        item.saveRootPath = WaitSignIPA_RootPath;
        item.fileType = model.extension;
        item.fileSize = [YCDownloadUtils fileSizeWithPath:localPath];

        BOOL isSuccess = [[NSFileManager defaultManager] moveItemAtPath:localPath toPath:item.savePath error:nil];
        
        if (isSuccess == YES) {
            NSLog(@"拷贝成功");
            [YCDownloadDB saveItem:item];
            
            [ZBTabBarController selectShowVc:1];
        } else {
            isSuccess = [[NSFileManager defaultManager] copyItemAtPath:localPath toPath:item.savePath error:nil];
            if (isSuccess) {
                NSLog(@"拷贝成功");
            }else {
                NSLog(@"拷贝失败");
            }
        }
    }
    
}

+ (void)addCompletionHandler:(BGCompletedHandler)handler identifier:(NSString *)identifier {
    [[YCDownloader downloader] addCompletionHandler:handler identifier:identifier];
}

@end
