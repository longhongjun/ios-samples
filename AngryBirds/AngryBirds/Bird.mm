//
//  Bird.m
//  AngryBirds
//
//  Created by gukemanbu on 14-7-1.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "Bird.h"

@implementation Bird

@synthesize isReady = _isReady;
@synthesize isFlying = _isFlying;

-(id) initWithX:(float)x andY:(float)y andWorld:(b2World*)world andLayer:(CCLayer<SpriteDelegate> *)layer {
    _world = world;
    _layer = layer;
    
    self = [super initWithFile:@"bird1.png"];
    self.HP = 10000;
    [self setTag:TYPE_BIRD];
    [self setScale:0.3f];
    [self setPosition:ccp(x, y)];
    
    return self;
}

-(void) getShot:(float)x andY:(int)y {
    // 定义小鸟
    b2BodyDef birdDef;
    birdDef.userData = self;
    birdDef.type = b2_dynamicBody;
    birdDef.position.Set(self.position.x / PPI32_M, self.position.y / PPI32_M);
    
    // 创建小鸟刚体
    _body = _world->CreateBody(&birdDef);
    
    // 设置小鸟形状为圆形（受到的磨擦力不明显）
    //b2CircleShape birdSharp;
    //birdSharp.m_radius = 5.0f / PPI32_M;
    // 设置小鸟形状为八边形
    b2PolygonShape birdSharp;
    float size = 0.06f;
    b2Vec2 vertices[] = {
        b2Vec2(size, -2 * size),
        b2Vec2(2 * size, -size),
        b2Vec2(2 * size, size),
        b2Vec2(size, 2 * size),
        b2Vec2(-size, 2 * size),
        b2Vec2(-2 * size, size),
        b2Vec2(-2 * size, -size),
        b2Vec2(-size, -2 * size)
    };
    birdSharp.Set(vertices, 8);
    
    // 设置小鸟属性
    b2FixtureDef birdFixture;
    birdFixture.shape = &birdSharp;
    birdFixture.density = 80.0f;
    birdFixture.friction = 1.0f;
    birdFixture.restitution = 0.5f;
    _body->CreateFixture(&birdFixture);
    
    // 设置小鸟受到的力
    _body->ApplyLinearImpulse(b2Vec2(x, y), birdDef.position);
}

-(void) hitAnimation:(float)x andY:(float)y {
    for (int i = 0; i<6; i++) {
        int range = 2;
        
        CCSprite *yumao = [CCSprite spriteWithFile:@"yumao1.png"];
        yumao.scale = (float)(arc4random() % 5 / 10.0f);
        
        float tempX = x + arc4random() % 10 * range - 10;
        float tempY = y + arc4random() % 10 * range - 10;
        yumao.position = CGPointMake(tempX, tempY);
        
        
        tempX = x + arc4random() % 10 * range - 10;
        tempY = y + arc4random() % 10 * range - 10;
        id actionMove = [CCMoveTo actionWithDuration:1 position:CGPointMake(tempX, tempY)];
        id actionFadeOut = [CCFadeOut actionWithDuration:1];
        id actionRotate = [CCRotateBy actionWithDuration:1 angle:arc4random() % 180];
        //id actionEnd = [CCCallFuncN actionWithTarget:self selector:@selector(removeFromLayer:)];
        
        id asynActions =[CCSpawn actions:actionMove, actionFadeOut, actionRotate, nil];
        [yumao runAction:[CCSequence actions:asynActions, nil]];
        
        [_layer addChild:yumao];
    }
}

@end
