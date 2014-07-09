//
//  Bird.m
//  AngryBirds
//
//  Created by gukemanbu on 14-7-1.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "Ice.h"

@implementation Ice

-(id) initWithX:(float)x andY:(float)y andWorld:(b2World*)world andLayer:(CCLayer<SpriteDelegate> *)layer {
    _world = world;
    _layer = layer;
    
    self = [super initWithFile:@"ice1.png"];
    self.HP = 10;
    [self setTag:TYPE_ICE];
    [self setScale:0.2f];
    [self setPosition:ccp(x, y)];
    
    b2BodyDef iceBodyDef;
    iceBodyDef.type = b2_dynamicBody;
    iceBodyDef.position.Set(x / PPI32_M, y / PPI32_M);
    iceBodyDef.userData = self;
    
    b2Body *iceBody = world->CreateBody(&iceBodyDef);
    
    b2PolygonShape iceShape;
    iceShape.SetAsBox(self.contentSize.width / 11 / PPI32_M, self.contentSize.height / 11 / PPI32_M);
    
    b2FixtureDef iceFixtureDef;
    iceFixtureDef.shape = &iceShape;
    iceFixtureDef.density = 10.0f;
    iceFixtureDef.friction = 1.0f;
    iceFixtureDef.restitution = 0;
    iceBody->CreateFixture(&iceFixtureDef);
    
    return self;
}

@end
