//
//  LevelScene.h
//  AngryBirds
//
//  Created by gukemanbu on 14-6-28.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCLayer.h"

static const int LEVEL_COUNT = 14;

@interface LevelScene : CCLayer {
    // 过关数
    int passedLevel;
}

+(id) scene;

@end
