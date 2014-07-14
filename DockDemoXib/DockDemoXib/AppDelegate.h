//
//  AppDelegate.h
//  DockDemoXib
//
//  Created by GukeManbu on 14-7-14.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "RootViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) IIViewDeckController *deckController;

@end
