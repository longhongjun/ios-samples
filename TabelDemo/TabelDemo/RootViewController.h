//
//  RootViewController.h
//  TabelDemo
//
//  Created by GukeManbu on 14-7-22.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

#define TOTAL_ROW 100
#define DEFAULT_ROW 10
#define ROW_HEIGHT 45

@interface RootViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    NSInteger _rowConunt;
    UIButton *_btnLoadMore;
}

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSMutableArray *displayList;

@end