//
//  AppDelegate.m
//  iPATools
//
//  Created by jumbo on 2021/5/8.
//

#import "AppDelegate.h"
#import "ZBTabBarController.h"
#import "ZBLibsConfiguration.h"
#import "ZBDownLoadManager.h"

@interface AppDelegate ()

@property (nonatomic) UIBackgroundTaskIdentifier backgroundIdentify;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame: UIScreen.mainScreen.bounds];
    self.window.rootViewController = [ZBTabBarController new];
    [self.window makeKeyAndVisible];
    
    //注册通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    [application registerUserNotificationSettings:settings];
    
    // setup libs
    [[ZBLibsConfiguration shared] configLibsWithWindow:self.window];
    
    return YES;
}

-(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler{
    [ZBDownLoadManager addCompletionHandler:completionHandler identifier:identifier];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [ZBDownLoadManager saveItemWithURL:url];
    return  YES;
}


@end
