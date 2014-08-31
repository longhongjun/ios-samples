//
//  SongInfo.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-8.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "SongInfo.h"

@implementation SongInfo

@synthesize tingUid = _tingUid;
@synthesize songId = _songId;
@synthesize songName = _songName;
@synthesize albumName = _albumName;
@synthesize albumCover = _albumCover;
@synthesize duration = _duration;
@synthesize songUrl = _songUrl;
@synthesize lyricLink = _lyricLink;

-(NSString *) getDuration {
    int seconds = [_duration intValue];
    int m = seconds / 60;
    int s = seconds % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d", m, s];
}

-(float) getSeconds {
    return [_duration floatValue];
}

@end
