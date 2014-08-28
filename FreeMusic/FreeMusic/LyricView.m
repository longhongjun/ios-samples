//
//  LyricView.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-27.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "LyricView.h"

@implementation LyricView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lyricList = [NSMutableArray arrayWithCapacity:50];
        _rowViews = [NSMutableArray arrayWithCapacity:50];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.userInteractionEnabled = NO;
        [self addSubview:_scrollView];
    }
    return self;
}

// 加载歌词
-(void) loadLyric:(NSString *) fileName {
    NSString *testFile = [[NSBundle mainBundle] pathForResource:@"最初的梦想" ofType:@"lrc"];
    NSString *content = [NSString stringWithContentsOfFile:testFile encoding:NSUTF8StringEncoding error:nil];
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
                        LyricInfo *lyric = [[LyricInfo alloc] init];
                        lyric.time = [part substringFromIndex:1];;
                        lyric.lyric = [part lastPathComponent];
                        [_lyricList addObject:lyric];
                        NSLog(@"%@,  %@", lyric.time, lyric.lyric);
                        
                        [lyric release];
                    }
                }
            }
        }
    }
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
