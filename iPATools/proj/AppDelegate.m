//
//  AppDelegate.m
//  iPATools
//
//  Created by jumbo on 2021/5/8.
//

#import "AppDelegate.h"
#import "ZBTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame: UIScreen.mainScreen.bounds];
    self.window.rootViewController = [ZBTabBarController new];
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
