//
//  EAPage3-2.m
//  EABook
//
//  Created by Mac06 on 12/10/30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPage3-2.h"


@implementation EAPage3_2
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPage3_2 *layer = [EAPage3_2 node];
	
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
        panObjectArray= [[NSMutableArray alloc] init];
        
        selectedMoveSprite = -1;
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
        
        pangestureRecognizer = [[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)]autorelease];
        [delegate.navController.view addGestureRecognizer:pangestureRecognizer];
        
        //音量
        soundDetect = [[SoundSensor alloc] init];
        soundDetect.sManage = soundMgr;
        [self addChild:soundDetect];
        
        //重力
        //motionDetect = [[MotionSensor alloc] init];
        //motionDetect.sManage = soundMgr;
        //[self addChild:motionDetect];
        
        [self addChild:soundMgr];
        [self addObjects];
    }
    return self;
}

-(void) addObjects
{
    //加入背景，一定要先背景再載入sprite圖片的資源檔
    [self addBackGround:@"P4-2_airport.jpg"];
    
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P4-2_airplane.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P4-2_airplane.png"];
    [self addChild:spriteSheet];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P4-2_helicopter.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P4-2_helicopter.png"];
    [self addChild:spriteSheet];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P4-2_hotairballoon.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P4-2_hotairballoon.png"];
    [self addChild:spriteSheet];
    
    //加入互動物件
    NSString *tempName;
    
    tempName = @"P4-2_airplane";
    tempObject = [EAAnimSprite spriteWithName:tempName];//5
    tempObject.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    tempObject.wordimageName = [NSString stringWithFormat:@"%@_word.png",tempName];
    tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    tempObject.tag = 3;
    tempObject.imgNum = 7;
    tempObject.delayTime = 0.3f;
    //tempObject.repeatTime = 3;
    [tempObject setPosition:ccp(586,482)];
    [self addChild:tempObject];
    //[moveObjectArray addObject:tempObject];
    
    tempName = @"P4-2_helicopter";
    tempObject = [EAAnimSprite spriteWithName:tempName];//4
    tempObject.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    tempObject.wordimageName = [NSString stringWithFormat:@"%@_word.png",tempName];
    tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    tempObject.tag = 4;
    //tempObject.scale = 1.2f;
    tempObject.imgNum = 2;
    tempObject.delayTime = 0.25f;
    tempObject.repeatTime = 3;
    [tempObject setPosition:ccp(736 , 147)];
    [self addChild:tempObject];
    //[moveObjectArray addObject:tempObject];
    
    tempName = @"P4-2_hotairballoon";
    tempObject = [EASoundDectectSprite spriteWithName:tempName];//3
    tempObject.soundName = [NSString stringWithFormat:@"P4-2_hotairballo.mp3"];
    tempObject.wordimageName = [NSString stringWithFormat:@"%@_word.png",tempName];
    tempObject.wordsoundName = [NSString stringWithFormat:@"P4-2_hotairballo_word.mp3"];
    tempObject.tag = 5;
    //tempObject.scale = 1.2f;
    tempObject.imgNum = 6;
    tempObject.delayTime = 0.3f;
    //tempObject.repeatTime = 3;
    [tempObject setPosition:ccp(216,187)];
    [self addChild:tempObject];
    [moveObjectArray addObject:tempObject];
    soundDetect.moveObjects = moveObjectArray;
    /*
    tempObject = [EAAnimSprite spriteWithName:tempName];//2
    //tempObject.tag = 5;
    tempObject.scale = 1.2f;
    tempObject.imgNum = 2;
    tempObject.delayTime = 0.2f;
    tempObject.repeatTime = 3;
    [tempObject setPosition:LOCATION(250, 600)];
    [self addChild:tempObject];
    [moveObjectArray addObject:tempObject];
    
    tempObject = [EAAnimSprite spriteWithName:tempName];//1
    //tempObject.tag = 5;
    tempObject.scale = 1.2f;
    tempObject.imgNum = 2;
    tempObject.delayTime = 0.3f;
    tempObject.repeatTime = 3;
    [tempObject setPosition:LOCATION(150, 650)];
    [self addChild:tempObject];
    [moveObjectArray addObject:tempObject];
    
    tempName = @"P3-2_tree";//樹兩棵
    tempObject = [EAAnimSprite spriteWithName:tempName];
    tempObject.imgNum = 4;
    tempObject.delayTime = 0.25f;
    //tempObject.repeatTime = 2;
    [tempObject setPosition:LOCATION(260, 180)];
    [self addChild:tempObject];
    [moveObjectArray addObject:tempObject];
    
    tempObject = [EAAnimSprite spriteWithName:tempName];
    tempObject.imgNum = 4;
    tempObject.delayTime = 0.2f;
    //tempObject.repeatTime = 2;
    [tempObject setFlipX:YES];
    [tempObject setPosition:LOCATION(640, 220)];
    [self addChild:tempObject];
    [moveObjectArray addObject:tempObject];
    soundDetect.moveObjects = moveObjectArray;
    
    tempName = @"P3-2_water";
    tempObject = [EAAnimSprite spriteWithName:tempName];
    tempObject.tag = 7;
    tempObject.imgNum = 4;
    tempObject.delayTime = 0.2f;
    tempObject.repeatTime = 6;
    [tempObject setPosition:LOCATION(530, 670)];
    [self addChild:tempObject];
    
    //動物們～～
    tempName = @"P3-2_elephant";
    tempObject = [EAAnimSprite spriteWithName:tempName];
    tempObject.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    tempObject.wordimageName = [NSString stringWithFormat:@"%@_word.png",tempName];
    tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    tempObject.tag = 3;
    tempObject.imgNum = 3;
    tempObject.delayTime = 0.2f;
    tempObject.repeatTime = 6;
    [tempObject setPosition:LOCATION(640, 560)];
    [self addChild:tempObject];
    
    tempName = @"P3-2_giraffe";
    tempObject = [EAAnimSprite spriteWithName:tempName];
    tempObject.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    tempObject.wordimageName = [NSString stringWithFormat:@"%@_word.png",tempName];
    tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    tempObject.tag = 4;
    tempObject.imgNum = 4;
    tempObject.delayTime = 0.2f;
    tempObject.repeatTime = 4;
    [tempObject setPosition:LOCATION(445, 260)];
    [self addChild:tempObject];*/
    
    //加入上下頁按鈕
    [self addPre];
    [self addNext];
    
    //加入array
    [tapObjectArray addObject:[self getChildByTag:0]];
    [tapObjectArray addObject:[self getChildByTag:1]];
    [tapObjectArray addObject:[self getChildByTag:4]];
    [tapObjectArray addObject:[self getChildByTag:3]];
    [tapObjectArray addObject:[self getChildByTag:5]];
    
    [panObjectArray addObject:[self getChildByTag:4]];
    [panObjectArray addObject:[self getChildByTag:3]];
    tempObject = nil;
    //soundDetect.sprite = (EAAnimSprite*)[self getChildByTag:3];
}

