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

@interface PlayViewController : UIViewController {
    MyCircleImageView *_playButtonBackground;
    AudioStreamer *_audioStreamer;
}

@property (nonatomic, strong) SongInfo *songInfo;

@end
