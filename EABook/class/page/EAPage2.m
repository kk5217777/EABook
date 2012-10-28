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
        
        tapObjectArray = [[NSMutableArray alloc] init];
        swipeObjectArray = [[NSMutableArray alloc] init];
        swipeCount = 0;
        gamepoint = delegate.EAGamePoint;
        [gamepoint addTypeA];
        NSLog(@"game point: %@", gamepoint.description);
        
        [self addObjects];
        
        //手勢
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        
        swipegestureRecognizerRight = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]autorelease];
        [swipegestureRecognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
        
        swipegestureRecognizerLeft = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]autorelease];
        [swipegestureRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        
        [delegate.navController.view addGestureRecognizer:swipegestureRecognizerRight];
        [delegate.navController.view addGestureRecognizer:swipegestureRecognizerLeft];
        
        //音量
        soundDetect = [[SoundSensor alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(soundMove) name:EVENT_SOUND object:soundDetect];
        
    }
    return self;
}

-(void) addObjects
{
    //加入背景，一定要先背景再載入sprite圖片的資源檔
    [self addBackGround:@"P2_Background.jpg"];
    
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P2.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P2.png"];
    [self addChild:spriteSheet];
    
    //加入上下頁按鈕
    
    //加入互動物件
    windmil = [EAAnimSprite spriteWithName:@"P2_Windmill"];
    windmil.tag = 5;
    windmil.imgNum = 6;
    windmil.repeatTime = 2;
    [windmil setPosition:LOCATION(832, 190)];
    [self addChild:windmil];
    
    horse = [EAAnimSprite spriteWithName:@"P2_horse"];
    horse.tag = 2;
    horse.imgNum = 7;
    horse.repeatTime = 2;
    [horse setPosition:LOCATION(775, 380)];
    [self addChild:horse];
    
    sheep = [EAAnimSprite spriteWithName:@"P2_sheep"];
    sheep.tag = 3;
    sheep.imgNum = 2;
    sheep.repeatTime = 2;
    sheep.delayTime = 1.0f;
    [sheep setPosition:LOCATION(580, 625)];
    [self addChild:sheep];
    
    zibber = [EAAnimSprite spriteWithName:@"P2_zibber"];
    zibber.tag = 4;
    zibber.imgNum = 5;
    zibber.repeatTime = 2;
    [zibber setPosition:LOCATION(150, 450)];
    [self addChild:zibber];
    
    [tapObjectArray addObject:zibber];
    [tapObjectArray addObject:sheep];
    [tapObjectArray addObject:horse];
    [swipeObjectArray addObject:zibber];
    [swipeObjectArray addObject:sheep];
    [swipeObjectArray addObject:horse];
}

-(void) draw
{
    [soundDetect update];
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

-(void) handleSwipe:(UISwipeGestureRecognizer *)recognizer
{
    
    if (touchEnable) {
        NSLog(@"swipe");
        if (swipeDirection && (swipeDirection != (UISwipeGestureRecognizerDirection*)recognizer.direction)) {
            ++swipeCount;
            if (swipeCount > 1) {
                NSLog(@"swipe twice");
                swipeCount = 0;
                swipeDirection = Nil;
                CGPoint touchLocation = [recognizer locationInView:recognizer.view];
                touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
                [self swipeSpriteMovement:touchLocation];
            }
        }
        swipeDirection = (UISwipeGestureRecognizerDirection*)recognizer.direction;
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    NSLog(@"tap");
    
    for (tapObject in tapObjectArray) {
        if (CGRectContainsPoint(tapObject.boundingBox, touchLocation)) {
            NSLog(@"btn tag:%d",tapObject.tag);
            switch (tapObject.tag) {
                case 0:
                    NSLog(@"tap 0");
                    
                    break;
                case 1:
                    
                    break;
                case 2:
                    [tapObject startAnimation];
                    break;
                case 3:
                    [tapObject startAnimation];
                    break;
                case 4:
                    
                    break;
                case 5:
                    
                    break;
                default:
                    break;
            }
            break;
        }
    }
    
}

-(void) swipeSpriteMovement:(CGPoint)touchLocation
{
    
}

-(void) dealloc {
    [super dealloc];
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
}
@end
