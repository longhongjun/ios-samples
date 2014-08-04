//
//  RootViewController.m
//  WangYI
//
//  Created by GukeManbu on 14-7-25.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // not work
        [self.view setFrame:CGRectMake(0, 20, 320, 460)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _titleArray = [[NSMutableArray alloc] initWithObjects:@"财经", @"科技", @"军事", @"数码", @"手机", @"移动互联", @"国际", @"国内", @"探索", @"深度", @"汽车", @"房产", nil];
    
    // 初始化头部
    [self initHeaderBar];
    
    // 初始化标题栏（二级菜单）
    [self initTitleBar];
    
    // 标题右边的下拉按钮
    [self addDropdownButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initHeaderBar {
    // 添加标题
    UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midTitle334_56.jpg"]];
    [titleImage setFrame:CGRectMake(40, 20, 240, 40)];
    [self.view addSubview:titleImage];
    [titleImage release];
    
    // 添加左边菜单按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 40, 40)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"leftTitleUp70_70.jpg"] forState:UIControlStateNormal];
    //[leftButton setBackgroundImage:[UIImage imageNamed:@"leftTitleUp70_70.jpg"] forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(showLeftSliderBar:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    [leftButton release];
    
    // 添加右边用户按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 20, 40, 40)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"rightTitleUp70_70.jpg"] forState:UIControlStateNormal];
    //[rightButton setBackgroundImage:[UIImage imageNamed:@"rightTitleUp70_70.jpg"] forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(showRightSliderBar:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    [rightButton release];
}

-(void) initTitleBar {
    // 添加横向滚动面板，存放标题用
    _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, 280, 30)];
    [_titleScrollView setContentSize:CGSizeMake(560, 30)];
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    //titleScrollView.scrollEnabled = YES;

    // 记录下title长度
    NSInteger titleLength = 0;
    // 添加标题
    for (int i=0; i<_titleArray.count; i++) {
        NSString *title = [_titleArray objectAtIndex:i];
        NSInteger titleWidth = title.length * 18;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(titleLength, 0, titleWidth + 14, 28)];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:[_titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"Arial" size:18.0f]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTag: i + 100];
        [button addTarget:self action:@selector(switchTitle:) forControlEvents:UIControlEventTouchUpInside];
        
        [_titleScrollView addSubview:button];
        [button release];
        
        // 按钮下面的红线
        UIButton *buttonLine = [[UIButton alloc] initWithFrame:CGRectMake(titleLength, 28, titleWidth + 14, 2)];
        [buttonLine setTag:(i + 100) * 2];
        [_titleScrollView addSubview:buttonLine];
        [buttonLine release];
        
        titleLength += titleWidth + 14;
    }
    
    [self.view addSubview:_titleScrollView];
}

-(void) switchTitle:(id)sender {
    for (int i=0; i<_titleArray.count; i++) {
        [((UIButton*)[self.view viewWithTag:100 + i]) setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [((UIButton*)[self.view viewWithTag:(i+100) * 2]) setBackgroundColor:[UIColor whiteColor]];
    }
    
    UIButton *button = (UIButton*)sender;
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [[self.view viewWithTag:button.tag * 2] setBackgroundColor:[UIColor redColor]];
    
    // 此按钮居中显示
    if (button.center.x > 140 && button.center.x < 560) {
        [UIView animateWithDuration:0.2 animations:^{
            [_titleScrollView setContentOffset:CGPointMake(button.center.x - 140, 0)];
        }];
    }
}

-(void) addDropdownButton {
    UIButton *btnDropdown = [[UIButton alloc] initWithFrame:CGRectMake(280, 60, 40, 30)];
    [btnDropdown setBackgroundImage:[UIImage imageNamed:@"secondDayDown65_65.jpg"] forState:UIControlStateNormal];
    [self.view addSubview:btnDropdown];
    
    [btnDropdown release];
}

// 显示左边侧滑栏
-(void) showLeftSliderBar:(id)sender {
    ((UIButton*)sender).selected = !((UIButton*)sender).selected;
}

// 显示右边侧滑栏
-(void) showRightSliderBar:(id)sender {
    ((UIButton*)sender).selected = !((UIButton*)sender).selected;
}

-(void) dealloc {
    [super dealloc];
    [_titleArray release];
    [_titleScrollView release];
}

@end
