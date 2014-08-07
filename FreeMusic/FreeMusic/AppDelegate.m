//
//  AppDelegate.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-5.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 我的音乐
    UIViewController *myMusicViewController = [[MyMusicViewController alloc] init];
    UINavigationController *myMusicNaviController = [[UINavigationController alloc] initWithRootViewController:myMusicViewController];
    myMusicNaviController.tabBarItem.title = @"我的音乐";
    myMusicNaviController.tabBarItem.image = [UIImage imageNamed:@"mymusic"];
    [myMusicViewController release];
    
    // 搜索
    UIViewController *searchViewController = [[SearchViewController alloc] init];
    UINavigationController *searchNaviController = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    searchNaviController.tabBarItem.title = @"搜索";
    searchNaviController.tabBarItem.image = [UIImage imageNamed:@"tabbarSearch"];
    [searchViewController release];
    
    // 土豆视频
    UIViewController *tudouViewController = [[TudouViewController alloc] init];
    UINavigationController *tudouNaviController = [[UINavigationController alloc] initWithRootViewController:tudouViewController];
    tudouNaviController.tabBarItem.title = @"土豆视频";
    tudouNaviController.tabBarItem.image = [UIImage imageNamed:@"tabbarMovie"];
    [tudouViewController release];
    
    UITabBarController *rootViewController = [[UITabBarController alloc] init];
    rootViewController.viewControllers = [NSArray arrayWithObjects:myMusicNaviController, searchNaviController, tudouNaviController, nil];
    rootViewController.selectedIndex = 1;
    
    [myMusicNaviController release];
    [searchNaviController release];
    [tudouNaviController release];
    
    self.window.rootViewController = rootViewController;
    //[self.window addSubview:rootViewController.view];
    [rootViewController release];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) dealloc {
    [_window release];
    _window = nil;
    [super dealloc];
}

@end
