//
//  RootViewController.m
//  TabelDemo
//
//  Created by GukeManbu on 14-7-22.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize dataList;
@synthesize displayList;

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
    
    _rowConunt = 10;
    self.displayList = [NSMutableArray arrayWithCapacity:DEFAULT_ROW];
    self.dataList = [NSMutableArray arrayWithCapacity:DEFAULT_ROW];
    for (int i=0; i<DEFAULT_ROW; i++) {
        [self.displayList addObject:[NSString stringWithFormat:@"Row%d", i+1]];
        [self.dataList addObject:[NSString stringWithFormat:@"Row%d", i+1]];
    }
    
    // 设置标题栏
    self.title = @"搜索与刷新";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    // 添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    NSAttributedString *msg = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    refreshControl.attributedTitle = msg;
    [msg release];
    refreshControl.tintColor = [UIColor blueColor];
    [refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [refreshControl release];
    
    // 添加搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    searchBar.placeholder = @"输入要搜索的内容";
    //searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;
    [searchBar release];
    
    // 设置底部加载控件
    _btnLoadMore = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnLoadMore.backgroundColor = [UIColor grayColor];
    [_btnLoadMore setTitle:@"加载更多" forState:UIControlStateNormal];
    [_btnLoadMore setFrame:CGRectMake(0, 0, 320, 45)];
    [_btnLoadMore addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = _btnLoadMore;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return displayList.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [displayList objectAtIndex:indexPath.row];
    return cell;
}

-(void) pullToRefresh {
    NSAttributedString *msg1 = [[NSAttributedString alloc] initWithString:@"刷新中"];
    self.refreshControl.attributedTitle = msg1;
    [msg1 release];
    
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        int count = displayList.count;
        for (int i=count; i<count+5; i++) {
            [self.displayList addObject:[NSString stringWithFormat:@"Row%i", i+1]];
            [self.dataList addObject:[NSString stringWithFormat:@"Row%i", i+1]];
        }
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        
        NSAttributedString *msg2 = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
        self.refreshControl.attributedTitle = msg2;
        [msg2 release];
    });
}

-(void) loadMore {
    _btnLoadMore.enabled = NO;
    [SVProgressHUD showWithStatus:@"加载中..."];
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime,dispatch_get_main_queue(), ^(void){
        int count = displayList.count;
        for (int i=count; i<count+5; i++) {
            [self.displayList addObject:[NSString stringWithFormat:@"Row%i", i+1]];
            [self.dataList addObject:[NSString stringWithFormat:@"Row%i", i+1]];
        }
        
        [self.tableView reloadData];
        [SVProgressHUD showSuccessWithStatus:@"加载完成"];
        _btnLoadMore.enabled = YES;
    });
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([@"" isEqualToString:searchText]) {
        self.displayList = [NSMutableArray arrayWithArray:self.dataList];
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self CONTAINS %@", searchText];
        self.displayList = [NSMutableArray arrayWithArray:[self.dataList filteredArrayUsingPredicate:predicate]];
    }

    [self.tableView reloadData];
}

-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}

-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
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