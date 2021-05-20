//
//  AppDelegate.m
//  iPATools
//
//  Created by jumbo on 2021/5/8.
//

#import "AppDelegate.h"
#import "ZBTabBarController.h"
#import "ZBLibManager.h"

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
    [[ZBLibManager shared] setupLibsWithWindow:self.window];
    
    return YES;
}


-(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler{
    [[ZBLibManager shared] application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%s", __func__);
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%s", __func__);
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    
}

@end
