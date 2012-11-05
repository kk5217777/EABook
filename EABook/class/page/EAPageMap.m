//
//  EAPageMap.m
//  EABook
//
//  Created by Mac06 on 12/11/1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPageMap.h"

@implementation EAPageMap
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPageMap *layer = [EAPageMap node];
	
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
    [self addBackGround:@"P0-1_Map.jpg"];
    
    //載入按鈕
    [self addReturn];
    
    NSString *page = @"P0-1";
    //tempObject = [EAAnimSprite node];
    //[tempObject setTextureRect: CGRectMake(0, 0, 250, 130)];
    //[tempObject setPosition:ccp(500, 60)];
    //[tempObject setTag:3];
    //[tempObject setOpacity:0];
    //[self addChild:tempObject];
    //[tapObjectArray insertObject:tempObject atIndex:0];
    
    tempObject = [EAAnimSprite spriteWithFile:[NSString stringWithFormat:@"%@_%@.png",page,@"pop"]];
    [tempObject setPosition:ccp(531, 153)];
    [tempObject setTag:9];
    [tempObject setOpacity:0];
    [self addChild:tempObject];
    [tapObjectArray insertObject:tempObject atIndex:0];
    
    tempObject = [EAAnimSprite spriteWithFile:[NSString stringWithFormat:@"%@_%@.png",page,@"train"]];
    [tempObject setPosition:ccp(296, 185)];
    [tempObject setTag:3];
    [tempObject setOpacity:0];
    [self addChild:tempObject];
    [tapObjectArray insertObject:tempObject atIndex:0];
    
    tempObject = [EAAnimSprite spriteWithFile:[NSString stringWithFormat:@"%@_%@.png",page,@"police"]];
    [tempObject setPosition:ccp(791, 375)];
    [tempObject setTag:5];
    [tempObject setOpacity:0];
    [self addChild:tempObject];
    [tapObjectArray insertObject:tempObject atIndex:0];
    
    tempObject = [EAAnimSprite spriteWithFile:[NSString stringWithFormat:@"%@_%@.png",page,@"space"]];
    [tempObject setPosition:ccp(550, 360)];
    [tempObject setTag:6];
    [tempObject setOpacity:0];
    [self addChild:tempObject];
    [tapObjectArray insertObject:tempObject atIndex:0];
    
    tempObject = [EAAnimSprite spriteWithFile:[NSString stringWithFormat:@"%@_%@.png",page,@"hospital"]];
    [tempObject setPosition:ccp(736, 200)];
    [tempObject setTag:4];
    [tempObject setOpacity:0];
    [self addChild:tempObject];
    [tapObjectArray insertObject:tempObject atIndex:0];
    
    tempObject = [EAAnimSprite spriteWithFile:[NSString stringWithFormat:@"%@_%@.png",page,@"island"]];
    [tempObject setPosition:ccp(240, 470)];
    [tempObject setTag:7];
    [tempObject setOpacity:0];
    [self addChild:tempObject];
    [tapObjectArray insertObject:tempObject atIndex:0];
    
    tempObject = [EAAnimSprite spriteWithFile:[NSString stringWithFormat:@"%@_%@.png",page,@"factory"]];
    [tempObject setPosition:ccp(537, 460)];
    [tempObject setTag:8];
    [tempObject setOpacity:0];
    [self addChild:tempObject];
    [tapObjectArray insertObject:tempObject atIndex:0];
    
    //加入array
    [tapObjectArray addObject:[self getChildByTag:20]];
}

-(void) goToPage
{
    switch (goToPage) {
        case 3:
            gamepoint = [[GamePoint alloc] init];
            delegate.EAGamePoint = gamepoint;
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:TURN_DELAY scene:[EAPage1 scene] withColor:ccWHITE]];
            break;
        case 4:
            gamepoint = [[GamePoint alloc] init];
            delegate.EAGamePoint = gamepoint;
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:TURN_DELAY scene:[EAPage2 scene] withColor:ccWHITE]];
            break;
        case 5:
            [gamepoint addTypeA];
            delegate.EAGamePoint = gamepoint;
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:TURN_DELAY scene:[EAPage3_1 scene] withColor:ccWHITE]];
            break;
        case 6:
            [gamepoint addTypeB];
            delegate.EAGamePoint = gamepoint;
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:TURN_DELAY scene:[EAPage3_2 scene] withColor:ccWHITE]];
            break;
        case 7:
            [gamepoint addTypeC];
            delegate.EAGamePoint = gamepoint;
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:TURN_DELAY scene:[EAPage3_3 scene] withColor:ccWHITE]];
            break;
        case 8:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:TURN_DELAY scene:[EAPage4 scene] withColor:ccWHITE]];
            break;
        case 9:
            gamepoint = [[GamePoint alloc] init];
            delegate.EAGamePoint = gamepoint;
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:TURN_DELAY scene:[EAPage0 scene] withColor:ccWHITE]];
            break;
        default:
            break;
    }
}

#pragma 手勢處理
-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    if (touchEnable && (tapObjectArray.count > 0)) {
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    //tap後的執行動作
    CCCallFunc *switchIneraction = [CCCallFunc actionWithTarget:self selector:@selector(switchInteraction)];
    CCAction *turnPage = [CCCallFunc actionWithTarget:self selector:@selector(goToPage)];
    CCAction *turnWithShining = [CCSequence actions:switchIneraction,
                                 [CCFadeIn actionWithDuration:0.3],
                                 [CCFadeOut actionWithDuration:0.3],
                                 [CCFadeIn actionWithDuration:0.3],
                                 turnPage, nil];
    //各個按鈕的分別動作
    for (tempObject in tapObjectArray) {
        if (CGRectContainsPoint(tempObject.boundingBox, touchLocation)) {
            NSLog(@"Tap! %2d", tempObject.tag);
            switch (tempObject.tag) {
                case 9:
                    goToPage = tempObject.tag;
                    [soundMgr playSoundFile:@"push.mp3"];
                    [tempObject runAction:turnPage];
                    break;
                case 4:
                case 5:
                case 6:
                case 7:
                case 8:
                case 3:
                    goToPage = tempObject.tag;
                    [soundMgr playSoundFile:@"push.mp3"];
                    [tempObject runAction:turnWithShining];
                    break;
                case 20:
                    [soundMgr playSoundFile:tempObject.soundName];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageMenu scene] backwards:YES]];
                    break;
                default:
                    break;
            }
            break;
        }
    }
}

-(void) dealloc {
    
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerLeft];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerRight];
    
    [super dealloc];
}
@end
