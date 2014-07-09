//
//  Bird.h
//  AngryBirds
//
//  Created by gukemanbu on 14-7-1.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "SpriteBase.h"

@interface Bird : SpriteBase {
    BOOL _isReady;
    BOOL _isFlying;
}

@property (nonatomic, assign) BOOL isReady;
@property (nonatomic, assign) BOOL isFlying;

-(id) initWithX:(float)x andY:(float)y andWorld:(b2World*)world andLayer:(CCLayer<SpriteDelegate> *)layer;
-(void) getShot:(float)x andY:(int)y;
-(void) destroy;

// 小鸟撞击动画
-(void) hitAnimation:(float)x andY:(float)y;


@end
