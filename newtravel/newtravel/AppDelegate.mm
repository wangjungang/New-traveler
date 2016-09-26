//
//  AppDelegate.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/7.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "AppDelegate.h"
#import "mainViewController.h"
#import "impressionViewController.h"
#import "foundViewController.h"
#import "myViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "WJGTabBarController.H"
BMKMapManager* _mapManager;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    mainViewController *vc1 = [[mainViewController alloc] init];
    vc1.tabBarItem.title = @"首页";
    [vc1.tabBarItem setImage:[UIImage imageNamed:@"首页"]];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"首页2"];
    UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    
    impressionViewController *vc2 = [[impressionViewController alloc] init];
    vc2.title = @"印象";
    [vc2.tabBarItem setImage:[UIImage imageNamed:@"印象"]];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"印象"];
    UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:vc2];

    
    foundViewController *vc3 = [[foundViewController alloc] init];
    vc3.title = @"朋友圈";
    [vc3.tabBarItem setImage:[UIImage imageNamed:@"朋友圈"]];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"朋友圈2"];
    UINavigationController *nc3 = [[UINavigationController alloc] initWithRootViewController:vc3];

    
    myViewController *vc4 = [[myViewController alloc] init];
    vc4.title = @"个人中心";
    [vc4.tabBarItem setImage:[UIImage imageNamed:@"个人中心"]];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"个人中心2"];
    UINavigationController *nc4 = [[UINavigationController alloc] initWithRootViewController:vc4];

    
    WJGTabBarController *tbc = [[WJGTabBarController alloc] init];
    tbc.viewControllers = [NSArray arrayWithObjects:nc1, nc2, nc3, nc4, nil];
    self.window.rootViewController = tbc;
    tbc.tabBar.tintColor = [UIColor colorWithRed:255.0/255.0 green:124.0/255.0 blue:56.0/255.0 alpha:1];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"fVtAHRwyNAT1FaKROq9L5TD0bnOIoGhl" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
