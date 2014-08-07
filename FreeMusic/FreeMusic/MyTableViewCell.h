//
//  MyTableViewCell.h
//  FreeMusic
//
//  Created by GukeManbu on 14-8-6.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCircleImageView+OnlineImage.h"

@interface MyTableViewCell : UITableViewCell

@property (nonatomic, assign) NSString *photoUrl;
@property (nonatomic, assign) NSString *singerName;
@property (nonatomic, assign) NSString *singerCompany;

@end
