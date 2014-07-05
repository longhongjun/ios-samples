//
//  GameScene.h
//  AngryBirds
//
//  Created by gukemanbu on 14-6-29.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SpriteBase.h"
#import "Bird.h"
#import "Pig.h"
#import "Ice.h"
#import "LevelReader.h"
#import "LevelScene.h"
#import "ShotSling.h"

#define TOUCH_UNKNOW 0
#define TOUCH_BIRD 1
#define TOUCH_BACK 2
#define SHOTSLING_INIT_POINT CGPointMake(85.0f, 125.0f)

@interface GameScene : CCLayer<SpriteDelegate, CCTargetedTouchDelegate> {
    // 当前关序号
    int currentLevel;
    // 返回按钮
    CCSprite *backSprite;
    // 小鸟数组
    NSMutableArray *_birdArr;
    // 当前小鸟
    Bird *currentBird;
    // 弹弓线
    ShotSling *_shotSling;
    // 触摸状态
    int touchStatus;
    
    b2World *_world;
}

+(id) sceneWithLevel:(int)levelNum;
-(id) initWithLevel:(int)levelNum;

@end
