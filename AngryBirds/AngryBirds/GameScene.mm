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
    
    // 初始化世界
    [self initWorld];
    
    // 设置背景
    [self setBackground];
    
    // 添加返回按钮
    [self addBackButton];
    
    // 加载小猪和冰墙
    [self loadFromFile];
    
    // 添加弹弓
    [self addShot];
    
    // 添加三个小鸟
    [self addBirds];
    
    // 第一个小鸟跳到弹弓上
    [self birdJumpToShot];
    
    // 画弹弓线
    [self drawShotSling];
    
    // 打开触摸开关并注册从cocos2d事件
    [self setIsTouchEnabled:YES];
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    
    return self;
}

-(void) initWorld {
    // 创建重力加速度
    b2Vec2 gravity;
    gravity.Set(0.0f, -5.0f);
    
    // 创建世界
    _world = new b2World(gravity, true);
    
    // 定义地面
    b2BodyDef groundDef;
    groundDef.position.Set(0.0f, 0.0f);
    // 创建地面刚体
    b2Body *groundBody = _world->CreateBody(&groundDef);
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // 地面形状为一条水平线
    b2PolygonShape groundShape;
    groundShape.SetAsEdge(b2Vec2(0.0f, 87.0f / PPI32_M), b2Vec2(winSize.width / PPI32_M, 87.0f / PPI32_M));
    // 设置地面属性
    b2FixtureDef groundFixture;
    groundFixture.shape = &groundShape;
    //groundFixture.friction = 1.0f;
    groundBody->CreateFixture(&groundFixture);
    
    [self schedule:@selector(update:)];
}

-(void) update:(float32) dt {
    // 让世界向前发展
    _world->Step(dt, 8, 1);
    
    b2Body *body = _world->GetBodyList();
    while (body) {
        CCSprite *sprite =  (CCSprite *)body->GetUserData();
        if (sprite) {
            [sprite setPosition:ccp(body->GetPosition().x * PPI32_M, body->GetPosition().y * PPI32_M)];
            [sprite setRotation: -1 * CC_RADIANS_TO_DEGREES(body->GetAngle())];
        }
        body=body->GetNext();
    }
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
    backSprite = [CCSprite spriteWithFile:@"backarrow.png"];
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
            sprite = [[Pig alloc] initWithX:model.x andY:model.y andWorld:_world andLayer:self];

        } else if (model.tag == TYPE_ICE) {
            sprite = [[Ice alloc] initWithX:model.x andY:model.y andWorld:_world andLayer:self];
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
    
    // 创建右弹弓
    CCSprite *rightShot = [CCSprite spriteWithFile:@"rightshot.png"];
    rightShot.position = ccp(85, 110);
    [self addChild:rightShot];
}

-(void) addBirds {
    _birdArr = [[NSMutableArray alloc] init];
    
    for(int i=0; i<3; i++) {
        float x = 160.0f - 20.0f * i;
        Bird *bird = [[Bird alloc] initWithX:x andY:93.0f andWorld:_world andLayer:self];
        [self addChild:bird];
        [_birdArr addObject:bird];
        
        [bird release];
    }
}

-(void) birdJumpToShot {
    if (_birdArr.count < 1) {
        return;
    }
    currentBird = [_birdArr objectAtIndex:0];
    CCJumpTo *jump = [[CCJumpTo alloc] initWithDuration:1 position:ccp(85, 128) height:50 jumps:1];
    CCSequence *actions = [CCSequence actions:jump, nil];
    [currentBird runAction:actions];
    
    [jump release];
}

-(void) sprite:(SpriteBase *)sprite withScore:(int)score {
    
}

-(void) drawShotSling {
    _shotSling = [[ShotSling alloc] init];
    _shotSling.startPoint1 = ccp(80.0f, 128.0f);
    _shotSling.startPoint2 = ccp(90.0f, 128.0f);
    _shotSling.endPoint = SHOTSLING_INIT_POINT;
    _shotSling.contentSize = CGSizeMake(480.0f, 320.0f);
    _shotSling.position = ccp(240.0f, 160.0f);
    
    [self addChild:_shotSling];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    touchStatus = TOUCH_UNKNOW;
    CGPoint touchPoint = [self convertTouchToNodeSpace:touch];
    
    CGRect birdRect = currentBird.boundingBox;
    CGRect backRect = backSprite.boundingBox;
    if (CGRectContainsPoint(birdRect, touchPoint)) {
        touchStatus = TOUCH_BIRD;
    } else if (CGRectContainsPoint(backRect, touchPoint)) {
        touchStatus = TOUCH_BACK;
    }
    
    return YES;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    if (touchStatus == TOUCH_UNKNOW) {
        return;
    }
    
    if (touchStatus == TOUCH_BIRD) {
        // 弹弓原始点
        CGPoint initPoint = SHOTSLING_INIT_POINT;
        // 获得触摸点
        CGPoint touchPoint = [self convertTouchToNodeSpace:touch];
        // 计算两点间的距离
        double distance = sqrt(pow(touchPoint.y - initPoint.y, 2) + pow(touchPoint.x - initPoint.x, 2));
        
        // 计算弹弓绳锁的有效长度
        if (distance < 5.0f) {
            touchPoint = SHOTSLING_INIT_POINT;
        } else if (distance > 50.0f) {
            CGFloat x = (touchPoint.x - initPoint.x) * 50 / distance + initPoint.x;
            CGFloat y = (touchPoint.y - initPoint.y) * 50 / distance + initPoint.y;
            touchPoint = ccp(x, y);
        }
        
        // 更新弹弓和小鸟的顶点
        _shotSling.endPoint = touchPoint;
        currentBird.position = touchPoint;
    }
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (touchStatus == TOUCH_UNKNOW) {
        return;
    }
    
    if (touchStatus == TOUCH_BIRD) {
        // 弹弓复位
        _shotSling.endPoint = SHOTSLING_INIT_POINT;
        
        CGPoint touchPoint = [self convertTouchToNodeSpace:touch];

        float x  = (85.0f - touchPoint.x) * 50 / 70;
        float y  = (125.0f - touchPoint.y) * 50 / 70;
        [currentBird getShot:x andY:y];
        
        // 删除当前小鸟
        [_birdArr removeObject:currentBird];
        currentBird = nil;
        
        // 下一个小鸟跳上弹弓
        [self performSelector:@selector(birdJumpToShot) withObject:nil afterDelay:2.0f];
        
    } else {
        CCScene *levelScene = [LevelScene scene];
        [[CCDirector sharedDirector] replaceScene:levelScene];
    }

}

- (void) dealloc {
    [_birdArr release];
    [_shotSling release];
    [super dealloc];
}

@end
