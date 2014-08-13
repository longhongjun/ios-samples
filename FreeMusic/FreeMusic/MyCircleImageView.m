//
//  MyCircleImageView.m
//  FreeMusic
//
//  Created by GukeManbu on 14-8-6.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "MyCircleImageView.h"

@implementation MyCircleImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2.0f;
        self.layer.masksToBounds = NO;
        self.clipsToBounds = YES;
    }
    return self;
}

-(id) initRotateWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2.0f;
        self.layer.masksToBounds = NO;
        self.clipsToBounds = YES;
        
        CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotateAnimation.toValue = [NSNumber numberWithFloat:2.0 *M_PI];
        rotateAnimation.duration = 3.0f;
        rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        rotateAnimation.cumulative = NO;
        rotateAnimation.removedOnCompletion = NO; //No Remove
        
        rotateAnimation.repeatCount = FLT_MAX;
        [self.layer addAnimation:rotateAnimation forKey:@"AnimatedKey"];
        
        self.layer.speed = 0.0f;
    }
    return self;
}

-(void) startRotate {
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    self.layer.beginTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
}

-(void) stopRotate {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
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
