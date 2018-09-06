//
//  AppDelegate.h
//  RACNetworkMonitor
//
//  Created by 刘小二 on 2018/9/6.
//  Copyright © 2018年 刘小二. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworkReachabilityManager.h>
#import <ReactiveObjC/ReactiveObjC.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 网络状态
 */
@property (readonly, nonatomic, assign) AFNetworkReachabilityStatus networkReachabilityStatus;
@end

