//
//  LoadingScene.h
//  AngryBirds
//
//  Created by gukemanbu on 14-6-28.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCLayer.h"
#import "cocos2d.h"

@interface LoadingScene : CCLayer {
    CCLabelBMFont *lblLoading;
}

+(id) scene;

@end
