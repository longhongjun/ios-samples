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
    ownerLayer = layer;
    myWorld = world;
    
    self = [super initWithFile:@"bird1.png"];
    self.HP = 10000;
    [self setTag:TYPE_BIRD];
    [self setScale:0.3f];
    [self setPosition:ccp(x, y)];
    
    return self;
}

@end
