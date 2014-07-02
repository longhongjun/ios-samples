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

@protocol SpriteDelegate;

@interface SpriteBase : CCSprite {
    // 生命值
    float HP;
    int fullHP;
    // 图片名称
    NSString *imgName;
    // 父layer
    CCLayer<SpriteDelegate> *ownerLayer;
    b2World *myWorld;
    b2Body *myBody;
}

@property (nonatomic, assign) HP;
-(id) initWithX:(float)x andY:(float)y andWorld:(b2World*)world andLayer:(CCLayer<SpriteDelegate> *)layer;
-(void) destroy;

@end

@protocol SpriteDelegate <NSObject>

-(void) sprite:(SpriteBase *)sprite withScore:(int)score;

@end
