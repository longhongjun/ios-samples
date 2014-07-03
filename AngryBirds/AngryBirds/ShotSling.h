//
//  ShotSling.h
//  AngryBirds
//
//  Created by gukemanbu on 14-7-3.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCSprite.h"

@interface ShotSling : CCSprite {
    CGPoint _startPoint1;
    CGPoint _startPoint2;
    CGPoint _endPoint;
}

@property (nonatomic, assign) CGPoint startPoint1;
@property (nonatomic, assign) CGPoint startPoint2;
@property (nonatomic, assign) CGPoint endPoint;

@end
