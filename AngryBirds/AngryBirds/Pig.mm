//
//  Bird.m
//  AngryBirds
//
//  Created by gukemanbu on 14-7-1.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "Pig.h"

@implementation Pig

-(id) initWithX:(float)x andY:(float)y andWorld:(b2World*)world andLayer:(CCLayer<SpriteDelegate> *)layer {
    _world = world;
    _layer = layer;
    
    self = [super initWithFile:@"pig1.png"];
    self.HP = 2;
    [self setTag:TYPE_PIG];
    [self setScale:0.2f];
    [self setPosition:ccp(x, y)];
    
    b2BodyDef pigBodyDef;
    pigBodyDef.type = b2_dynamicBody;
    pigBodyDef.position.Set(x / PPI32_M, y / PPI32_M);
    pigBodyDef.userData = self;
    
    b2Body *pigBody = world->CreateBody(&pigBodyDef);
    
    float size = 0.12f;
    b2PolygonShape pigShape;
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
    pigShape.Set(vertices, 8);
    
    b2FixtureDef pigFixtureDef;
    pigFixtureDef.shape = &pigShape;
    pigFixtureDef.density = 80.0f;
    pigFixtureDef.friction = 1.0f;
    pigFixtureDef.restitution = 0.15f;
    pigBody->CreateFixture(&pigFixtureDef);
    
    return self;
}

@end
