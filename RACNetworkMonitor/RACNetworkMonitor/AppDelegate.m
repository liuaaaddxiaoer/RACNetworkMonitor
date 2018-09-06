//
//  AppDelegate.m
//  RACNetworkMonitor
//
//  Created by 刘小二 on 2018/9/6.
//  Copyright © 2018年 刘小二. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (readwrite, nonatomic, assign) AFNetworkReachabilityStatus networkReachabilityStatus;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 监听网络状态
    
    // 方法一
//    [self configureNetworkMonitor];
    // 方法二
    [self rac_configureNetworkMonitor];
    
    return YES;
}

- (void)configureNetworkMonitor {
    // 异步
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        @weakify(self);
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            @strongify(self);
            self.networkReachabilityStatus = status;
        }];
    });
}

- (void)rac_configureNetworkMonitor {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        // 利用RAC的通知写法 -> map转换类型 -> distinctUntilChanged 防止重复信号
        RAC(self, networkReachabilityStatus) = [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:AFNetworkingReachabilityDidChangeNotification object:nil] map:^id _Nullable(NSNotification * _Nullable value) {
            return [[value userInfo] valueForKey:AFNetworkingReachabilityNotificationStatusItem];
        }] distinctUntilChanged];
    });
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
