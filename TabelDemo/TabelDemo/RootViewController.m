//
//  RootViewController.m
//  TabelDemo
//
//  Created by GukeManbu on 14-7-22.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () {
    UITableViewCellEditingStyle currentEditingStyle;
}

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
    
    // 添加 删除按钮
    UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClicked)];
    UIBarButtonItem *btnDelete = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteButtonClicked)];
    NSArray *leftButtons = [NSArray arrayWithObjects:btnAdd, btnDelete, nil];
    [btnAdd release];
    [btnDelete release];
    self.navigationItem.leftBarButtonItems = leftButtons;
    
    // 右边编辑按钮
    UIBarButtonItem *btnEdit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(editButtonClicked)];
    self.navigationItem.rightBarButtonItem = btnEdit;
    [btnEdit release];
    
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

// 下拉刷新
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

// 加载更多
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

// 当前编辑模式
-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return currentEditingStyle;
}

// 行选择事件
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self updateBarButtons];
}

// 添加或删除事件
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.displayList removeObjectAtIndex:indexPath.row];
        [self.dataList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [self.displayList insertObject:@"new Row" atIndex:indexPath.row];
        [self.dataList insertObject:@"new Row" atIndex:indexPath.row];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

// 是否支持编辑
-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 是否支持行移动
-(BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 移动行
-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    id row = [self.displayList objectAtIndex:sourceIndexPath.row];
    [self.displayList removeObjectAtIndex:sourceIndexPath.row];
    [self.displayList insertObject:row atIndex:destinationIndexPath.row];
    
    [self.dataList removeObjectAtIndex:sourceIndexPath.row];
    [self.dataList insertObject:row atIndex:destinationIndexPath.row];
    
    [row release];
}

// 添加按钮action
-(void) addButtonClicked {
    currentEditingStyle = UITableViewCellEditingStyleInsert;
    [self.tableView setEditing:YES animated:YES];
    [self updateBarButtons];
}

// 删除按钮action
-(void) deleteButtonClicked {
    currentEditingStyle = UITableViewCellEditingStyleDelete;
    [self.tableView setEditing:YES animated:YES];
    [self updateBarButtons];
}

// 编辑按钮action
-(void) editButtonClicked {
    [self.tableView setAllowsMultipleSelectionDuringEditing:YES];
    [self.tableView setEditing:YES animated:YES];
    [self updateBarButtons];
}

// done按钮action
-(void) doneButtonClicked {
    [self.tableView setEditing:NO animated:YES];
    [self updateBarButtons];
}

// 取消按钮action
-(void) cancelButtonClicked {
    [self.tableView setAllowsMultipleSelectionDuringEditing:NO];
    [self.tableView setEditing:NO animated:YES];
    [self updateBarButtons];
}

-(void) updateBarButtons {
    if (self.tableView.allowsMultipleSelectionDuringEditing == YES) {
        NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
        
        UIBarButtonItem *btnDelete = [[UIBarButtonItem alloc] initWithTitle:@"删除全部" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteMutipleRows)];
        if (selectedRows.count > 0 && selectedRows.count < self.displayList.count) {
            [btnDelete setTitle:[NSString stringWithFormat:@"删除（%d）", selectedRows.count]];
        }
        
        self.navigationItem.leftBarButtonItems = nil;
        self.navigationItem.leftBarButtonItem = btnDelete;
        
        UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonClicked)];
        self.navigationItem.rightBarButtonItem = btnCancel;
        return;
    }
    
    if ([self.tableView isEditing]) {
        UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonClicked)];
        self.navigationItem.rightBarButtonItem = btnDone;
        [btnDone release];
    } else {
        UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClicked)];
        UIBarButtonItem *btnDelete = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteButtonClicked)];
        NSArray *leftButtons = [NSArray arrayWithObjects:btnAdd, btnDelete, nil];
        [btnAdd release];
        [btnDelete release];
        self.navigationItem.leftBarButtonItems = leftButtons;
        
        UIBarButtonItem *btnEdit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(editButtonClicked)];
        self.navigationItem.rightBarButtonItem = btnEdit;
        [btnEdit release];
    }
}

// 删除多行
-(void) deleteMutipleRows {
    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    if (selectedRows.count > 0 && selectedRows.count < self.displayList.count) {
        for (NSIndexPath *row in selectedRows) {
            [self.displayList removeObjectAtIndex:row.row];
            [self.dataList removeObjectAtIndex:row.row];
        }
        
        [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        [self.displayList removeAllObjects];
        [self.dataList removeAllObjects];
        
        [self.tableView reloadData];
    }
    
    [self updateBarButtons];
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