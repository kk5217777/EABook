//
//  EAPageGame1.m
//  EABook
//
//  Created by gdlab on 12/10/31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPageGame1.h"


@implementation EAPageGame1
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPageGame1 *layer = [EAPageGame1 node];
	
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
       
        //swipeObjectArray = [[NSMutableArray alloc] init];
        
        int picvalue = (arc4random() % kKindCount);
        NSLog(@"picvalue: %d", picvalue);
        
        tt = TRUE;
        isReturn = TRUE;
        count = 0;
        countTime=0;
        
        //手勢
        
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        pangestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanForm:)] autorelease];
        [delegate.navController.view addGestureRecognizer:pangestureRecognizer];
        
        tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)] autorelease];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        /*
        swipegestureRecognizerRight = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]autorelease];
        [swipegestureRecognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
        
        swipegestureRecognizerLeft = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]autorelease];
        [swipegestureRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        
        [delegate.navController.view addGestureRecognizer:swipegestureRecognizerRight];
        [delegate.navController.view addGestureRecognizer:swipegestureRecognizerLeft];
        */
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        
        background =[[CCSprite alloc]initWithFile:@"P0-2_game-Jigsaw_background.jpg"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild:background];
        
        PrePage = [[CCSprite alloc]initWithFile:@"P0-2_game_return-buttun.png"];
        PrePage.position = ccp(50, 60);
        //[self addChild:PrePage];
        
        wordimage=[[CCSprite alloc]initWithFile:[NSString stringWithFormat:@"GAME_word_%d.png",picvalue]];
        wordimage.position = ccp(520, 670);
        [self addChild:wordimage];
         
        destimage=[[CCSprite alloc]initWithFile:[NSString stringWithFormat:@"GAME_black_%d.jpg",picvalue]];
        destimage.position = ccp(760, 350);
        [self addChild:destimage];
        
        box = [[Box alloc] initWithSize:CGSizeMake(kBoxWidth,kBoxHeight) imgValue:picvalue];
        box.layer = self;
        box.lock = YES;
        [box check];


        //音量
        //soundDetect = [[SoundSensor alloc] init];
        //soundDetect.sManage = soundMgr;
        //[self addChild:soundDetect];
        
        //重力
        //motionDetect = [[MotionSensor alloc] init];
        //motionDetect.sManage = soundMgr;
        //[self addChild:motionDetect];
        
        [self addChild:soundMgr];
        //[self addObjects];
    }
    return self;
}
/*
-(void) addObjects
{
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game Page 1" fontName:@"Marker Felt" fontSize:64];
    
     //ask director for the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
    
     //position the label on the center of the screen
    label.position =  ccp( size.width /2 , size.height/2 );
    [self addChild:label];
    
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
     
    
    //加入上下頁按鈕
    [self addPre];
    [self addNext];
    
    //加入array
    [tapObjectArray addObject:[self getChildByTag:0]];
    [tapObjectArray addObject:[self getChildByTag:1]];
}
*/
/*
#pragma 手勢處理
-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable && tapObjectArray) {
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
                    [soundMgr playSoundFile:@"push.mp3"];
                    //delegate.EAGamePoint = gamepoint;
                    switch ([gamepoint goToPageNum]) {
                        case 1:
                            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage3_1 scene]]];
                            break;
                        case 2:
                            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage3_2 scene]]];
                            break;
                        case 3:
                            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage3_3 scene]]];
                            break;
                        default:
                            break;
                    }
                    //[[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage3_1 scene] backwards:YES]];
                    break;
                case 1:
                    [soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage4 scene]]];
                    break;
                case 2:
                    NSLog(@"遊戲");
                    [soundMgr playSoundFile:@"push.mp3"];
                    break;
                case 3:
                    NSLog(@"設定");
                    [soundMgr playSoundFile:@"push.mp3"];
                    break;
                default:
                    break;
            }
            break;
        }
    }
}*/

