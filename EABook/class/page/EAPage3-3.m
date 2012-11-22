//
//  EAPage3-3.m
//  EABook
//
//  Created by Mac06 on 12/10/30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPage3-3.h"


@implementation EAPage3_3
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPage3_3 *layer = [EAPage3_3 node];
	
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
        swipeObjectArray = [[NSMutableArray alloc] init];
        moveObjectArray = [[NSMutableArray alloc] init];
        
        //手勢
        //pangestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)] autorelease];
        //[delegate.navController.view addGestureRecognizer:pangestureRecognizer];
        
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
        //soundDetect = [[SoundSensor alloc] init];
        //soundDetect.sManage = soundMgr;
        //[self addChild:soundDetect];
        
        //重力
        motionDetect = [[MotionSensorIce alloc] init];
        motionDetect.sManage = soundMgr;
        [self addChild:motionDetect];
        
        [self addChild:soundMgr];
        [self addObjects];
    }
    return self;
}

-(void) addObjects
{
    //加入背景，一定要先背景再載入sprite圖片的資源檔
    [self addBackGround:@"P4-3_sea.jpg"];
    
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P4-3_cruises.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P4-3_cruises.png"];
    [self addChild:spriteSheet];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P4-3_sailboat.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P4-3_sailboat.png"];
    [self addChild:spriteSheet];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P4-3_speedboat.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P4-3_speedboat.png"];
    [self addChild:spriteSheet];

    
    //加入互動物件
    NSString *tempName;
    
    //背景物件
    tempName = @"P4-3_cruises";
    tempObject = [EAAnimSprite spriteWithName:tempName];
    tempObject.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    tempObject.wordimageName = [NSString stringWithFormat:@"P4-3_steamship_word.png"];
    tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    tempObject.tag = 5;
    tempObject.imgNum = 7;
    tempObject.delayTime = 0.3f;
    //tempObject.repeatTime = 3;
    [tempObject setPosition:ccp( 730 , 160 )];
    [self addChild:tempObject];
    
    //tempName = @"4-3_island";
    CCSprite *island = [CCSprite spriteWithFile:@"P4-3_island.png"];
    [island setPosition:ccp(324, 536)];
    [self addChild:island];
    [moveObjectArray addObject:island];
    
    motionDetect.moveObjects = moveObjectArray;
    
    //互動物件
    tempName = @"P4-3_sailboat";
    tempObject = [EAAnimSprite spriteWithName:tempName];
    tempObject.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    tempObject.wordimageName = [NSString stringWithFormat:@"%@_word.png",tempName];
    tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    tempObject.tag = 3;
    tempObject.imgNum = 7;
    tempObject.delayTime = 0.3f;
    //tempObject.repeatTime = 4;
    [tempObject setPosition:ccp(224,342)];
    [self addChild:tempObject];
    
    tempName = @"P4-3_speedboat";
    tempObject = [EAAnimSprite spriteWithName:tempName];
    tempObject.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    tempObject.wordimageName = [NSString stringWithFormat:@"P4-3_yacht_word.png"];
    tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    tempObject.tag = 4;
    tempObject.imgNum = 6;
    tempObject.delayTime = 0.3f;
    //tempObject.repeatTime = 2;
    [tempObject setPosition:ccp(650,560)];
    [self addChild:tempObject];
    
    //tempName = @"P4-3_island";
    //tempObject = [EAAnimSprite spriteWithName:tempName];
    //tempObject.wordimageName = [NSString stringWithFormat:@"%@_word.png",tempName];
    //tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    //tempObject.tag = 6;
    //tempObject.imgNum = 2;
    //tempObject.delayTime = 0.5f;
    //tempObject.repeatTime = 2;
    //[tempObject setPosition:ccp(324, 556)];
    //[self addChild:tempObject];
    

    //加入上下頁按鈕
    [self addPre];
    [self addNext];
    
    //加入array
    [tapObjectArray addObject:[self getChildByTag:0]];
    [tapObjectArray addObject:[self getChildByTag:1]];
    //[tapObjectArray addObject:[self getChildByTag:6]];
    [tapObjectArray addObject:[self getChildByTag:5]];
    [tapObjectArray addObject:[self getChildByTag:4]];
    [tapObjectArray addObject:[self getChildByTag:3]];
    
    //[swipeObjectArray addObject:[self getChildByTag:6]];
    [swipeObjectArray addObject:[self getChildByTag:5]];
    [swipeObjectArray addObject:[self getChildByTag:4]];
    [swipeObjectArray addObject:[self getChildByTag:3]];
    
    //motionDetect.sprite = (EAAnimSprite*)[self getChildByTag:6];
    motionDetect.sprite2 = (EAAnimSprite*)island;
    //motionDetect.sManage = soundMgr;
}

-(void) draw
{
    if (soundEnable&& moveObjectArray.count > 0) {
        [motionDetect update];
    }
}

#pragma mark 手勢
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
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable) {
        [self swipeSpriteMovement:touchLocation direction:recognizer.direction];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    NSLog(@"tap");
    for (tempObject in tapObjectArray) {
        if (CGRectContainsPoint(tempObject.boundingBox, touchLocation)) {
            NSLog(@"btn tag:%d",tempObject.tag);
            switch (tempObject.tag) {
                case 0:
                    //上一頁
                    [soundMgr playSoundFile:@"nextpage2.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage2 scene] backwards:YES]];
                    break;
                case 1:
                    //下一頁
                    [soundMgr playSoundFile:@"nextpage2.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:TURN_DELAY scene:[EAPageGame1 scene]]];
                    break;
                case 3:
                case 4:
                case 5:
                case 6:
                    [self addWordImage:tempObject.wordimageName];
                    [soundMgr playWordSoundFile:tempObject.wordsoundName];
                    break;
                default:
                    break;
            }
            break;
        }
    }
}

-(void) swipeSpriteMovement:(CGPoint)touchLocation direction:(UISwipeGestureRecognizerDirection) direction
{
    NSLog(@"swipe");
    for (tempObject in swipeObjectArray) {
        if (CGRectContainsPoint(tempObject.boundingBox, touchLocation)) {
            [tempObject startAnimation];
            [soundMgr playSoundFile:tempObject.soundName];
            /*swipe 來回兩次
             //當前一次與本次同一物件進入
             if (tempObject == touchedSprite) {
             //當前一次與本次方向不同時進入
             if (swipeDirection != direction) {
             NSLog(@"swipe twice");
             touchedSprite = Nil;
             //動畫播放
             [tempObject startAnimation];
             }
             else
             {
             swipeDirection = direction;
             }
             }
             else
             {
             touchedSprite = tempObject;
             swipeDirection = direction;
             }*/
        }
    }
}

-(void) dealloc {
    
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerLeft];
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerRight];
    tempObject = nil;
    [super dealloc];
}
@end
