//
//  EAUpDownSprite.m
//  EABook
//
//  Created by Mac06 on 12/10/31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAUpDownSprite.h"


@implementation EAUpDownSprite

-(void) startLoopAnimation
{
    NSLog(@"loop anim");
    
    CCAnimation *pAnim = [CCAnimation animation];
    for(unsigned int i = 1; i < imgNum; i++)
    {
        NSString *name = [NSString stringWithFormat:@"%@_%d.png",imageName,i];
        [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
    }
    [pAnim setDelayPerUnit:delayTime];
    
    CCMoveBy *moveBy1 = [CCRotateBy actionWithDuration:0.5 angle:5];//向上
    CCMoveBy *moveBy2 = [CCRotateBy actionWithDuration:0.5 angle:-5];//向下
    CCEaseInOut *ease1 = [CCEaseInOut actionWithAction:moveBy1 rate:0.5];//逆时针时摆动时先匀加速再匀减速运动
    CCEaseInOut *ease2 = [CCEaseInOut actionWithAction:moveBy2 rate:0.5];//顺时针时摆动时先匀加速再匀减速运动
    CCSequence *seq1 = [CCSequence actions:ease1, ease2, nil];//将两个摆动合成为一个动画
    
    [self runAction:[CCRepeatForever actionWithAction:[CCSpawn actionOne:[CCAnimate actionWithAnimation:pAnim] two:seq1]]];
}

@end
