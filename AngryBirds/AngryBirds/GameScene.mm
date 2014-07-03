//
//  GameScene.m
//  AngryBirds
//
//  Created by gukemanbu on 14-6-29.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

+(id) sceneWithLevel:(int)levelNum {
    CCScene *scene = [CCScene node];
    GameScene *gameScene = [GameScene nodeWithLevel:levelNum];
    [scene addChild:gameScene];
    
    return scene;
}

+(id) nodeWithLevel:(int)levelNum {
    return [[[[self class] alloc] initWithLevel:levelNum] autorelease];
}

-(id) initWithLevel:(int)levelNum {
    self = [super init];
    if (!self) {
        return self;
    }
    // 设置当前关数字
    currentLevel = levelNum;
    
    // 设置背景
    [self setBackground];
    
    // 添加返回按钮
    [self addBackButton];
    
    // 加载小猪和冰墙
    [self loadFromFile];
    
    // 添加弹工
    [self addShot];
    
    // 添加三个小鸟
    [self addBirds];
    
    // 第一个小鸟跳到弹工上
    [self birdJumpToShot];
    
    // 画弹弓线
    [self drawShotSling];
    
    // 打开触摸开关并注册从cocos2d事件
    [self setIsTouchEnabled:YES];
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    
    return self;
}

-(void) setBackground {
    // 获得屏幕尺寸
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // 创建背景精灵
    CCSprite *bgSprite = [CCSprite spriteWithFile:@"game-bg.png"];
    [bgSprite setPosition:ccp(winSize.width / 2.0f, winSize.height / 2.0f)];
    [self addChild:bgSprite];
}

-(void) addBackButton {
    // 创建返回精灵
    CCSprite *backSprite = [CCSprite spriteWithFile:@"backarrow.png"];
    backSprite.scale = 0.5f;
    backSprite.tag = 0;
    [backSprite setPosition:ccp(40.0f, 280.0f)];
    [self addChild:backSprite];
}

-(void) loadFromFile{
    NSString *levelNumStr = [NSString stringWithFormat:@"%d", currentLevel];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:levelNumStr ofType:@"data"];
    NSMutableArray *spriteModelArr = [LevelReader getAllSprite:filePath];
    
    for (SpriteModel *model in spriteModelArr) {
        CCSprite *sprite = nil;
        if (model.tag == TYPE_PIG) {
            sprite = [[Pig alloc] initWithX:model.x andY:model.y andWorld:world andLayer:self];

        } else if (model.tag == TYPE_ICE) {
            sprite = [[Ice alloc] initWithX:model.x andY:model.y andWorld:world andLayer:self];
        } else {
            continue;
        }
        
        [self addChild:sprite];
        [sprite release];
    }
}

-(void) addShot {
    // 创建左弹弓
    CCSprite *leftShot = [CCSprite spriteWithFile:@"leftshot.png"];
    leftShot.position = ccp(85, 110);
    [self addChild:leftShot];
    
    // 创建右弹工
    CCSprite *rightShot = [CCSprite spriteWithFile:@"rightshot.png"];
    rightShot.position = ccp(85, 110);
    [self addChild:rightShot];
}

-(void) addBirds {
    birds = [[NSMutableArray alloc] init];
    
    for(int i=0; i<3; i++) {
        float x = 160.0f - 20.0f * i;
        Bird *bird = [[Bird alloc] initWithX:x andY:93.0f andWorld:world andLayer:self];
        [self addChild:bird];
        [birds addObject:bird];
        
        [bird release];
    }
}

-(void) birdJumpToShot {
    Bird *bird = [birds objectAtIndex:0];
    CCJumpTo *jump = [[CCJumpTo alloc] initWithDuration:1 position:ccp(85, 128) height:50 jumps:1];
    CCSequence *actions = [CCSequence actions:jump, nil];
    [bird runAction:actions];
    
    [jump release];
}

-(void) sprite:(SpriteBase *)sprite withScore:(int)score {
    
}

-(void) drawShotSling {
    shotSling = [[ShotSling alloc] init];
    shotSling.startPoint1 = ccp(80.0f, 128.0f);
    shotSling.startPoint2 = ccp(90.0f, 128.0f);
    shotSling.endPoint = ccp(85.0f, 125.0f);
    shotSling.contentSize = CGSizeMake(480.0f, 320.0f);
    shotSling.position = ccp(240.0f, 160.0f);
    
    [self addChild:shotSling];
    //[shotsling release];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    if (currentBird == nil) {
        return NO;
    }
    
    touchStatus = TOUCH_UNKNOW;
    CGPoint touchPoint = [self convertTouchToNodeSpace:touch];
    
    CGRect birdRect = currentBird.boundingBox;
    if (CGRectContainsPoint(birdRect, touchPoint)) {
        touchStatus = TOUCH_BIRD;
    }
    
    return YES;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    if (touchStatus != TOUCH_BIRD) {
        return;
    }
    
    // 获得触摸点
    CGPoint touchPoint = [self convertTouchToNodeSpace:touch];
    // 更新弹弓和小鸟的顶点
    shotSling.endPoint = touchPoint;
    currentBird.position = touchPoint;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CCScene *levelScene = [LevelScene scene];
    [[CCDirector sharedDirector] replaceScene:levelScene];
}

- (void) dealloc {
    [birds release];
    [super dealloc];
}

@end
