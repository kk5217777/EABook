//
//  EAPage1.m
//  EABook
//
//  Created by gdlab on 12/10/27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPage1.h"
#import "EAPageMenu.h"

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

+(CCScene*) sceneWithGamePoint:(GamePoint *)gp
{
	CCScene *scene = [CCScene node];
	EAPage1 *layer = [[EAPage1 alloc] initWithGamePoint:gp];
	[scene addChild: layer];
	return scene;
}
-(id) initWithGamePoint:(GamePoint *)gp
{
    if (self = [super init]) {
        gamepoint = gp;
    }
    return self;
}

-(id) init
{
    if (self = [super init]) {
        
        tapObjectArray = [[NSMutableArray alloc] init];
        swipeObjectArray = [[NSMutableArray alloc] init];
        swipeDirection = UISwipeGestureRecognizerDirectionDown;
        gamepoint = delegate.EAGamePoint;
        //[gamepoint addTypeA];
        NSLog(@"game point: %@", gamepoint.description);
        
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
        
        //[self handlePanAndSwipe];
        
        //音量
        soundDetect = [[SoundSensor alloc] init];
        
        //重力
        //motionDetect = [[MotionSensor alloc] init];
        //[self addChild:motionDetect];
        
        [self addChild:soundDetect];
        [self addChild:soundMgr];
        [self addObjects];
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
    [self addPre];
    [self addNext];
    
    //加入互動物件
    tempObject = [EAAnimSprite spriteWithName:@"P2_Windmill"];
    tempObject.tag = 3;
    tempObject.imgNum = 6;
    tempObject.delayTime = 0.1f;
    //windmil.repeatTime = 2;
    [tempObject setPosition:LOCATION(832, 190)];
    [self addChild:tempObject];
    
    tempObject = [EAAnimSprite spriteWithName:@"P2_horse"];
    tempObject.wordsoundName = @"P2_horse_word.mp3";
    tempObject.wordimageName = @"P2_horse_EN&CH.jpg";
    tempObject.soundName = @"P2_horse.mp3";
    tempObject.tag = 4;
    tempObject.imgNum = 7;
    tempObject.delayTime = 0.1f;
    //horse.repeatTime = 2;
    [tempObject setPosition:LOCATION(775, 380)];
    [self addChild:tempObject];
    
    tempObject = [EAAnimSprite spriteWithName:@"P2_sheep"];
    tempObject.wordsoundName = @"P2_goat_word.mp3";
    tempObject.wordimageName = @"P2_goat_EN&CH.jpg";
    tempObject.soundName = @"P2_goat.mp3";
    tempObject.tag = 5;
    tempObject.imgNum = 2;
    tempObject.repeatTime = 2;
    tempObject.delayTime = 1.0f;
    [tempObject setPosition:LOCATION(580, 625)];
    [self addChild:tempObject];
    
    [tapObjectArray addObject:[self getChildByTag:0]];
    [tapObjectArray addObject:[self getChildByTag:1]];
    [tapObjectArray addObject:[self getChildByTag:5]];
    [tapObjectArray addObject:[self getChildByTag:4]];
    [tapObjectArray addObject:[self getChildByTag:3]];
    [swipeObjectArray addObject:[self getChildByTag:5]];
    [swipeObjectArray addObject:[self getChildByTag:4]];
    [swipeObjectArray addObject:[self getChildByTag:3]];
    
    //soundDetect.sprite = windmil;
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
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageMenu scene] backwards:YES]];
                    break;
                case 1:
                    //下一頁
                    
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
    //NSLog(@"list Direction %dl",swipeDirection);
    //NSLog(@"swipe Direction %d",direction);
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

-(void) draw
{
    //[soundDetect update];
}

-(void) dealloc {
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerLeft];
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerRight];
    [super dealloc];
}
@end