-(void) handleTapFrom:(UITapGestureRecognizer *)recognizer{
    NSLog(@"Tap");
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    [self selectTapSpriteForTouch:touchLocation];
    
}
- (void)selectTapSpriteForTouch:(CGPoint)touchLocation{
    /*
    if (CGRectContainsPoint(PrePage.boundingBox, touchLocation)&&isReturn) {
        tt = FALSE;
        [soundMgr playSoundFile:@"push.mp3"];
        [self removeAllChildrenWithCleanup:YES];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.8 scene:[EAGameMenu scene] backwards:YES]];
     
    }
    else if (CGRectContainsPoint(AgainBtn.boundingBox, touchLocation)){
        NSLog(@"again");
        [soundMgr playSoundFile:@"push.mp3"];
        //[self removeAllChildrenWithCleanup:YES];
        //[self PlayAgain];
    }
    else if (CGRectContainsPoint(NextRoundBtn.boundingBox, touchLocation)){
        tt=FALSE;
        [soundMgr playSoundFile:@"push.mp3"];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.8 scene:[PlayLayer node]withColor:ccWHITE]];
        
    }*/
    if (CGRectContainsPoint(ExitBtn.boundingBox, touchLocation)){
        tt=FALSE;
        [soundMgr playSoundFile:@"push.mp3"];
        [self removeSprite];
        
        [self removeAllChildrenWithCleanup:YES];
        //[box.movableSprites removeAllObjects];
        [box removeAllArray];
        //[selsprite release];
        //[Tile release];
        //[MenuImage release];
        //[destimage release];
        //[PrePage release];
        //[background release];
        //[wordimage release];
        //[gamewin release];
        //[ExitBtn release];
        
        //[box release];
        [delegate.navController.view removeGestureRecognizer:pangestureRecognizer];//new add
        [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
        printf("boxlayer dealloc");
        [[CCDirector sharedDirector] replaceScene:[CCTransitionTurnOffTiles transitionWithDuration:0.8 scene:[EAPage4 scene]]];
        
    }
}
-(void)selectSpriteForTouch:(CGPoint)touchLocation{
    MySprite *newSprite = nil;
    for (MySprite *sprite in box.movableSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
            newSprite = sprite;
            break;
        }
    }
    if (newSprite != selsprite) {
        [selsprite stopAllActions];
        selsprite = newSprite;
        [selsprite setZOrder:1];
    }
}
-(void)panForTranslation:(CGPoint)translation{
    
    if (selsprite) {
        if (selsprite.position.x>(kStartX)&&selsprite.position.x<(kDestX+(kTileSize*kBoxWidth))&&selsprite.position.y>(kStartY)&&selsprite.position.y<(kStartY + (kTileSize * kBoxHeight))) {
            CGPoint newPos = ccpAdd(selsprite.position,translation);
            selsprite.position = newPos;
        }
        else{
            if (selsprite.position.x >= (kDestX+(kTileSize*kBoxWidth))) {
                CGPoint newPos = ccpSub(selsprite.position, CGPointMake(3, 0));
                selsprite.position = newPos;
            }
            if (selsprite.position.x <= (kStartX)) {
                CGPoint newPos = ccpAdd(selsprite.position, CGPointMake(3, 0));
                selsprite.position = newPos;
            }
            if (selsprite.position.y >= (kStartY + (kTileSize * kBoxHeight))) {
                CGPoint newPos = ccpSub(selsprite.position, CGPointMake(0, 3));
                selsprite.position = newPos;
            }
            if (selsprite.position.y <= (kStartY)) {
                CGPoint newPos = ccpAdd(selsprite.position, CGPointMake(0, 3));
                selsprite.position = newPos;
            }
        }
        
    }
}
-(void)handlePanForm:(UIPanGestureRecognizer *)recognizer{
    //NSLog(@"Pan點中圖片");
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        touchLocation = [self convertToNodeSpace:touchLocation];
        [self selectSpriteForTouch:touchLocation];
        
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        if (tt) {
            CGPoint translation = [recognizer translationInView:recognizer.view];
            translation = ccp(translation.x, -translation.y);
            [self panForTranslation:translation];
            
            //NSLog(@"translation X%f,Y%f----------------",translation.x,-translation.y);
            [recognizer setTranslation:CGPointZero inView:recognizer.view];
        }
        
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded){
        //NSLog(@"**PanEnd");
        if (tt) {
            
            
            //CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
            //NSLog(@"touchLocationx:%f touchLocationy:%f ",touchLocation.x,touchLocation.y);
            
            //NSLog(@"selsprite position x:%f y:%f",selsprite.position.x,selsprite.position.y);
            
            if (selsprite.position.x >= kDestX-kTileImageSize/2 && selsprite.position.x <= kDestX+(kBoxWidth)*kTileImageSize+kTileImageSize/2 && selsprite.position.y >=kStartY-kTileImageSize/2 && selsprite.position.y <= kStartY+(kBoxHeight)*kTileImageSize+kTileImageSize/2) {
                NSLog(@"correct area");
                //NSLog(@"selsprite orix:%d , oriy:%d",selsprite.originalX,selsprite.originalY);
                
                NSLog(@"distance----------\n X:%d  Y:%d \n",abs(selsprite.position.x - selsprite.originalX),abs(selsprite.position.y - selsprite.originalY));
                
                if (abs(selsprite.position.x - selsprite.originalX) <= 40 && abs(selsprite.position.y - selsprite.originalY) <= 40){
                    
                    
                    NSLog(@"correct position");
                    [soundMgr playSoundFile:@"gameclick.mp3"];
                    selsprite.position = ccp(selsprite.originalX, selsprite.originalY);
                    [selsprite setZOrder:0];
                    [box.movableSprites removeObject:selsprite];
                    count+=1;
                    printf("count : %i----------------",count);
                    
                    if (count==9) {
                        isReturn =FALSE;
                        [soundMgr playSoundFile:@"gamesuccess.mp3"];
                        gamewin = [[CCSprite alloc]initWithFile:@"P0-2_game_win.png"];
                        gamewin.position = ccp(512, 384);
                        [self addChild:gamewin];
                        [self schedule:@selector(Showgamewin:) interval:1];
                        
                    }
                    
                }
                
            }
            
        }
        
        
    }
    
}
-(void) Showgamewin:(ccTime)dt{
    if (countTime<2) {
        countTime++;
        printf("countTime %i",countTime);
    }
    else{
        countTime =0;
        [self removeChild:gamewin cleanup:YES];
        [self CheckWin];
        [self unschedule:@selector(Showgamewin:)];
        isReturn = TRUE;
        
    }
}

-(void) CheckWin{
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    MenuImage = [[CCSprite alloc]initWithFile:@"P0-2_game_end.png"];
    MenuImage.position =ccp(size.width/2, size.height/2);
    [self addChild:MenuImage];
    
    ExitBtn = [[CCSprite alloc]initWithFile:@"P0-2_game_exit.png"];
    ExitBtn.position =ccp(512, 350);
    [self addChild:ExitBtn];
    
}
-(void)removeSprite{
    for (MySprite *sprite in box.movableSprites) {
        [self removeChild:sprite cleanup:YES];
    }
    
}
-(void) dealloc {
    
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerLeft];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerRight];
    [delegate.navController.view removeGestureRecognizer:pangestureRecognizer];//new add
    //[self removeSprite];
    //tt = FALSE;
    //[box.movableSprites removeAllObjects];
    //[self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
@end
