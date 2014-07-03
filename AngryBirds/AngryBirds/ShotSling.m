//
//  ShotSling.m
//  AngryBirds
//
//  Created by gukemanbu on 14-7-3.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "ShotSling.h"

@implementation ShotSling

@synthesize startPoint1 = _startPoint1;
@synthesize startPoint2 = _startPoint2;
@synthesize endPoint = _endPoint;

-(void) draw {
    // 设置线宽
    glLineWidth(2.0f);
    // 设置线颜色为红色
    glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
    // 消除锯齿
    glEnable(GL_LINE_SMOOTH);
    
    // 禁用纹理相关属性(画图用的)
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    
    // 画第一条线
    GLfloat ver1[4] = {_startPoint1.x, _startPoint1.y, _endPoint.x, _endPoint.y};
    glVertexPointer(2, GL_FLOAT, 0, ver1);
    glDrawArrays(GL_LINES, 0, 2);
    
    // 画第二条线
    GLfloat ver2[4] = {_startPoint2.x, _startPoint2.y, _endPoint.x, _endPoint.y};
    glVertexPointer(2, GL_FLOAT, 0, ver2);
    glDrawArrays(GL_LINES, 0, 2);
    
    // 恢复禁用的功能
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
    glDisable(GL_LINE_SMOOTH);
}

@end
