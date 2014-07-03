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
    ownerLayer = layer;
    myWorld = world;
    
    self = [super initWithFile:@"ice1.png"];
    self.HP = 27;
    [self setTag:TYPE_ICE];
    [self setScale:0.2f];
    [self setPosition:ccp(x, y)];
    
    return self;
}

@end
