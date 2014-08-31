//
//  PlayViewController.h
//  FreeMusic
//
//  Created by GukeManbu on 14-8-5.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNavigationBar.h"
#import "MyCircleImageView+OnlineImage.h"
#import "SongInfo.h"
#import "AudioStreamer.h"
#import "LyricView.h"

#define SONG_URL @"http://ting.baidu.com/data/music/links?songIds="

@interface PlayViewController : UIViewController {
    UIButton *_btnPlay;
    MyCircleImageView *_playButtonBackground;
    AudioStreamer *_audioStreamer;
    LyricView *_lyricView;
    int _playedSeconds;
}

@property (nonatomic, strong) SongInfo *songInfo;

@end
