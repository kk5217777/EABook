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
@synthesize imgNum;
@synthesize delayTime;

+ (id)spriteWithName:(NSString*)name
{
    EAAnimSprite *sprite = [[[self alloc] initWithName:name] autorelease];
    return sprite;
}
- (id)initWithName:(NSString*)name
{
    imageName = name;
    NSString *fullImagName;
    animImageFrames = [NSMutableArray array];
    
    fullImagName = [NSString stringWithFormat:@"%@_%d.png",name,0];

    if (self = [super initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fullImagName]]) {
        NSLog(@"fileName-------%@",fullImagName);
        imgNum = 0;
        delayTime = 0.3f;
        soundName = nil;
        wordimageName = nil;
        soundEffectID = 0;
        wordsoundEffectID = 0;
    }
    return self;
}

-(void) animation
{
    if (!animImageFrames)
    {
        for (int i = 0; i < imgNum; i++)
        {
            NSString *fullImagName;
            fullImagName = [NSString stringWithFormat:@"%@%d.png", imageName, i];
            [animImageFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fullImagName]];
        }
    }
    animate = [CCAnimation animationWithSpriteFrames:animImageFrames delay:delayTime];
    CCAnimate *action = [CCAnimate actionWithAnimation:animate];
    [self runAction:action];
}
-(void) startAnimation
{
    NSLog(@"start animation");
    /*
    //if (!animImageFrames)
    //{
        for (int i = 0; i < imgNum; i++)
        {
            NSString *fullImagName;
            fullImagName = [NSString stringWithFormat:@"%@%d.png", imageName, i];
            [animImageFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fullImagName]];
        }
    //}
    //if (!animate)
    //{
        animate = [CCAnimation animationWithSpriteFrames:animImageFrames delay:delayTime];
    //}
    CCAnimate *action = [CCAnimate actionWithAnimation:animate];
    [self runAction:action];
     */
}
-(void) startLoopAnimation
{
    if (!animImageFrames)
    {
        for (int i = 0; i < imgNum; i++)
        {
            NSString *fullImagName;
            fullImagName = [NSString stringWithFormat:@"%@%d.png", imageName, i];
            [animImageFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fullImagName]];
        }
    }
    if (!animate)
    {
        animate = [CCAnimation animationWithSpriteFrames:animImageFrames delay:delayTime];
    }
    CCAnimate *action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animate]];
    [self runAction:action];
}

@end
