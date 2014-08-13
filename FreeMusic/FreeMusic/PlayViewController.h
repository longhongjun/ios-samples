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

@interface PlayViewController : UIViewController {
    MyCircleImageView *_playButtonBackground;
}

@property (nonatomic, strong) NSString *songName;
@property (nonatomic, strong) NSString *tingUid;

@end
