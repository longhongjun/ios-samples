//
//  LevelScene.m
//  AngryBirds
//
//  Created by gukemanbu on 14-6-28.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "LevelScene.h"
#import "cocos2d.h"
#import "StartScene.h"
#import "GameScene.h"

@implementation LevelScene

+(id) scene {
    CCScene *scene = [CCScene node];
    LevelScene *levelScene = [LevelScene node];
    [scene addChild:levelScene];
    
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
    CCSprite *bgSprite = [CCSprite spriteWithFile:@"levelbg.png"];
    bgSprite.scale = 0.5f;
    [bgSprite setPosition:ccp(winSize.width / 2.0f, winSize.height / 2.0f)];
    [self addChild:bgSprite];
    
    // 创建返回精灵
    CCSprite *backSprite = [CCSprite spriteWithFile:@"backarrow.png"];
    backSprite.scale = 0.5f;
    backSprite.tag = 0;
    [backSprite setPosition:ccp(60.0f, 40.0f)];
    [self addChild:backSprite];
    
    // 打开屏幕的触摸开关，使屏幕能响应触摸事件
    [self setIsTouchEnabled:YES];
    
    passedLevel = 2;
    // 添加14个按钮
    for(int i=0; i<passedLevel; i++) {
        CCSprite *btnSprite = [self createBtnSprite:i image:@"btn-unlock.png"];
        [self addChild:btnSprite z:1];
        
        // 添加数字
        NSString *num = [NSString stringWithFormat:@"%d", i+1];
        CCLabelTTF *lblNum = [CCLabelTTF labelWithString:num dimensions:CGSizeMake(60.0f, 60.0f)
            alignment:UITextAlignmentCenter fontName:@"Marker Felt" fontSize:30.0f];
        float x = 60 + i % 7 * 60;
        float y = 320 - 75 - i / 7 * 80;
        lblNum.position = ccp(x, y);
        
        [self addChild:lblNum z:2];
    }
    
    for (int j=passedLevel; j<LEVEL_COUNT; j++) {
        CCSprite *btnSprite = [self createBtnSprite:j image:@"btn-lock.png"];
        [self addChild: btnSprite z:1];
    }
    
    return self;
}

-(id) createBtnSprite:(int)index image:(NSString*)imgName {
    CCSprite *btnSprite = [CCSprite spriteWithFile:imgName];
    btnSprite.scale = 0.5f;
    float x = 60 + index % 7 * 60;
    float y = 320 - 60 - index / 7 * 80;
    [btnSprite setPosition:ccp(x, y)];
    btnSprite.tag = index + 1;
    
    return btnSprite;
}

- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // 获得触摸对象
    UITouch *touch = [touches anyObject];
    // 获得触摸剧场
    UIView *glView = [touch view];
    // 获得在剧场中的定位
    CGPoint location = [touch locationInView:glView];
    // 转成通用坐标
    CGPoint worlcLocation = [[CCDirector sharedDirector] convertToGL:location];
    // 转成自己的坐标
    CGPoint nodePoint = [self convertToNodeSpace:worlcLocation];
    
    // 遍历所有精灵
    for(int i=0; i<self.children.count; i++) {
        CCSprite *sprite = [self.children objectAtIndex:i];
        if (CGRectContainsPoint(sprite.boundingBox, nodePoint)) {
            // 如果是返回精灵
            if (sprite.tag == 0) {
                CCScene *startScene = [StartScene scene];
                // 定义返回动画
                CCTransitionScene *tran = [[CCTransitionSlideInR alloc] initWithDuration:1.0f scene:startScene];
                [[CCDirector sharedDirector] replaceScene:tran];
                [tran release];
            // 如果是选关按钮
            } else if (sprite.tag > 0 && sprite.tag <= LEVEL_COUNT){
                CCScene *gameScene = [GameScene sceneWithLevel:sprite.tag];
                [[CCDirector sharedDirector] replaceScene:gameScene];
            }
        }
    }
}

@end
