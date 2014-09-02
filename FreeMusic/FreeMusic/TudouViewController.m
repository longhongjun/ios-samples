//
//  TudouViewController.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-5.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "TudouViewController.h"

@interface TudouViewController ()
@end

@implementation TudouViewController

@synthesize chooseArray = _chooseArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 隐藏系统导航栏
    [self.navigationController setNavigationBarHidden:YES];
    
    // 添加自定义导航栏
    MyNavigationBar *myNavigationBar = [[MyNavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    myNavigationBar.title = @"土豆视频";
    myNavigationBar.rightImage = [UIImage imageNamed:@"nav_search"];
    myNavigationBar.delegate = (id)self;
    [self.view addSubview:myNavigationBar];
    [myNavigationBar release];
    
    // 下拉列表数组
    self.chooseArray = [NSMutableArray arrayWithArray:@[
        @[@"原创",@"电视剧",@"动漫",@"电影",@"综艺",@"音乐",@"纪实",@"搞笑",@"游戏",@"娱乐",@"资讯",@"汽车",@"科技",@"体育",@"时尚",@"生活",@"健康",@"教育",@"曲艺",@"旅游",@"美容",@"母婴",@"财经",@"网络剧",@"微电影",@"女性",@"其他1",@"其他2",@"其他3",@"其他4",@"其他5",],
        @[@"人气最旺",@"最新发布",@"收藏最多",@"打分最高",@"评论最狠",@"土豆推荐",@"清晰视频序",], ]];
    
    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    [self.view addSubview:dropDownView];
    [dropDownView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) rightButtonClicked {

}

#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    NSLog(@"童大爷选了section:%d ,index:%d",section,index);
}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [self.chooseArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry = self.chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return self.chooseArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
