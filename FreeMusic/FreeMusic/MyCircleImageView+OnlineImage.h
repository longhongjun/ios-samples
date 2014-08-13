//
//  MyCircleImageView+OnlineImage.h
//  FreeMusic
//
//  Created by GukeManbu on 14-8-7.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "MyCircleImageView.h"
#import "AsyncImageDownloader.h"

@interface MyCircleImageView (OnlineImage) <AsyncImageDownloaderDelegate>

- (void)setOnlineImage:(NSString *)url;
- (void)setOnlineImage:(NSString *)url placeholderImage:(UIImage *)image;

@end
