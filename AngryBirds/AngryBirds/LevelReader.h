//
//  LevelReader.h
//  AngryBirds
//
//  Created by GukeManbu on 14-7-3.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "SpriteModel.h"

@interface LevelReader : NSObject

+(id) getAllSprite:(NSString *) fileName;

@end
