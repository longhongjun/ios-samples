//
//  LoadingScene.m
//  AngryBirds
//
//  Created by gukemanbu on 14-6-28.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "LoadingScene.h"
#import "StartScene.h"

@implementation LoadingScene

+ (id) scene {
    CCScene *scene = [CCScene node];
    LoadingScene *loadingScene = [LoadingScene node];
    [scene addChild: loadingScene];
    
    return scene;
}

+ (id) node {
    return [[[[self class] alloc] init] autorelease];
}

- (id) init {
    self = [super init];
    if (!self) {
        return self;
    }
    
    // 获得屏幕尺寸
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // 创建一个精灵
    CCSprite *sprite = [CCSprite spriteWithFile:@"loading.png"];
    sprite.scale = 0.5f;
    // 设置精灵中心坐标
    [sprite setPosition:ccp(winSize.width / 2.0f, winSize.height / 2.0f)];
    // 把精灵加到场景里
    [self addChild:sprite];
    
    // 创建一个Label
    lblLoading = [[CCLabelBMFont alloc] initWithString:@"Loading" fntFile:@"arial16.fnt"];
    // 设置锚点为0,0
    [lblLoading setAnchorPoint:ccp(0.0f, 0.0f)];
    // 设置位置
    [lblLoading setPosition:ccp(winSize.width - 80.0f, 10.0f)];
    // 加入到场景里
    [self addChild:lblLoading];
    // 设置loading动画
    [self schedule:@selector(loadingTick:) interval:1.0f];
    
    return self;
}

-(void) loadingTick : (double)tick{
    NSUInteger length = [[lblLoading string] length];
    
    // 加载小点
    if (length < 9) {
        [lblLoading setString:[NSString stringWithFormat:@"%@%@", [lblLoading string], @"."]];
        return;
    }
    
    // 取消计时
    [self unscheduleAllSelectors];
    
    // 创建开始场景
    CCScene *startScene = [StartScene scene];
    // 场景切换
    [[CCDirector sharedDirector] replaceScene:startScene];
}

-(void) dealloc {
    [lblLoading release];
    lblLoading = nil;
    [super dealloc];
}

@end
