//
//  EAPage1.m
//  EABook
//
//  Created by gdlab on 12/10/27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPage1.h"

@implementation EAPage1
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPage1 *layer = [EAPage1 node];
	
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
        moveObjectArray = [[[NSMutableArray alloc] init] retain];
        
        eggEnable = YES;
        
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
        motionDetect = [[MotionSensor alloc] init];
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
    [self addBackGround:@"P1_Background.jpg"];
    
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P1.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P1.png"];
    [self addChild:spriteSheet];
    
    //加入上下頁按鈕
    [self addPre];
    [self addNext];
    
    //加入互動物件
    NSString *tempName;
    
    tempName = @"P1_cow";
    cow = [EAAnimSprite spriteWithName:tempName];
    cow.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    cow.wordimageName = [NSString stringWithFormat:@"%@_EN&CH.jpg",tempName];
    cow.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    cow.tag = 4;
    cow.imgNum = 7;
    cow.delayTime = 0.1f;
    cow.repeatTime = 3;
    [cow setPosition:LOCATION(250, 350)];
    [self addChild:cow];
    
    tempName = @"P1_pig";
    pig = [EAAnimSprite spriteWithName:tempName];
    pig.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    pig.wordimageName = [NSString stringWithFormat:@"%@_EN&CH.jpg",tempName];
    pig.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    pig.tag = 5;
    pig.imgNum = 4;
    pig.repeatTime = 3;
    pig.delayTime = 0.2f;
    [pig setPosition:LOCATION(830, 250)];
    [self addChild:pig];
    
    tempName = @"P1_chicken";
    chicken = [EAAnimSprite node];
    [chicken setTextureRect:CGRectMake(0, 0, 130, 130)];
    chicken.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    chicken.wordimageName = [NSString stringWithFormat:@"%@_EN&CH.jpg",tempName];
    chicken.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    chicken.tag = 3;
    chicken.visible = NO;
    [chicken setPosition:LOCATION(450, 640)];
    [self addChild:chicken];
    
    tempName = @"P1_egg";
    
    egg = [EAAnimSprite spriteWithName:tempName];
    egg.tag = 6;
    egg.imgNum = 6;
    egg.delayTime = 0.5f;
    egg.visible = YES;
    [egg setPosition:LOCATION(750, 570)];
    [egg setRotation:-15];
    
    [tapObjectArray addObject:[self getChildByTag:0]];
    [tapObjectArray addObject:[self getChildByTag:1]];
    [tapObjectArray addObject: chicken];
    [tapObjectArray addObject: pig];
    [tapObjectArray addObject: cow];
    
    [swipeObjectArray addObject: chicken];
    [swipeObjectArray addObject: cow];
    [swipeObjectArray addObject: pig];
    
}

-(void) draw
{
    if (soundEnable) {
        [motionDetect update];
    }
}

#pragma 手勢區
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
#pragma mark 手勢
-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    NSLog(@"tap");
    for (tempObject in tapObjectArray) {
        if (CGRectContainsPoint(tempObject.boundingBox, touchLocation)) {
            NSLog(@"btn tag:%d",tempObject.tag);
            switch (tempObject.tag) {
                case 0:
                    //上一頁
                    [soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageMenu scene] backwards:YES]];
                    break;
                case 1:
                    //下一頁
                    [soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage2 scene]]];
                    break;
                case 6:
                    [tapObjectArray removeObject:tempObject];
                    [moveObjectArray removeObject:tempObject];
                    [self removeChild:tempObject cleanup:NO];
                    motionDetect.moveObjects = moveObjectArray;
                    break;
                case 3:
                    [gamepoint addTypeA];
                    [self addWordImage:tempObject.wordimageName];
                    [soundMgr playWordSoundFile:tempObject.wordsoundName];
                    break;
                case 4:
                    [gamepoint addTypeB];
                    [self addWordImage:tempObject.wordimageName];
                    [soundMgr playWordSoundFile:tempObject.wordsoundName];
                    break;
                case 5:
                    [gamepoint addTypeC];
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
        
        CGRect temp = tempObject.boundingBox;
        temp.origin.x = tempObject.boundingBox.origin.x - 50;
        temp.size.width = tempObject.boundingBox.size.width + 100;
        
        if (CGRectContainsPoint(tempObject.boundingBox, touchLocation)) {
            [soundMgr playSoundFile:tempObject.soundName];
            if (tempObject.tag == 3) {
                if (moveObjectArray.count < 5) {
                    NSString *tempName = @"P1_egg";
                    egg = [EAAnimSprite spriteWithName:tempName];
                    egg.tag = 6;
                    egg.imgNum = 6;
                    egg.delayTime = 0.5f;
                    egg.visible = YES;
                    [egg setPosition:LOCATION(750, 570)];
                    [egg setRotation:-15];
                    [moveObjectArray addObject:egg];
                    [tapObjectArray addObject:egg];
                    [self addChild:egg];
                    
                    motionDetect.moveObjects = moveObjectArray;
                    CCRotateTo *rotate = [CCRotateTo actionWithDuration:0.1 angle:480 + 100 * moveObjectArray.count];
                    CCMoveTo *move = [CCMoveTo actionWithDuration:0.1 position:ccp(600+50 * motionDetect.moveObjects.count, 200)];
                    //[egg runAction:rotate];
                    [egg runAction:[CCSpawn actions:rotate, move, nil]];
                }
               /* if (eggEnable) {
                    NSLog(@"eggEnable Add TO motionDectect!!");
                    [tapObjectArray addObject:egg];
                    egg.visible = YES;
                    CCRotateTo *rotate = [CCRotateTo actionWithDuration:0.1 angle:300];
                    CCMoveTo *move = [CCMoveTo actionWithDuration:0.1 position:ccp(700, 200)];
                    [egg runAction:[CCSpawn actions:rotate, move, nil]];
                    
                    motionDetect.sprite = egg;
                    eggEnable = !eggEnable;
                }*/
            }
            else
            {
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

-(void) dealloc {
    [super dealloc];
    
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerLeft];
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerRight];
    
    tempObject = nil;
}
@end
