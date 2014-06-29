//
//  StartScene.m
//  AngryBirds
//
//  Created by gukemanbu on 14-6-28.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "StartScene.h"
#import "cocos2d.h"
#import "LevelScene.h"

@implementation StartScene

+(id) scene {
    CCScene *scene = [CCScene node];
    StartScene *startScene = [StartScene node];
    [scene addChild:startScene];
    
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
    CCSprite *bgSprite = [CCSprite spriteWithFile:@"startbg.png"];
    //bgSprite.scale = 0.5f;
    [bgSprite setPosition:ccp(winSize.width / 2.0f, winSize.height / 2.0f)];
    // 把背景精灵加到场景里
    [self addChild:bgSprite];
    
    // 创建标题精灵
    CCSprite *titleSprite = [CCSprite spriteWithFile:@"title.png"];
    titleSprite.scale = 0.5f;
    [titleSprite setPosition:ccp(240.0f, 230.0f)];
    // 把标题精灵加到场景里
    [self addChild:titleSprite];
    
    // 创建开始精灵
    CCSprite *beginSprite = [CCSprite spriteWithFile:@"start.png"];
    //beginSprite.scale = 0.5f;
    // 创建开始菜单项精灵
    CCMenuItemSprite *beginItemSprite = [CCMenuItemSprite itemFromNormalSprite:beginSprite selectedSprite:nil target:self selector:@selector(displayLevelScene:)];
    // 创建菜单
    CCMenu *menu = [CCMenu menuWithItems:beginItemSprite, nil];
    menu.scale = 0.5f;
    [menu setPosition:ccp(120.0f, 30.0f)];
    [self addChild:menu];
    
    // 创建定时器，每2秒创建一个飞鸟
    [self schedule:@selector(createOneBird:) interval:2.0f];
    
    return self;
}

-(void) displayLevelScene: (id)arg {
    CCScene *levelScene = [LevelScene scene];
    // 创建过渡动画
    CCTransitionScene *tran = [[CCTransitionFlipX alloc] initWithDuration:1.0f scene:levelScene];
    
    [[CCDirector sharedDirector] replaceScene:tran];
    [tran release];
}

-(void) createOneBird: (double)unuse {
    CCSprite *bird = [CCSprite spriteWithFile:@"bird1.png"];
    // 小鸟的大小随机
    bird.scale = (arc4random() % 5) / 10.0f;
    // 设置小鸟的起始位置
    [bird setPosition:ccp(50.0f + arc4random()%50, 70.0f)];
    // 设置小鸟的终止位置
    CGPoint endPoint = ccp(360.0f + arc4random()%50, 70.0f);
    // 设置小鸟的最高高度
    CGFloat maxHeight = 50.0f + arc4random()%100;
    
    // 创建一个飞行动作
    id flyAction = [CCJumpTo actionWithDuration:2.0f position:endPoint height:maxHeight jumps:1];
    // 创建飞行完成动作
    id flyFinishAction = [CCCallFuncN actionWithTarget:self selector:@selector(finishedFlying:)];
    // 创建动作序列
    CCSequence *actionList = [CCSequence actions:flyAction, flyFinishAction, nil];
    // 让小鸟执行动作序列
    [bird runAction:actionList];
    
    [self addChild:bird];
}

-(void) finishedFlying: (CCNode *) currenNode {
    [currenNode removeFromParentAndCleanup:YES];
}

@end
