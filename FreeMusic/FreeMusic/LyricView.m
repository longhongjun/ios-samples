//
//  LyricView.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-28.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "LyricView.h"

@implementation LyricView

@synthesize lyricList = _lyricList;
@synthesize lyricLabelList = _lyricLabelList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lyricList = [NSMutableArray arrayWithCapacity:10];

        // 默认第一行为空r
        LyricInfo *lyricInfo = [[LyricInfo alloc] init];
        lyricInfo.time = @"00:00";
        lyricInfo.lyric = @"";
        [self.lyricList addObject:lyricInfo];
        [lyricInfo release];

        self.lyricLabelList = [NSMutableArray arrayWithCapacity:10];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.userInteractionEnabled = NO;
        [self addSubview:_scrollView];
    }
    return self;
}

-(void) loadLyric:(NSString *) songUrl {
    NSURL *url = [NSURL URLWithString:songUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:10.0];
    
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error) {
        NSLog(@"Http error:%@%d", error.localizedDescription, error.code);
    } else {
        NSString *content = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSArray *rows = [content componentsSeparatedByString:@"\n"];
        
        for (NSString *row in rows) {
            if (row && row.length > 0) {
                NSArray *array = [row componentsSeparatedByString:@"]"];
                for (int i=0; i<array.count - 1; i++) {
                    NSString *part = [array objectAtIndex:i];
                    if (part.length > 8) {
                        NSString *colon = [part substringWithRange:NSMakeRange(3, 1)];
                        NSString *dot = [part substringWithRange:NSMakeRange(6, 1)];
                        if ([colon isEqualToString:@":"] && [dot isEqualToString:@"."]) {
                            [self addLyric:[part substringWithRange:NSMakeRange(1, 5)] andLyric:[array lastObject]];
                        }
                    }
                }
            }
        }
        
        [content release];
    }
    
    // 加载到屏幕上
    for (int i=0; i<self.lyricList.count; i++) {
        // 歌词行视图（每行歌词一个单独的视图）
        UILabel *lyricLable = [[UILabel alloc] initWithFrame:CGRectMake(0, i * 25, self.frame.size.width, 25)];
        lyricLable.text = ((LyricInfo*)self.lyricList[i]).lyric;
        lyricLable.textColor = [UIColor lightGrayColor];
        lyricLable.font = [UIFont systemFontOfSize:14.0f];
        lyricLable.textAlignment = NSTextAlignmentCenter;
        
        [self.lyricLabelList addObject:lyricLable];
        [_scrollView addSubview:lyricLable];
        
        [lyricLable release];
    }
    
    [_scrollView setContentOffset:CGPointMake(0, -self.frame.size.height / 2) animated:YES];
}

-(void) addLyric:(NSString *) time andLyric:(NSString *) lyric {
    float newTime = [[NSString stringWithFormat:@"%@.%@",
                     [time substringToIndex:2],
                     [time substringFromIndex:3]] floatValue];
    
    int index = 0;
    for (int i=0; i<self.lyricList.count; i++) {
        float curTime = [[NSString stringWithFormat:@"%@.%@",
                          [((LyricInfo*)self.lyricList[i]).time substringToIndex:2],
                          [((LyricInfo*)self.lyricList[i]).time substringFromIndex:3]] floatValue];

        if (newTime > curTime) {
            index = i + 1;
        }
    }
    
    LyricInfo *lyricInfo = [[LyricInfo alloc] init];
    lyricInfo.time = time;
    lyricInfo.lyric = lyric;
    [self.lyricList insertObject:lyricInfo atIndex:index];
    
    [lyricInfo release];
}

-(void) scrollToTime:(NSString *)time {
    int index = 0;
    for (LyricInfo *lyricInfo in self.lyricList) {
        if ([lyricInfo.time isEqualToString:time]) {
            UILabel *lyricLabel = [self.lyricLabelList objectAtIndex:index];
            lyricLabel.textColor = [UIColor redColor];
            [_scrollView setContentOffset:CGPointMake(0, -self.frame.size.height / 2 + 25*index) animated:YES];
            break;
        }
        
        index++;
    }
}

-(void) dealloc {
    [self.lyricList release];
    [self.lyricLabelList release];
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
