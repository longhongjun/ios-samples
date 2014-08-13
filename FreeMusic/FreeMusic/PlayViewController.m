//
//  PlayViewController.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-5.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController () {
    // 播放进度
    UILabel *_lblProgressTime;
    // 进度条
    UISlider *_sliderProgress;
    // 总时间
    UILabel *_lblTotalTime;
    // 播放模式
    //UIButton *btnPlayMode;
}

@end

@implementation PlayViewController

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
    // 隐藏底部选项卡
    self.tabBarController.tabBar.hidden = YES;
    
    // 添加自定义导航栏
    MyNavigationBar *myNavigationBar = [[MyNavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    myNavigationBar.title = @"正在播放...";
    myNavigationBar.leftImage = [UIImage imageNamed:@"nav_backbtn"];
    myNavigationBar.delegate = (id)self;
    [self.view addSubview:myNavigationBar];
    [myNavigationBar release];
    
    // 播放进度部分
    [self initProgressView];
    
    // 中间的部分 收藏 下载 歌词
    [self initMiddleView];
    
    // 底部控制部分
    [self initControlView];
}

-(void) initProgressView {
    // 播放进度
    _lblProgressTime = [[UILabel alloc] initWithFrame:CGRectMake(5, 69, 50, 25)];
    _lblProgressTime.font= [UIFont systemFontOfSize:14.0f];
    _lblProgressTime.textAlignment = NSTextAlignmentCenter;
    _lblProgressTime.textColor = [UIColor blackColor];
    _lblProgressTime.text = @"00:00";
    [self.view addSubview:_lblProgressTime];
    
    // 进度条
    _sliderProgress = [[UISlider alloc] initWithFrame:CGRectMake(60, 79, 200, 6)];
    _sliderProgress.continuous = YES;
    _sliderProgress.minimumTrackTintColor = [UIColor colorWithRed:244.0f/255.0f green:147.0f/255.0f blue:23.0f/255.0f alpha:1.0f];
    _sliderProgress.maximumTrackTintColor = [UIColor lightGrayColor];
    [_sliderProgress setThumbImage:[UIImage imageNamed:@"slider-thumb"] forState:UIControlStateNormal];
    [self.view addSubview:_sliderProgress];
    
    // 总时间
    _lblTotalTime = [[UILabel alloc] initWithFrame:CGRectMake(265, 69, 50, 25)];
    _lblTotalTime.font= [UIFont systemFontOfSize:14.0f];
    _lblTotalTime.textAlignment = NSTextAlignmentCenter;
    _lblTotalTime.textColor = [UIColor blackColor];
    _lblTotalTime.text = @"00:00";
    [self.view addSubview:_lblTotalTime];
}

-(void) initMiddleView {
    // 歌词view
    UIScrollView *lyricScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 94, 320, 318)];
    lyricScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lyricScrollView];
    
    // 收藏按钮
    UIButton *btnCollect = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCollect.frame = CGRectMake(5, 90, 48, 48);
    [btnCollect setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    [btnCollect setImage:[UIImage imageNamed:@"collected"] forState:UIControlStateHighlighted];
    [btnCollect addTarget:self action:@selector(storeTheSong) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCollect];
    
    // 下载按钮
    UIButton *btnDownload = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDownload.frame = CGRectMake(267, 90, 48, 48);
    [btnDownload setImage:[UIImage imageNamed:@"downLoad"] forState:UIControlStateNormal];
    [btnDownload addTarget:self action:@selector(storeTheSong) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDownload];
}

-(void) storeTheSong {
}

-(void) initControlView {
    // 播放模式 顺序 单曲循环 随机
    UIButton *btnPlayMode = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPlayMode.frame = CGRectMake(5, 420, 48, 48);
    [btnPlayMode setImage:[UIImage imageNamed:@"order"] forState:UIControlStateNormal];
    [btnPlayMode addTarget:self action:@selector(switchPlayMode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPlayMode];
    
    // 上一首按钮
    UIButton *btnPrevious = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPrevious.frame = CGRectMake(60, 420, 48, 48);
    [btnPrevious setImage:[UIImage imageNamed:@"preSong"] forState:UIControlStateNormal];
    [btnPrevious addTarget:self action:@selector(playPreviousSong) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPrevious];
    
    // 播放按钮旋转背景
    _playButtonBackground = [[MyCircleImageView alloc] initRotateWithFrame:CGRectMake(128, 412, 64, 64)];
    [_playButtonBackground setOnlineImage:nil placeholderImage:[UIImage imageNamed:@"avatar.png"]];
    [self.view addSubview:_playButtonBackground];
    
    // 播放或暂停按钮
    UIButton *btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPlay.frame = CGRectMake(128, 412, 64, 64);
    [btnPlay setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [btnPlay addTarget:self action:@selector(playOrPause:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPlay];
    
    // 下一首按钮
    UIButton *btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNext.frame = CGRectMake(212, 420, 48, 48);
    [btnNext setImage:[UIImage imageNamed:@"nextSong"] forState:UIControlStateNormal];
    [btnNext addTarget:self action:@selector(playNextSong) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNext];
    
    // 播放列表按钮
    UIButton *btnPlayList = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPlayList.frame = CGRectMake(267, 420, 48, 48);
    [btnPlayList setImage:[UIImage imageNamed:@"playList"] forState:UIControlStateNormal];
    [btnPlayList addTarget:self action:@selector(gotoPlayListView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPlayList];
}

-(void) switchPlayMode:(UIButton*) sender {
    NSArray *imageArray = [NSArray arrayWithObjects:@"order", @"repeate", @"random", nil];
    sender.tag = sender.tag + 1;
    if (sender.tag > 2) {
        sender.tag = 0;
    }
    
    [sender setImage:[UIImage imageNamed:[imageArray objectAtIndex:sender.tag]] forState:UIControlStateNormal];
}

-(void) playPreviousSong {
    
}

-(void) playOrPause:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected) {
        [_playButtonBackground startRotate];
    } else {
        [_playButtonBackground stopRotate];
    }
    
    NSString *imgName = sender.isSelected ? @"pauseHight" : @"play";
    
    [sender setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
}

-(void) playNextSong {

}

-(void) gotoPlayListView {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) leftButtonClicked {
    // 返回上一个页面
    [self.navigationController popViewControllerAnimated:YES];
    // 显示底部选项卡
    self.tabBarController.tabBar.hidden = NO;
}

-(void) dealloc {
    [_lblProgressTime release];
    [_sliderProgress release];
    [_lblTotalTime release];
    
    [super dealloc];
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
