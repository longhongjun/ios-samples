//
//  AppDelegate.m
//  AngryBirds
//
//  Created by gukemanbu on 14-6-27.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "cocos2d.h"
#import "LoadingScene.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 隐藏状态栏
    [application setStatusBarHidden:YES];
    // 设置导演类型
    if (![CCDirector setDirectorType:CCDirectorTypeDisplayLink]) {
        [CCDirector setDirectorType:CCDirectorTypeDefault];
    }
    
    // 创建一个导演
    CCDirector *director = [CCDirector sharedDirector];
    // 创建一个剧场
    EAGLView *glView = [EAGLView viewWithFrame:[self.window bounds] pixelFormat:kEAGLColorFormatRGB565 depthFormat:0];

    // 关联导演与剧场
    [director setOpenGLView:glView];
    // 设置游戏方向为左横屏
    [director setDeviceOrientation:kCCDeviceOrientationPortrait];
    // 设置游戏的刷新率
    [director setAnimationInterval:1.0f/60.0f];
    // 显示游戏的刷新率
    [director setDisplayFPS:YES];
    
    // 创建RootViewController
    RootViewController *rvc = [[RootViewController alloc] init];
    // 把剧场加入到RootViewController里
    [rvc setView:glView];
    // 设置根控制器
    [self.window setRootViewController:rvc];
    // 销毁根控制器
    [rvc release];
    
    [self.window makeKeyAndVisible];
    
    // 显示LoadingScene
    CCScene *loadingScene = [LoadingScene scene];
    [[CCDirector sharedDirector] runWithScene:loadingScene];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] pause];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[CCDirector sharedDirector] stopAnimation];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[CCDirector sharedDirector] startAnimation];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] resume];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    CCDirector *director = [CCDirector sharedDirector];
    [[director openGLView] removeFromSuperview];
    [self.window release];
    [director end];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
