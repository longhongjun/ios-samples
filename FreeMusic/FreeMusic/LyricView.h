//
//  LyricView.h
//  FreeMusic
//
//  Created by GukeManbu on 14-8-28.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LyricInfo.h"

#define LYRIC_URL @"ting.baidu.com"

@interface LyricView : UIView {
    UIScrollView *_scrollView;
}

@property (nonatomic, retain) NSMutableArray *lyricList;
@property (nonatomic, retain) NSMutableArray *lyricLabelList;

-(void) loadLyric:(NSString *) songUrl;
-(void) scrollToTime:(NSString *) time;

@end
