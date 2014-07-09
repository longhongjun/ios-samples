//
//  SpriteBase.m
//  AngryBirds
//
//  Created by gukemanbu on 14-7-2.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "SpriteBase.h"

@implementation SpriteBase

@synthesize HP;

-(id) initWithX:(float)x andY:(float)y andWorld:(b2World *)world andLayer:(CCLayer<SpriteDelegate> *)layer {
    return nil;
}

-(void)removeFromLayer:(id)sender {
    [_layer removeChild:self cleanup:YES];
}

-(void) destroyAnimation:(NSString*) imgName {
    for (int i = 0; i<10; i++) {
        int random = arc4random() % 3 + 1;
        int range = 6;
        
        CCSprite *sprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@%d.png", imgName, random]];
        sprite.scale = (float)(arc4random() % 5 / 10.0f);
        
        float tempX = self.position.x + arc4random() % 10 * range - 20;
        float tempY = self.position.y + arc4random() % 10 * range - 10;
        sprite.position = CGPointMake(tempX, tempY);
        
        tempX = self.position.x + arc4random() % 10 * range - 20;
        tempY = self.position.y + arc4random() % 10 * range - 10;
        id actionMove = [CCMoveTo actionWithDuration:1 position:CGPointMake(tempX, tempY)];
        id actionAlpha = [CCFadeOut actionWithDuration:1];
        id actionRotate = [CCRotateTo actionWithDuration:1 angle:arc4random() % 180];
        id actionDispear = [CCCallFuncN actionWithTarget:self selector:@selector(removeFromLayer:)];
        id actions =[CCSpawn actions:actionMove, actionAlpha, actionRotate, actionDispear, nil];
        
        [sprite runAction:[CCSequence actions:actions, nil]];
        
        [_layer addChild:sprite];
    }
}

-(void) destroy {
    NSArray *imageList = [@"yumao,yumao,littleice" componentsSeparatedByString:@","];
    [self destroyAnimation:[imageList objectAtIndex: (self.tag - 1)]];
}

@end
