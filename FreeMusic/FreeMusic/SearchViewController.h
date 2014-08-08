//
//  RootViewController.h
//  FreeMusic
//
//  Created by GukeManbu on 14-8-5.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNavigationBar.h"
#import "PlayViewController.h"
#import "SongListViewController.h"
#import "SingerTableViewCell.h"
#import "FMDB.h"
#import "SingerInfo.h"

@interface SearchViewController : UIViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *singerList;

@end
