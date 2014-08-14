//
//  SongInfo.h
//  FreeMusic
//
//  Created by GukeManbu on 14-8-8.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongInfo : NSObject

@property (nonatomic, strong) NSString *tingUid;
@property (nonatomic, strong) NSString *songId;
@property (nonatomic, strong) NSString *songName;
@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, strong) NSString *albumCover;
@property (nonatomic, strong, getter = getDuration) NSString *duration;

@end
