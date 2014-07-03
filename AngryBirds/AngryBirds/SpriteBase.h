//
//  SpriteBase.h
//  AngryBirds
//
//  Created by gukemanbu on 14-7-2.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCSprite.h"
#import "cocos2d.h"
#import "Box2D.h"

// 定义小鸟、小猪和冰架
#define TYPE_BIRD 1
#define TYPE_PIG 2
#define TYPE_ICE 3

@protocol SpriteDelegate;

@interface SpriteBase : CCSprite {
    // 生命值
    float HP;
    int fullHP;
    // 父layer
    CCLayer<SpriteDelegate> *ownerLayer;
    b2World *myWorld;
    b2Body *myBody;
}

@property (nonatomic, assign) float HP;
-(id) initWithX:(float)x andY:(float)y andWorld:(b2World*)world andLayer:(CCLayer<SpriteDelegate> *)layer;
-(void) destroy;

@end

@protocol SpriteDelegate <NSObject>

-(void) sprite:(SpriteBase *)sprite withScore:(int)score;

@end
