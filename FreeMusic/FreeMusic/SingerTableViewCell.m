//
//  MyTableViewCell.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-6.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "SingerTableViewCell.h"

@interface SingerTableViewCell() {
    UIImageView *_photoView;
    UILabel *_lblSingerName;
    UILabel *_lblSingerCompany;
}
@end

@implementation SingerTableViewCell

@synthesize photoUrl = _photoUrl;
@synthesize singerName = _singerName;
@synthesize singerCompany = _singerCompany;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 显示向右箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // 头像
        _photoView = [[MyCircleImageView  alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
        [self addSubview:_photoView];
        [_photoView release];
        
        // 主标题（歌手名）
        _lblSingerName = [[UILabel alloc] initWithFrame:CGRectMake(70, 8, 200, 30)];
        _lblSingerName.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:_lblSingerName];
        
        // 副标题
        _lblSingerCompany = [[UILabel alloc] initWithFrame:CGRectMake(70, 35, 200, 30)];
        _lblSingerCompany.font = [UIFont systemFontOfSize:13.0f];
        _lblSingerCompany.textColor = [UIColor lightGrayColor];
        
        [self addSubview:_lblSingerCompany];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

-(void) setPhotoUrl:(NSString *)photoUrl {
    if ([photoUrl isEqualToString:_photoUrl]) {
        return;
    }
    [_photoUrl release];
    _photoUrl = [photoUrl retain];
    
    [_photoView setOnlineImage:photoUrl];
}

-(void) setSingerName:(NSString *)singerName {
    if ([singerName isEqualToString: _singerName]) {
        return;
    }
    [_singerName release];
    _singerName = [singerName retain];
    _lblSingerName.text = singerName;
}

-(void) setSingerCompany:(NSString *)singerCompany {
    if ([singerCompany isEqualToString:_singerCompany]) {
        return;
    }
    
    [_singerCompany release];
    _singerCompany = [singerCompany retain];
    _lblSingerCompany.text = singerCompany;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) dealloc {
    [_photoView release];
    [_lblSingerName release];
    [_lblSingerCompany release];
    [_photoUrl release];
    [_singerName release];
    [_singerCompany release];
    
    [super dealloc];
}

@end
