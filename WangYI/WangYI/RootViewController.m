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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initHeaderBar {
    // 添加标题
    UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midTitleNight332_56.jpg"]];
    [titleImage setFrame:CGRectMake(40, 20, 240, 40)];
    [self.view addSubview:titleImage];
    [titleImage release];
    
    // 添加左边菜单按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 40, 40)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"leftTitleUpNitht70_70.jpg"] forState:UIControlStateNormal];
    //[leftButton setBackgroundImage:[UIImage imageNamed:@"leftTitleUp70_70.jpg"] forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(showLeftSliderBar:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    [leftButton release];
    
    // 添加右边用户按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 20, 40, 40)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"rightTitleUpNight70_70.jpg"] forState:UIControlStateNormal];
    //[rightButton setBackgroundImage:[UIImage imageNamed:@"rightTitleUp70_70.jpg"] forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(showRightSliderBar:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    [rightButton release];
}

-(void) initTitleBar {
    // 添加横向滚动面板，存放标题用
    _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, 280, 30)];

    for (int i=0; i<_titleArray.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * 50, 0, 36, 28)];
        [button setTitle:[_titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"Arial" size:18.0f]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTag: i + 100];
        [button addTarget:self action:@selector(switchTitle:) forControlEvents:UIControlEventTouchUpInside];
        
        [_titleScrollView addSubview:button];
        [button release];
        
        // 按钮下面的红线
        UIButton *buttonLine = [[UIButton alloc] initWithFrame:CGRectMake(i * 50, 28, 50, 2)];
        [buttonLine setTag:(i + 100) * 2];
        [_titleScrollView addSubview:buttonLine];
        [buttonLine release];
    }
    
    [self.view addSubview:_titleScrollView];
}

-(void) switchTitle:(id)sender {
    UIButton *button = (UIButton*)sender;
    button.selected = !button.selected;
    [[_titleScrollView viewWithTag:button.tag * 2] setBackgroundColor:[UIColor redColor]];
    
    NSLog(@"%d", ((UIButton*)sender).tag);
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
