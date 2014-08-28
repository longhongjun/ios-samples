//
//  LyricView.h
//  FreeMusic
//
//  Created by GukeManbu on 14-8-27.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LyricInfo.h"

@interface LyricView : UIView {
    UIScrollView *_scrollView;
    NSMutableArray *_lyricList;
    NSMutableArray *_rowViews;
}

-(void) loadLyric:(NSString *) fileName;

@end
