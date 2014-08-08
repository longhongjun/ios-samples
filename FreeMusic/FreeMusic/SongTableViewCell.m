//
//  SongTableViewCell.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-8.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "SongTableViewCell.h"

@interface SongTableViewCell (){
    UILabel *_lblName;
    UILabel *_lblAlbum;
    UILabel *_lblDuration;
}
@end

@implementation SongTableViewCell

@synthesize name = _name;
@synthesize album = _album;
@synthesize duration = _duration;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 显示向右箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // 歌曲名
        _lblName = [[UILabel alloc] initWithFrame:CGRectMake(15, 3, self.frame.size.width, self.frame.size.height / 3)];
        _lblName.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:_lblName];
        
        // 所属公司
        _lblAlbum = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, self.frame.size.width, self.frame.size.height / 3)];
        _lblAlbum.font = [UIFont systemFontOfSize:13.0f];
        _lblAlbum.textColor = [UIColor lightGrayColor];
        [self addSubview:_lblAlbum];
        
        // 时长
        _lblDuration = [[UILabel alloc] initWithFrame:CGRectMake(5, 15, self.frame.size.width - 40, self.frame.size.height / 3)];
        _lblDuration.textAlignment = NSTextAlignmentRight;
        _lblDuration.font = [UIFont systemFontOfSize:10.0f];
        _lblDuration.textColor = [UIColor lightGrayColor];
        [self addSubview:_lblDuration];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setName:(NSString *)name {
    if ([name isEqualToString:_name]) {
        return;
    }
    
    [_name release];
    _name = [name retain];
    _lblName.text = _name;
}

-(void) setAlbum:(NSString *)album {
    if ([album isEqualToString:_album]) {
        return;
    }
    
    [_album release];
    _album = [album retain];
    _lblAlbum.text = _album;
}

-(void) setDuration:(NSString *)duration {
    if ([duration isEqualToString:_duration]) {
        return;
    }
    
    [_duration release];
    _duration = [duration retain];
    _lblDuration.text = _duration;
}

-(void) dealloc {
    [_lblName release];
    [_lblAlbum release];
    [_lblDuration release];
    
    [super dealloc];
}

@end
