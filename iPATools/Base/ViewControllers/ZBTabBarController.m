//
//  ZBTabBarController.m
//  iPATools
//
//  Created by jumbo on 2021/5/8.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBTabBarController.h"
#import "ZBNavigationController.h"

// child view controllers
#import "ZBHomeViewController.h"
#import "ZBiPAViewController.h"
#import "ZBResignViewController.h"
#import "ZBCertViewController.h"
#import "ZBProfileViewController.h"

@interface ZBTabBarController ()

@end

@implementation ZBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewControllers];
}

- (void)addChildViewControllers {
    [self addChild:[ZBHomeViewController new] t:@"资源" ni:@"" sli:@""];
    [self addChild:[ZBiPAViewController new] t:@"下载" ni:@"" sli:@""];
    [self addChild:[ZBResignViewController new] t:@"签名" ni:@"" sli:@""];
    [self addChild:[ZBCertViewController new] t:@"证书" ni:@"" sli:@""];
    [self addChild:[ZBProfileViewController new] t:@"我" ni:@"" sli:@""];
}


/// 添加自控制器
/// @param childvc 控制器实例
/// @param t 标签名
/// @param ni 默认图片
/// @param sli 选中图片
- (void)addChild:(ZBBaseViewController *)childvc t:(NSString *)t ni:(NSString *)ni sli:(NSString *)sli {
    ZBNavigationController *nav_vc = [[ZBNavigationController alloc] initWithRootViewController:childvc];
    [nav_vc.tabBarItem setImage:[UIImage imageNamed:ni]];
    [nav_vc.tabBarItem setImage:[UIImage imageNamed:sli]];
    [nav_vc.tabBarItem setTitle:t];
    [childvc.navigationItem setTitle:t];
    [self addChildViewController:nav_vc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#ifdef DEBUG
- (void)dealloc {
    NSLog(@"😊-[%@ %s]", NSStringFromClass([self class]), sel_getName(_cmd));
}
#endif

@end
