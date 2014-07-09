//
//  SpriteModel.h
//  AngryBirds
//
//  Created by GukeManbu on 14-7-3.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpriteModel : NSObject {
    int tag;
    float x;
    float y;
    float angle;
}
@property (nonatomic, assign) int tag;
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) float angle;

@end
