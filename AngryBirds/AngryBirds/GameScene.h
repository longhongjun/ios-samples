//
//  GameScene.h
//  AngryBirds
//
//  Created by gukemanbu on 14-6-29.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "CCLayer.h"
#import "cocos2d.h"
#import "SpriteBase.h"
#import "Bird.h"
#import "Pig.h"
#import "Ice.h"
#import "LevelReader.h"
#import "LevelScene.h"

@interface GameScene : CCLayer<SpriteDelegate, CCTargetedTouchDelegate> {
    // 当前关序号
    int currentLevel;
    // 小鸟数组
    NSMutableArray *birds;
    b2World *world;
}

+(id) sceneWithLevel:(int)levelNum;
-(id) initWithLevel:(int)levelNum;

@end
