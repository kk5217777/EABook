//
//  EAPageEnd.m
//  EABook
//
//  Created by gdlab on 12/10/31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPageEnd.h"
#import "EALayer.h"
#import "EAPageMenu.h"

@implementation EAPageEnd
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPageEnd *layer = [EAPageEnd node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if (self = [super init]) {
        gamepoint = delegate.EAGamePoint;
        tapObjectArray = [[NSMutableArray alloc] init];
        
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        
        [self addChild:soundMgr];
        [self addObjects];
    }
    return self;
}

-(void) addObjects
{
    /*
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
     */
    //加入結局畫面
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    NSString *tempName;
    tempName = @"Ending-1";
    CCSprite *End = [CCSprite spriteWithFile:[NSString stringWithFormat:@"P6_%@.jpg",tempName]];
    End.position = ccp(winSize.width/2, winSize.height/2+20);
    [soundMgr playSoundFile:@"end.mp3"];
    switch ([gamepoint goToPageNum]) {
        case 1:
            printf("End1");
            [soundMgr playSoundFile:@"P6_end1_word.mp3"];
            [self addChild:End];
            break;
        case 2:
            printf("End2");
            [soundMgr playSoundFile:@"P6_end2_word.mp3"];
            tempName = @"Ending-2";
            End = [CCSprite spriteWithFile:[NSString stringWithFormat:@"P6_%@.jpg",tempName]];
            End.position = ccp(winSize.width/2, winSize.height/2+20);
            [self addChild:End];
            break;
        case 3:
            printf("End3");
            [soundMgr playSoundFile:@"P6_end3_word.mp3"];
            tempName = @"Ending-3";
            End = [CCSprite spriteWithFile:[NSString stringWithFormat:@"P6_%@.jpg",tempName]];
            End.position = ccp(winSize.width/2, winSize.height/2+20);
            [self addChild:End];
            break;
        default:
            break;
    }
    //加入上下頁按鈕
    //[self addPre];
    //[self addNext];
    
    //加入array
    //[tapObjectArray addObject:[self getChildByTag:0]];
    //[tapObjectArray addObject:[self getChildByTag:1]];
}

#pragma 手勢處理
-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (_touchEnable) {
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    [soundMgr playSoundFile:@"nextpage2.mp3"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionZoomFlipY transitionWithDuration:TURN_DELAY scene:[EAPageMenu scene]]];
    /*
    NSLog(@"Tap! %d", tapObjectArray.count);
    for (CCSprite* obj in tapObjectArray) {
        if (CGRectContainsPoint(obj.boundingBox, touchLocation)) {
            switch (obj.tag) {
                case 0:
                    [soundMgr playSoundFile:@"push.mp3"];
                    //delegate.EAGamePoint = gamepoint;
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage4 scene] backwards:YES]];
                    break;
                case 1:
                    [soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageMenu scene]]];
                    break;
                default:
                    break;
            }
            break;
        }
    }*/
}

-(void) dealloc {
    
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    [super dealloc];
}
@end
