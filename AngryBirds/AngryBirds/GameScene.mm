//
//  GameScene.m
//  AngryBirds
//
//  Created by gukemanbu on 14-6-29.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "GameScene.h"
#import "cocos2d.h"

@implementation GameScene

+(id) scene {
    CCScene *scene = [CCScene node];
    GameScene *gameScene = [GameScene node];
    [scene addChild:gameScene];
    
    return scene;
}

+(id) node {
    return [[[[self class] alloc] init] autorelease];
}

-(id) init {
    self = [super init];
    if (!self) {
        return self;
    }
    
    // 获得屏幕尺寸
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // 创建背景精灵
    CCSprite *bgSprite = [CCSprite spriteWithFile:@"game-bg.png"];
    [bgSprite setPosition:ccp(winSize.width / 2.0f, winSize.height / 2.0f)];
    [self addChild:bgSprite];
    
    // 创建左弹弓
    CCSprite *leftShot = [CCSprite spriteWithFile:@"leftshot.png"];
    leftShot.position = ccp(85, 110);
    [self addChild:leftShot];
    // 创建右弹工
    CCSprite *rightShot = [CCSprite spriteWithFile:@"rightshot.png"];
    rightShot.position = ccp(85, 110);
    [self addChild:rightShot];
    
    return self;
}

@end
