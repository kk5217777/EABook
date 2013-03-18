//
//  MotionSensorEgg.m
//  EABook
//
//  Created by Mac06 on 12/10/31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MotionSensorIce.h"


@implementation MotionSensorIce

-(void) update
{
    if ([motionMgr isAccelerometerActive]) {
        _acData = motionMgr.accelerometerData;
        if (fabsf(_acData.acceleration.y) > LIMIT  )//|| fabs(_acData.acceleration.x) > LIMIT
        {
            if (sprite) {
                if (animAble) {
                    [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchTouchInteraction)]];
                    [sprite startLoopAnimation:2];
                    animAble = !animAble;
                    if (sprite.soundName && sManage) {
                        [sManage playLoopSound:sprite.soundName];
                    }
                }
                if (sprite.position.x > 30 && sprite.position.x < 1000 && sprite.position.y > 30 && sprite.position.y < 730) {
                    [sprite setPosition:CGPointMake((sprite.position.x + _acData.acceleration.y*5), sprite.position.y)];
                    /*if (sprite2) {
                        [sprite2 setPosition:CGPointMake((sprite2.position.x + _acData.acceleration.y*10), sprite2.position.y)];
                    }*/
                }
                else
                {
                    if (sprite.position.x < 30) {
                        [sprite setPosition:CGPointMake((sprite.position.x+1), sprite.position.y)];
                    }
                    else if (sprite.position.x > 1000)
                    {
                        [sprite setPosition:CGPointMake((sprite.position.x-1), sprite.position.y)];
                    }
                }
            }
            if (sprite2) {
                float sx = 40;
                float sy = 400;
                float ex = 1000;
                float ey = 618;
                float m = (ey-sy)/(ex-sx);
                float dx = m*_acData.acceleration.y*5;
                
                if (sprite2.position.x > 30 && sprite2.position.x < 1010 && sprite2.position.y > 30 && sprite2.position.y < 730) {
                    [sprite2 setPosition:CGPointMake((sprite2.position.x + _acData.acceleration.y*5), sprite2.position.y+dx)];
                    
                    //printf("sprite2.x :%f ,y :%f  ",sprite2.position.x , sprite2.position.y);
                    /*
                    if (sprite2) {
                        [sprite2 setPosition:CGPointMake((sprite2.position.x + _acData.acceleration.y*10), sprite2.position.y)];
                    }*/
                }
                else
                {
                    if (sprite2.position.x <= 30) {
                        [sprite2 setPosition:CGPointMake(40, 471)];
                    }
                    else if (sprite2.position.x >= 1010)
                    {
                        [sprite2 setPosition:CGPointMake(970, 683)];
                    }
                }
            }
        }
        else
        {
            if (sprite) {
                if (!animAble) {
                    [sprite firstFram];
                    [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchTouchInteraction)]];
                    animAble = !animAble;
                    [sprite stopAllActions];
                    if (sprite.soundName && sManage) {
                        [sManage stopSound];
                    }
                }
            }
        }
        //NSLog(@"Accelerometer\n----------\nx:%+.2f\ny:%+.2f\nz:%+.2f",_acData.acceleration.x, _acData.acceleration.y, _acData.acceleration.z);
    }
}

@end
