//
//  SongListViewController.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-7.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "SongListViewController.h"

@interface SongListViewController ()

@end

@implementation SongListViewController

@synthesize singer = _singer;

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

    // 添加自定义导航栏
    MyNavigationBar *myNavigationBar = [[MyNavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    myNavigationBar.title = self.singer;
    myNavigationBar.leftImage = [UIImage imageNamed:@"nav_backbtn"];
    myNavigationBar.rightImage = [UIImage imageNamed:@"nav_music"];
    myNavigationBar.delegate = (id)self;
    [self.view addSubview:myNavigationBar];
    [myNavigationBar release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) leftButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) rightButtonClicked {
    UIViewController *playViewController = [[PlayViewController alloc] init];
    [self.navigationController pushViewController:playViewController animated:YES];
    [playViewController release];
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
