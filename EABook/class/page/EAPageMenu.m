//
//  EAPageMenu.m
//  EABook
//
//  Created by gdlab on 12/10/26.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPageMenu.h"
#import "AppDelegate.h"
#import "EAPage1.h"
#import "EAPageConfig.h"

@implementation EAPageMenu
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPageMenu *layer = [EAPageMenu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//
-(id) init
{
    if (self = [super init]) {
        tapObjectArray = [[NSMutableArray alloc] init];
        gamepoint = [[GamePoint alloc] init];
        
        if (gamepoint) {
            NSLog(@"%@", gamepoint.description);
        }
        /*
        AVAudioPlayer *audioPlayer;
        NSString *soundfileName = @"P3-1_owl_word.mp3";
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],soundfileName]];
        NSLog(@"play");
        //wordsoundflag = FALSE;
        
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        audioPlayer.numberOfLoops = 0;
        [audioPlayer play];
        //[self schedule:@selector(PlayWordSound:) interval:1];
        //[self addWordImage];
        [url release];
        */
        // ask director for the window size
        
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        tapgestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        
        [self addObjects];
    }
    return self;
}

-(void) addObjects
{
    [self addBackGround:@"P0_Cover.jpg"];
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P0.plist"];
    
    spriteSheet = [CCSpriteBatchNode
                                      batchNodeWithFile:@"P0.png"];
    [self addChild:spriteSheet];
    
    NSLog(@"Tap! %d", tapObjectArray.count);
    CCSprite *btnback;
    btnback= [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"P0_start.png"]];
    
    [btnback setTag:0];
    [btnback setPosition:LOCATION(155 , 670)];
    [spriteSheet addChild:btnback];
    [tapObjectArray addObject:btnback];
    NSLog(@"Tap! %d", tapObjectArray.count);
    
    btnback = [[CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"P0_map.png"]] autorelease];
    [btnback setTag:1];
    [btnback setPosition:LOCATION(400 , 670)];
    [spriteSheet addChild:btnback];
    [tapObjectArray addObject:btnback];
    
    btnback = [[CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"P0_game.png"]] autorelease];
    [btnback setTag:2];
    [btnback setPosition:LOCATION(640 , 670)];
    [spriteSheet addChild:btnback];
    [tapObjectArray addObject:btnback];
    
    btnback = [[CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"P0_option.png"]] autorelease];
    [btnback setTag:3];
    [btnback setPosition:LOCATION(870 , 670)];
    [spriteSheet addChild:btnback];
    [tapObjectArray addObject:btnback];
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
                case 0:
                    NSLog(@"開始");
                    [soundMgr playSoundFile:@"push.mp3"];
                    delegate.EAGamePoint = gamepoint;
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage1 scene] backwards:NO]];
                    break;
                case 1:
                    NSLog(@"地圖");
                    [soundMgr playSoundFile:@"push.mp3"];
                    break;
                case 2:
                    NSLog(@"遊戲");
                    [soundMgr playSoundFile:@"push.mp3"];
                    break;
                case 3:
                    NSLog(@"設定");
                    [soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageConfig scene] backwards:NO]];
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
