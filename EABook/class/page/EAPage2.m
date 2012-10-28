//
//  EAPage2.m
//  EABook
//
//  Created by gdlab on 12/10/27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPage2.h"
#import "EAPageMenu.h"

@implementation EAPage2

+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPage2 *layer = [EAPage2 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if (self = [super init]) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"P2.plist"];
        
        CCSprite* pSprite2 = [CCSprite spriteWithSpriteFrameName:@"P2_horse_0.png"];
        [pSprite2 setPosition:ccp(500, 500)];
        [self addChild:pSprite2];
        
        CCAnimation *pAnim2 = [CCAnimation animation];
        for(unsigned int i = 1; i < 6; i++)
        {
            NSString *name = [NSString stringWithFormat:@"P2_horse_%d.png", i];
            [pAnim2 addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
        }
        [pAnim2 setDelayPerUnit:1.0f];
        
        [pSprite2 runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0f],
                             [CCAnimate actionWithAnimation:pAnim2],
                             NULL]];
        
        //delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        
    }
    return self;
}
/*
-(void) onEnter
{
    tapObjectArray = [[NSMutableArray alloc] init];
    
    NSLog(@"game point: %@", gamepoint.description);
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *tt = [CCLabelTTF labelWithString:@"hello page2" fontName:@"Marker Felt" fontSize:64];
    tt.position = ccp(size.width/2, size.width/2);
    [self addChild:tt];
    
    [self addObjects];
    
    delegate = (AppController*) [[UIApplication sharedApplication] delegate];
    tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
    tapgestureRecognizer.numberOfTapsRequired = 1; //new add
    [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
    
    gamepoint = delegate.EAGamePoint;
    
    soundDetect = [[SoundSensor alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(soundMove) name:EVENT_SOUND object:soundDetect];
}
*/
-(void) addObjects
{
    //加入物件
    //[self addBackGround:@"P2_Background.jpg"];
    
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P2.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P2.png"];
    [self addChild:spriteSheet];
    
    //EAAnimSprite *animSprite;
    animSprite = [EAAnimSprite spriteWithName:@"P2_horse"];
    animSprite.tag = 1;
    animSprite.imgNum = 6;
    [animSprite setPosition:LOCATION(600, 200)];
    //[spriteSheet addChild:animSprite];
    [self addChild:animSprite];
    [tapObjectArray addObject:animSprite];
    /*
    NSMutableArray *animImageFrames = [[NSMutableArray array] retain];
    int imgNum = 6;
    NSString *imageName = @"P2_horse";
    
    for (int i = 0; i < imgNum; i++)
    {
        NSString *fullImagName;
        fullImagName = [NSString stringWithFormat:@"%@_%d.png", imageName, i];
        [animImageFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fullImagName]];
    }
    CCAnimation *animate = [CCAnimation animationWithSpriteFrames:animImageFrames delay:0.5f];
    _danceAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animate]];
    */
    NSLog(@"tapObjectArrayCount %d", tapObjectArray.count);
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"test_default.plist"];
    
    CCSprite* pSprite = [CCSprite spriteWithSpriteFrameName:@"01.png"];
    [pSprite setPosition:ccp(500, 500)];
    [self addChild:pSprite];
    
    CCAnimation *pAnim = [CCAnimation animation];
    for(unsigned int i = 1; i < 101; i++)
    {
        NSString *name = [NSString stringWithFormat:@"%02i.png", i];
        [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
    }
    [pAnim setDelayPerUnit:1.0f];
    
    [pSprite runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0f],
                        [CCAnimate actionWithAnimation:pAnim],
                        NULL]];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"p2.plist"];
    
    CCSprite* pSprite2 = [CCSprite spriteWithSpriteFrameName:@"P2_horse_0.png"];
    [pSprite2 setPosition:ccp(700, 400)];
    [self addChild:pSprite2];
    
    CCAnimation *pAnim2 = [CCAnimation animation];
    for(unsigned int i = 1; i < 6; i++)
    {
        NSString *name = [NSString stringWithFormat:@"P2_horse_%d.png", i];
        [pAnim2 addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
    }
    [pAnim2 setDelayPerUnit:1.0f];
    
    [pSprite2 runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0f],
                         [CCAnimate actionWithAnimation:pAnim2],
                         NULL]];
}

-(void) draw
{
    //[soundDetect update];
}

-(void) soundMove
{
    printf("sound");
    [soundDetect enableFlag];
}

-(void) handleTap:(UITapGestureRecognizer*) recognizer
{
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable) {
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    NSLog(@"tap");
    
    for (EAAnimSprite *tapObject in tapObjectArray) {
        if (CGRectContainsPoint(tapObject.boundingBox, touchLocation)) {
            NSLog(@"btn tag:%d",tapObject.tag);
            switch (tapObject.tag) {
                case 0:
                    NSLog(@"tap 0");
                    //[animSprite startAnimation];
                    break;
                case 1:
                    [animSprite startAnimation];
                    break;
                case 2:
                    break;
                case 3:
                case 4:
                    break;
                default:
                    break;
            }
            break;
        }
    }
    
}
-(void) onExit {
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
}
@end
