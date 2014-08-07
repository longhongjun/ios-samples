//
//  MyTableViewCell.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-6.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "MyTableViewCell.h"

@interface MyTableViewCell() {
    UIImageView *_photoView;
    UILabel *_lblSingerName;
    UILabel *_lblSingerCompany;
}
@end

@implementation MyTableViewCell

@synthesize photo = _photo;
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
        _lblSingerName = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 200, 30)];
        _lblSingerName.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:_lblSingerName];
        
        // 副标题
        _lblSingerCompany = [[UILabel alloc] initWithFrame:CGRectMake(70, 25, 200, 30)];
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

-(void) setPhoto:(UIImage *)photo {
    _photo = photo;
    _photoView.image = photo;
}

-(void) setSingerName:(NSString *)singerName {
    _singerName = singerName;
    _lblSingerName.text = singerName;
}

-(void) setSingerCompany:(NSString *)singerCompany {
    _singerCompany = singerCompany;
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
    
    [super dealloc];
}

@end
