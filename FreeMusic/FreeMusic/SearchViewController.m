//
//  RootViewController.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-5.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize singerList;

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
    myNavigationBar.title = @"Free Music";
    myNavigationBar.rightImage = [UIImage imageNamed:@"nav_music"];
    myNavigationBar.delegate = (id)self;
    [self.view addSubview:myNavigationBar];
    [myNavigationBar release];
    
    // 搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 320, 30)];
    searchBar.delegate = self;
    searchBar.placeholder = @"歌手名字";
    [self.view addSubview:searchBar];
    [searchBar release];
    
    // 表视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 94, 320, 340) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView release];
    
    // 从FreeMusic.db里读取歌手信息
    [self initSingerList];
}

-(void) initSingerList {
    self.singerList = [NSMutableArray arrayWithCapacity:100];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"FreeMusic.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        [db release];
        NSLog(@"打开数据库失败。");
        return ;
    }
    
    FMResultSet *resultSet = [db executeQuery:@"select * from FMSongerInfor"];
    int i = 0;
    while ([resultSet next]) {
        if (i > 100) {
            break;
        }

        SingerInfo *singer = [[SingerInfo alloc] init];
        singer.name = [resultSet stringForColumn:@"name"];
        singer.company = [resultSet stringForColumn:@"company"];
        singer.photoUrl = [resultSet stringForColumn:@"avatar_small"];
        [singerList addObject:singer];
        [singer release];
        
        i++;
    }
    
    // 关闭数据库
    [db close];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

-(void) rightButtonClicked {
    UIViewController *playViewController = [[PlayViewController alloc] init];
    [self.navigationController pushViewController:playViewController animated:YES];
    [playViewController release];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.singerList.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ReuseCell";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    SingerInfo *singer = [singerList objectAtIndex:indexPath.row];
    cell.photoUrl = singer.photoUrl;
    cell.singerName = singer.name;
    cell.singerCompany = singer.company;

    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SingerInfo *singerInfo = [self.singerList objectAtIndex:indexPath.row];
    
    SongListViewController *songListViewController = [[SongListViewController alloc] init];
    songListViewController.singer = singerInfo.name;
    [self.navigationController pushViewController:songListViewController animated:YES];
    [songListViewController release];
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
