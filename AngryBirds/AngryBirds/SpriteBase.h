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

// 每米32个像素点
#define PPI32_M 32

@protocol SpriteDelegate;

@interface SpriteBase : CCSprite {
    // 生命值
    float HP;
    int fullHP;
    // 父layer
    CCLayer<SpriteDelegate> *_layer;
    b2World *_world;
    b2Body *_body;
}

@property (nonatomic, assign) float HP;
-(id) initWithX:(float)x andY:(float)y andWorld:(b2World*)world andLayer:(CCLayer<SpriteDelegate> *)layer;
-(void) destroy;

@end

@protocol SpriteDelegate <NSObject>

-(void) sprite:(SpriteBase *)sprite withScore:(int)score;

@end
