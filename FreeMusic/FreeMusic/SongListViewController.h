//
//  SongListViewController.h
//  FreeMusic
//
//  Created by GukeManbu on 14-8-7.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNavigationBar.h"
#import "PlayViewController.h"
#import "SongTableViewCell.h"
#import "SongInfo.h"
#import "ProgressHUD.h"

#define SONG_URL @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=android&version=2.4.0&method=baidu.ting.artist.getSongList&format=json&order=2"

@interface SongListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSString *singer;
@property (nonatomic, assign) NSString *tingUid;
@property (nonatomic, strong) NSMutableArray *songList;

@end
