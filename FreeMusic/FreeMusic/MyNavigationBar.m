//
//  MyNavigationBar.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-6.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "MyNavigationBar.h"

@interface MyNavigationBar () {
    UILabel *_lblTitle;
    UIButton *_btnLeft;
    UIButton *_btnRight;
    UIImageView *_imgBackground;
    BOOL _hideLeftButton;
}

@end

@implementation MyNavigationBar

@synthesize delegate;
@synthesize headerImage;
@synthesize leftImage = _leftImage;
@synthesize rightImage = _rightImage;
@synthesize title = _title;
@synthesize backgroundColor = _backgroundColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 背景
        _imgBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imgBackground.backgroundColor = [UIColor colorWithRed:192.0f/255.0f green:37.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
        [self addSubview:_imgBackground];
        
        // 标题
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width - 200) / 2, 0, 200, frame.size.height)];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.backgroundColor = [UIColor clearColor];
        _lblTitle.textColor = [UIColor whiteColor];
        _lblTitle.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:_lblTitle];
        
        // 左按钮
        _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnLeft addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnLeft];
        
        // 右按钮
        _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRight addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnRight];
    }
    return self;
}

-(void) setTitle:(NSString *)title {
    _lblTitle.text = title;
}

-(void) setLeftImage:(UIImage *)leftImage {
    _btnLeft.frame = CGRectMake(8, (self.frame.size.height - leftImage.size.height) / 2, leftImage.size.width, leftImage.size.height);
    [_btnLeft setImage:leftImage forState:UIControlStateNormal];
}

-(void) setRightImage:(UIImage *)rightImage {
    _btnRight.frame = CGRectMake(self.frame.size.width - rightImage.size.width - 8, (self.frame.size.height - rightImage.size.height) / 2, rightImage.size.width, rightImage.size.height);
    [_btnRight setImage:rightImage forState:UIControlStateNormal];
}

-(void) setBackgroundColor:(UIColor *)backgroundColor {
    _imgBackground.backgroundColor = backgroundColor;
}

-(void) leftButtonClicked {
    [self.delegate leftButtonClicked];
}

-(void) rightButtonClicked {
    [self.delegate rightButtonClicked];
}

-(void) hideLeftButton {
    if (_hideLeftButton) {
        return;
    }
    
    [_btnLeft setHidden:YES];
}

-(void) dealloc {
    [_imgBackground release];
    [_lblTitle release];
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
