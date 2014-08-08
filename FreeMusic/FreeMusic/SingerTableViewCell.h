//
//  MyTableViewCell.h
//  FreeMusic
//
//  Created by GukeManbu on 14-8-6.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCircleImageView+OnlineImage.h"

@interface SingerTableViewCell : UITableViewCell

@property (nonatomic, assign) NSString *photoUrl;        // 头像的网络地址
@property (nonatomic, assign) NSString *singerName;      // 歌手名
@property (nonatomic, assign) NSString *singerCompany;   // 所属公司

@end
