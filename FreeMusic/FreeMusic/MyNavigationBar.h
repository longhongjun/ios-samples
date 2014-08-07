//
//  MyNavigationBar.h
//  FreeMusic
//
//  Created by GukeManbu on 14-8-6.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyNavigationBarDelegate <NSObject>

// 左按钮点击事件
-(void) leftButtonClicked;
// 右按钮点击事件
-(void) rightButtonClicked;

@end

@interface MyNavigationBar : UIView

@property (nonatomic, assign) id<MyNavigationBarDelegate> delegate;
@property (nonatomic, retain) UIImage *headerImage;
@property (nonatomic, retain) UIImage *leftImage;
@property (nonatomic, retain) UIImage *rightImage;
@property (nonatomic, assign) NSString *title;
@property (nonatomic, assign) UIColor *backgroundColor;

- (void) hideLeftButton;

@end
