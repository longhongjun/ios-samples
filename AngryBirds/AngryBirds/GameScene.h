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
#import "ShotSling.h"

#define TOUCH_UNKNOW 0
#define TOUCH_BIRD 1

@interface GameScene : CCLayer<SpriteDelegate, CCTargetedTouchDelegate> {
    // 当前关序号
    int currentLevel;
    // 小鸟数组
    NSMutableArray *birds;
    // 当前小鸟
    Bird *currentBird;
    // 弹弓线
    ShotSling *shotSling;
    // 触摸状态
    int touchStatus;
    
    b2World *world;
}

+(id) sceneWithLevel:(int)levelNum;
-(id) initWithLevel:(int)levelNum;

@end
