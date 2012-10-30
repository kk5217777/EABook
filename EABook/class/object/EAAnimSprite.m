//
//  EAAnimSprite.m
//  EbookAnimal
//
//  Created by gdlab on 12/10/26.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAAnimSprite.h"


@implementation EAAnimSprite
@synthesize imageName, soundName, wordimageName, wordsoundName;
@synthesize imgNum, repeatTime;
@synthesize delayTime;

+ (id)spriteWithName:(NSString*)name
{
    EAAnimSprite *sprite = [[[self alloc] initWithName:name] autorelease];
    return sprite;
}
- (id)initWithName:(NSString*)name
{
    imageName = name;
    animImageFrames = [NSMutableArray array];
    repeatTime = 1;
    NSString *fullImagName;
    
    fullImagName = [NSString stringWithFormat:@"%@_%d.png",name,0];
    NSLog(@"fileName-------%@",fullImagName);
    if (self = [self initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fullImagName]]) {
        imgNum = 0;
        delayTime = 0.3f;
        soundName = nil;
        wordimageName = Nil;
        wordsoundName = Nil;
    }
    return self;
}

-(CCAnimation*) getSimpleAnim
{
    CCAnimation *pAnim = [CCAnimation animation];
    for(unsigned int i = 1; i < imgNum; i++)
    {
        NSString *name = [NSString stringWithFormat:@"%@_%d.png",imageName,i];
        [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
    }
    [pAnim setDelayPerUnit:delayTime];
    return pAnim;
}

-(void) startSpacailAnim:(CCAnimate*)sAnim
{
    if (sAnim) {
        NSLog(@"Merge Anim");
        CCAnimate *action = [CCRepeatForever actionWithAction:sAnim];
        [self runAction:action];
    }
    else
    {
        NSLog(@"Loop Anim");
        [self startLoopAnimation];
    }
}

-(void) startAnimation
{
    NSLog(@"start animation");
    
    CCAnimation *pAnim = [CCAnimation animation];
    if (imgNum < 3) {
        for(unsigned int i = 1; i < imgNum; i++)
        {
            NSString *name = [NSString stringWithFormat:@"%@_%d.png",imageName,i];
            [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
        }
        NSString *name = [NSString stringWithFormat:@"%@_%d.png",imageName,0];
        [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
    }
    else
    {
        for(unsigned int i = 1; i < imgNum; i++)
        {
            NSString *name = [NSString stringWithFormat:@"%@_%d.png",imageName,i];
            [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
        }
    }
    [pAnim setDelayPerUnit:delayTime];
    pAnim.restoreOriginalFrame = YES;
    
    CCCallFunc *switchIneraction = [CCCallFunc actionWithTarget:parent_ selector:@selector(switchInteraction)];
    CCCallFunc *stopSound = [CCCallFunc actionWithTarget:parent_ selector:@selector(stopSpriteMove)];
    
    CCAnimate *action = [CCAnimate actionWithAnimation:pAnim];
    [self runAction:[CCSequence actions:switchIneraction,
                    [CCDelayTime actionWithDuration:0.1f],
                    [CCRepeat actionWithAction:action times:repeatTime],
                    stopSound , NULL]];
}
    
-(void) startLoopAnimation
{
    NSLog(@"start animation");
    
    CCAnimation *pAnim = [CCAnimation animation];
    for(unsigned int i = 1; i < imgNum; i++)
    {
        NSString *name = [NSString stringWithFormat:@"%@_%d.png",imageName,i];
        [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
    }
    [pAnim setDelayPerUnit:delayTime];
    
    //CCCallFunc *switchIneraction = [CCCallFunc actionWithTarget:parent_ selector:@selector(switchInteraction)];
    //CCCallFunc *stopSound = [CCCallFunc actionWithTarget:parent_ selector:@selector(stopSpriteMove)];
    
    CCAnimate *action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:pAnim]];
    [self runAction:action];
}



@end
