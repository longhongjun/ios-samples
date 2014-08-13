//
//  SongTableViewCell.h
//  FreeMusic
//
//  Created by GukeManbu on 14-8-8.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongTableViewCell : UITableViewCell

@property (nonatomic, assign) NSString *name;     // 歌曲名
@property (nonatomic, assign) NSString *album;    // 专辑名
@property (nonatomic, assign) NSString *duration; // 时长

@end
