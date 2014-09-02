//
//  TudouViewController.h
//  FreeMusic
//
//  Created by GukeManbu on 14-8-5.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNavigationBar.h"
#import "DropDownChooseProtocol.h"
#import "DropDownListView.h"

@interface TudouViewController : UIViewController<DropDownChooseDataSource, DropDownChooseDelegate>

@property (nonatomic, strong) NSMutableArray *chooseArray;

@end