-(void) draw
{
    if (_soundEnable) {
        [soundDetect update];
    }
}

#pragma mark 手勢
-(void) handleTap:(UITapGestureRecognizer*) recognizer
{
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (_tapEnable) {
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) handleSwipe:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (_swipeEnable) {
        [self swipeSpriteMovement:touchLocation direction:recognizer.direction];
    }
}
-(void)handlePan:(UIPanGestureRecognizer *)recognizer{
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (_panEnable) {
            for (tempObject in panObjectArray) {
                if (CGRectContainsPoint(tempObject.boundingBox, touchLocation)) {
                    //NSLog(@"pan");
                    selectedMoveSprite = tempObject.tag;
                    [self switchInteractionElse:self data:PAN];
                    //[self panSpriteMovement:touchLocation];
                    
                    [tempObject startLoopAnimation];
                    if (tempObject.soundName) {
                        [soundMgr playLoopSound:tempObject.soundName];
                    }
                    break;
                }
            }
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (_panEnable) {
            NSLog(@"pan");
            CGPoint translation = [recognizer translationInView:recognizer.view];
            translation = ccp(translation.x, -translation.y);
            [self panSpriteMovement:translation];
            //}
            //NSLog(@"translation X%f,Y%f----------------",translation.x,-translation.y);
            [recognizer setTranslation:CGPointZero inView:recognizer.view];
        }
    }
    else
    {
        if (_panEnable) {
            for (tempObject in panObjectArray) {
                if (CGRectContainsPoint(tempObject.boundingBox, touchLocation)) {
                            NSLog(@"pan END");
                    selectedMoveSprite = -1;
                    [self switchInteractionElse:self data:PAN];
                    
                    [tempObject stopAllActions];
                    if (tempObject.soundName && soundMgr) {
                        [soundMgr stopSound];
                    }
            //[recognizer setTranslation:CGPointZero inView:recognizer.view];
                }
            }
        }
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
                    //[[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage4 scene]]];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:TURN_DELAY scene:[EAPageGame1 scene]]];
                    break;
                case 2://Word image 的叉叉
                    [soundMgr stopSound];
                    [self removeWordImage];
                case 3:
                case 4:
                case 5:
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
            if (tempObject.tag == 3) {
                tempObject = (EAAnimSprite*)[self getChildByTag:7];
                [tempObject startAnimation];
            }
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
-(void) panSpriteMovement:(CGPoint)touchLocation{
    NSLog(@"move sprite");
    if (selectedMoveSprite > 0) {
        tempObject = (EAAnimSprite*)[self getChildByTag:selectedMoveSprite];
    }
    if (tempObject.position.x<1000 && tempObject.position.x>20 && tempObject.position.y <740 && tempObject.position.y >20) {
        CGPoint newPos = ccpAdd(tempObject.position, touchLocation);
        tempObject.position = newPos;
    }
    else
    {
        if (tempObject.position.x >= 1000) {
            CGPoint newPos = ccpSub(tempObject.position, CGPointMake(20, 0));
            tempObject.position = newPos;
        }
        if (tempObject.position.x <= 20) {
            CGPoint newPos = ccpAdd(tempObject.position, CGPointMake(20, 0));
            tempObject.position = newPos;
        }
        if (tempObject.position.y >= 740) {
            CGPoint newPos = ccpSub(tempObject.position, CGPointMake(0, 30));
            tempObject.position = newPos;
        }
        if (tempObject.position.y <= 20) {
            CGPoint newPos = ccpAdd(tempObject.position, CGPointMake(0, 30));
            tempObject.position = newPos;
        }
    }
}

-(void) dealloc {
    [super dealloc];
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerLeft];
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerRight];
    [delegate.navController.view removeGestureRecognizer:pangestureRecognizer];
    tempObject = nil;
}
@end
