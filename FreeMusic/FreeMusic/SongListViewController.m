//
//  SongListViewController.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-7.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "SongListViewController.h"

@interface SongListViewController () {
    NSInteger _offset;
    NSInteger _limits;
}

@end

@implementation SongListViewController

@synthesize singer = _singer;
@synthesize tingUid = _tingUid;

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
    // 初始化类变量
    _offset = 0;
    _limits = 10;
    
    // 同步请求歌曲列表
    [self initSongList];

    // 添加自定义导航栏
    MyNavigationBar *myNavigationBar = [[MyNavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    myNavigationBar.title = self.singer;
    myNavigationBar.leftImage = [UIImage imageNamed:@"nav_backbtn"];
    myNavigationBar.rightImage = [UIImage imageNamed:@"nav_music"];
    myNavigationBar.delegate = (id)self;
    [self.view addSubview:myNavigationBar];
    [myNavigationBar release];
    
    // 表视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 372) style:UITableViewStylePlain];
    tableView.tag = 1;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView release];
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

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songList.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SongCell";
    SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[SongTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    SongInfo *songInfo = [self.songList objectAtIndex:indexPath.row];
    cell.name = songInfo.songName;
    cell.album = songInfo.albumName;
    cell.duration = songInfo.duration;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayViewController *playViewController = [[PlayViewController alloc] init];
    playViewController.songInfo = self.songList[indexPath.row];
    
    [self.navigationController pushViewController:playViewController animated:YES];
    [playViewController release];
}

- (void)initSongList{
    [ProgressHUD show:nil];
    // 初始化歌曲数组
    self.songList = [NSMutableArray arrayWithCapacity:30];
    
    // 歌曲列表url 此url没有包含歌曲链接地址
    NSURL *songListUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&tinguid=%@&offset=%d&limits=%d", SONG_LIST_URL, _tingUid, _offset, _limits]];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:songListUrl];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:10.0];
    NSError *error = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error) {
        NSLog(@"Http error:%@%d", error.localizedDescription, error.code);
    } else {
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *songlist = [jsonData objectForKey:@"songlist"];
        for (NSDictionary *song in songlist) {
            SongInfo *songInfo = [[SongInfo alloc] init];
            songInfo.tingUid = song[@"ting_uid"];
            songInfo.songId = song[@"song_id"];
            songInfo.songName = song[@"title"];
            songInfo.albumName = song[@"album_title"];
            songInfo.albumCover = song[@"pic_small"];
            songInfo.duration = song[@"file_duration"];
            songInfo.lyricLink = song[@"lrclink"];
            [self.songList addObject:songInfo];
            [songInfo release];
        }
    }

    [ProgressHUD dismiss];
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

-(void) dealloc {
    self.songList = nil;

    [super dealloc];
}

@end
