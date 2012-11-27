//
//  EAGameMenu.m
//  EABook
//
//  Created by Mac04 on 12/11/5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAGameMenu.h"


@implementation EAGameMenu
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAGameMenu *layer = [EAGameMenu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if (self = [super init]) {
        tapObjectArray = [[NSMutableArray alloc] init];
        //gamepoint = [[GamePoint alloc] init];
        /*
        if (gamepoint) {
            NSLog(@"%@", gamepoint.description);
        }*/
        
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        tapgestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        
        [self addChild:soundMgr];
        [self addObjects];
    }
    return self;
}
-(void) addObjects
{
    [self addBackGround:@"P0-2_game.jpg"];
    [self addReturn];
    //載入圖片
    /*[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P0.plist"];
     spriteSheet = [CCSpriteBatchNode
     batchNodeWithFile:@"P0.png"];
     [self addChild:spriteSheet];*/
    
    NSLog(@"Tap! %d", tapObjectArray.count);
    CCSprite *btnback;
    btnback= [CCSprite spriteWithFile:@"P0-2_game_Jigsaw.jpg"];
    [btnback setTag:3];
    [btnback setPosition:ccp(292, 292)];
    [self addChild:btnback];
    [tapObjectArray addObject:btnback];
    
    btnback = [CCSprite spriteWithFile:@"P0-2_game_Draw.jpg"];
    [btnback setTag:4];
    [btnback setPosition:ccp(728, 292)];
    [self addChild:btnback];
    [tapObjectArray addObject:btnback];
    
    [tapObjectArray addObject:[self getChildByTag:20]];
}

#pragma 手勢處理
-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable) {
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    //NSLog(@"Tap! %d", tapObjectArray.count);
    for (CCSprite* obj in tapObjectArray) {
        if (CGRectContainsPoint(obj.boundingBox, touchLocation)) {
            switch (obj.tag) {
                case 3:
                    NSLog(@"Game1");
                    [soundMgr playSoundFile:@"mapclick.mp3"];
                    //delegate.EAGamePoint = gamepoint;
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:TURN_DELAY scene:[PlayLayer scene]]];
                    break;
                case 4:
                    NSLog(@"Game2");
                    [soundMgr playSoundFile:@"mapclick.mp3"];
                    //delegate.EAGamePoint = gamepoint;
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:TURN_DELAY scene:[EADraw scene]]];
                    break;
                case 20:
                    NSLog(@"設定");
                    [soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:TURN_DELAY scene:[EAPageMenu scene]]];
                    break;
                default:
                    break;
            }
            break;
        }
    }
}

-(void) dealloc {
    [super dealloc];
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
}
@end
