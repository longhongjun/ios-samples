//
//  MyCircleImageView+OnlineImage.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-7.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "MyCircleImageView+OnlineImage.h"

@implementation MyCircleImageView (OnlineImage)

- (void)setOnlineImage:(NSString *)url
{
    UIImage *img = [UIImage imageNamed:@"atavar.png"];
    [self setOnlineImage:url placeholderImage:img];
}

- (void)setOnlineImage:(NSString *)url placeholderImage:(UIImage *)image
{
    self.image = image;
    
    AsyncImageDownloader *downloader = [AsyncImageDownloader sharedImageDownloader];
    [downloader startWithUrl:url delegate:self];
}

#pragma mark -
#pragma mark - AsyncImageDownloader Delegate

- (void)imageDownloader:(AsyncImageDownloader *)downloader didFinishWithImage:(UIImage *)image
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = image;
    });
}


@end
