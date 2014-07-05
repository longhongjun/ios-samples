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
    _layer = layer;
    _world = world;
    
    self = [super initWithFile:@"pig1.png"];
    self.HP = 1;
    [self setTag:TYPE_PIG];
    [self setScale:0.2f];
    [self setPosition:ccp(x, y)];
    
    return self;
}

@end
