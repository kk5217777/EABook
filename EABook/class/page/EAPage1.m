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
        /*
        swipegestureRecognizerUp = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]autorelease];
        [swipegestureRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionUp];
        
        swipegestureRecognizerDown = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]autorelease];
        [swipegestureRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionDown];
        
        [delegate.navController.view addGestureRecognizer:swipegestureRecognizerUp];
        [delegate.navController.view addGestureRecognizer:swipegestureRecognizerDown];
         */
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
    [self addBackGround:@"P2_background.jpg"];
    
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P2_DustCar.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P2_DustCar.png"];
    [self addChild:spriteSheet];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P2_LectCar.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P2_LectCar.png"];
    [self addChild:spriteSheet];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P2_Train.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P2_Train.png"];
    [self addChild:spriteSheet];
    
    //加入上下頁按鈕
    [self addPre];
    [self addNext];
    
    //加入互動物件
    NSString *tempName;
    
    tempName = @"P2_DustCar";
    DustCar = [EAAnimSprite spriteWithName:tempName];
    DustCar.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    DustCar.wordimageName = [NSString stringWithFormat:@"P2_Truck_en&ch.jpg"];
    DustCar.wordsoundName = [NSString stringWithFormat:@"P2_Dustcar_word.mp3"];
    DustCar.tag = 3;
    DustCar.imgNum = 5;
    DustCar.delayTime = 0.3f;
    //DustCar.repeatTime = 1;
    [DustCar setPosition:ccp( 206 , 450 )];
    [self addChild:DustCar];
    
    tempName = @"P2_LectCar";
    LectCar = [EAAnimSprite spriteWithName:tempName];
    LectCar.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    LectCar.wordimageName = [NSString stringWithFormat:@"P2_crane_en&ch.jpg"];
    LectCar.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    LectCar.tag = 4;
    LectCar.imgNum = 2;
    //LectCar.repeatTime = 1;
    LectCar.delayTime = 0.3f;
    [LectCar setPosition:ccp( 660 , 468)];
    [self addChild:LectCar];
    
    tempName = @"P2_Train";
    Train = [EAAnimSprite spriteWithName:tempName];
    //[chicken setTextureRect:CGRectMake(0, 0, 130, 130)];
    Train.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    Train.wordimageName = [NSString stringWithFormat:@"P2_train_en&ch.jpg"];
    Train.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    Train.tag = 5;
    Train.imgNum = 4;
    Train.delayTime = 0.3f;
    [Train setPosition:ccp( 780 , 158 )];
    [self addChild:Train];
    
    
    [tapObjectArray addObject:[self getChildByTag:0]];
    [tapObjectArray addObject:[self getChildByTag:1]];
    [tapObjectArray addObject: Train];
    [tapObjectArray addObject: DustCar];
    [tapObjectArray addObject: LectCar];
    
    [swipeObjectArray addObject: DustCar];
    [swipeObjectArray addObject: LectCar];
    [swipeObjectArray addObject: Train];
}

-(void) draw
{
    if (soundEnable && moveObjectArray.count > 1) {
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
    NSLog(@"swipe");
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
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage0 scene] backwards:YES]];
                    break;
                case 1:
                    //下一頁
                    [soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage2 scene]]];
                    break;
                case 6: //蛋tap消失
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
        
        CGRect temp = tempObject.boundingBox;
        temp.origin.x = tempObject.boundingBox.origin.x - 50;
        temp.size.width = tempObject.boundingBox.size.width + 100;
        
        if (CGRectContainsPoint(tempObject.boundingBox, touchLocation)) {
            [soundMgr playSoundFile:tempObject.soundName];
            switch (tempObject.tag) {
                    case 3:
                        [gamepoint addTypeA];
                        break;
                    case 4:
                        [gamepoint addTypeB];
                        break;
                    case 5:
                        [gamepoint addTypeC];
                        break;
                    default:
                        break;
                }
                [tempObject startAnimation];
            
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
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerUp];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerDown];
    tempObject = nil;
}
@end
