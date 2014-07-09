//
//  MyContactListener.m
//  AngryBirds
//
//  Created by gukemanbu on 14-7-7.
//  Copyright (c) 2014年 youup. All rights reserved.
//

#import "MyContactListener.h"


MyContactListener :: MyContactListener(b2World *world, CCLayer *layer) {
    _world = world;
    _layer = layer;
}

MyContactListener :: ~MyContactListener() {
    
}

void MyContactListener :: BeginContact(b2Contact *contact) {
    
}

void MyContactListener:: EndContact(b2Contact *contact) {
    
}

void MyContactListener:: PreSolve(b2Contact *contact, const b2Manifold *oldManifold) {
    
}
void MyContactListener:: PostSolve(b2Contact *contact, const b2ContactImpulse *impulse) {
    Float32 damage = impulse->normalImpulses[0];
    // 如果冲量小于3，直接返回
    if (damage < 3.0f) {
        return;
    }
    
    SpriteBase *spriteA = (SpriteBase *)contact->GetFixtureA()->GetBody()->GetUserData();
    SpriteBase *spriteB = (SpriteBase *)contact->GetFixtureB()->GetBody()->GetUserData();
    if (spriteA && spriteB) {
        if (spriteA.tag == TYPE_BIRD) {
            Bird *bird = (Bird *)spriteA;
            [bird hitAnimation:bird.position.x andY:bird.position.y];
        } else {
            [spriteA setHP:(spriteA.HP - damage)];
        }
            
        if (spriteB.tag == TYPE_BIRD) {
            Bird *bird = (Bird *)spriteB;
            [bird hitAnimation:bird.position.x andY:bird.position.y];
        } else {
            [spriteB setHP:(spriteB.HP - damage)];
        }
    }
}