//
//  LevelReader.m
//  AngryBirds
//
//  Created by GukeManbu on 14-7-3.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "LevelReader.h"

@implementation LevelReader

+(id) getAllSprite:(NSString *)fileName {
    // 读取关卡文件内容
    NSString *content = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    // 生成精灵数组
    NSArray *spriteArr = [[[content JSONValue] objectForKey:@"sprites"] objectForKey:@"sprite"];
    
    // 创建精灵模型数组
    NSMutableArray *spriteModelArr = [NSMutableArray array];
    
    // 解析数组为精灵模型
    for (NSDictionary *item in spriteArr) {
        SpriteModel *model = [[SpriteModel alloc] init];
        model.tag = [[item objectForKey:@"tag"] intValue];
        model.x = [[item objectForKey:@"x"] intValue];
        model.y = [[item objectForKey:@"y"] intValue];
        model.angle = [[item objectForKey:@"angle"] intValue];
        
        [spriteModelArr addObject:model];
        [model release];
    }
    
    return spriteModelArr;
}

@end
