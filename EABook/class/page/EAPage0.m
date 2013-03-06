//
//  EAPage0.m
//  EABook
//
//  Created by Mac04 on 12/11/2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPage0.h"
#import <QuartzCore/QuartzCore.h>

@implementation EAPage0
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPage0 *layer = [EAPage0 node];
	
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
        panObjectArray = [[NSMutableArray alloc] init];
        
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
        
        pangestureRecognizer = [[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)]autorelease];
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
        [delegate.navController.view addGestureRecognizer:pangestureRecognizer];
        
        [pangestureRecognizer requireGestureRecognizerToFail:swipegestureRecognizerLeft];
        [pangestureRecognizer requireGestureRecognizerToFail:swipegestureRecognizerRight];
        
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
    [self addBackGround:@"P1_Background.jpg"];
    CCSprite *Man = [[CCSprite alloc]initWithFile:@"P1_Man.png"];
    Man.position = ccp(510, 112);
    [self addChild:Man];
    
    CCSprite *OldWomen = [[CCSprite alloc]initWithFile:@"P1_OldWomen.png"];
    OldWomen.position = ccp(164, 112);
    [self addChild:OldWomen];
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P1_taxi.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P1_taxi.png"];
    [self addChild:spriteSheet];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P1_ThreeCar.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P1_ThreeCar.png"];
    [self addChild:spriteSheet];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P1_cat.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P1_cat.png"];
    [self addChild:spriteSheet];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P1_dog.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P1_dog.png"];
    [self addChild:spriteSheet];

    
    //加入上下頁按鈕
    [self addPre];
    [self addNext];
    
    //加入互動物件
    NSString *tempName;
    
    
    
    tempName = @"P1_cat";
    Cat = [EAAnimSprite spriteWithName:tempName];
    //pig.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    //pig.wordimageName = [NSString stringWithFormat:@"%@_en&ch.jpg",tempName];
    //pig.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    //Cat.tag = 5;
    Cat.imgNum = 2;
    Cat.repeatTime = 3;
    Cat.delayTime = 0.3f;
    [Cat setPosition:ccp(512, 384)];
    [self addChild:Cat];
    
    tempName = @"P1_dog";
    Dog = [EAAnimSprite spriteWithName:tempName];
    //[chicken setTextureRect:CGRectMake(0, 0, 130, 130)];
    //chicken.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    //chicken.wordimageName = [NSString stringWithFormat:@"%@_en&ch.jpg",tempName];
    //chicken.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    Dog.imgNum = 4;
    //Dog.tag = 4;
    //chicken.visible = NO;
    Dog.delayTime = 0.3f;
    [Dog setPosition:ccp(660, 192)];
    [self addChild:Dog];
    
    tempName = @"P1_taxi";
    
    Taxi = [EAAnimSprite spriteWithName:tempName];
    Taxi.soundName =[NSString stringWithFormat:@"%@.mp3",tempName];
    Taxi.wordimageName = [NSString stringWithFormat:@"%@_en&ch.jpg",tempName];
    Taxi.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    Taxi.tag = 3;
    Taxi.imgNum = 3;
    Taxi.delayTime = 0.5f;
    //Taxi.visible = YES;
    [Taxi setPosition:ccp(710, 390)];
    [moveObjectArray addObject:Taxi];
    [tapObjectArray insertObject:Taxi atIndex:0];
    [self addChild:Taxi];
    
    motionDetect.moveObjects = moveObjectArray;
    
    tempName = @"P1_ThreeCar";
    ThreeCar = [EAAnimSprite spriteWithName:tempName];
    ThreeCar.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    ThreeCar.wordimageName = [NSString stringWithFormat:@"%@_en&ch.jpg",tempName];
    ThreeCar.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    ThreeCar.wordMusicName = [NSString stringWithFormat:@"%@_music.mp3",tempName];
    ThreeCar.tag = 4;
    ThreeCar.imgNum = 2;
    ThreeCar.delayTime = 0.5f;
    ThreeCar.repeatTime = 2;
    [ThreeCar setPosition:ccp(300, 266)];
    [self addChild:ThreeCar];
    
    [tapObjectArray addObject:[self getChildByTag:0]];
    [tapObjectArray addObject:[self getChildByTag:1]];
    [tapObjectArray addObject: Taxi];
    [tapObjectArray addObject: ThreeCar];
        
    
    [swipeObjectArray addObject: Cat];
    [swipeObjectArray addObject: Dog];
    
    [panObjectArray addObject:ThreeCar];
    tempObject = nil;
    
    motionDetect.sprite = Taxi;
}

-(void) draw
{
    
    if (_soundEnable && moveObjectArray.count > 0) {
        [motionDetect update];
    }
    
    //glEnable(GL_LINE_SMOOTH);
    //glColor4f(255, 0, 0, 255);
    //glLineWidth(2);
    //CGPoint verices2[] = {ccp(temp.origin.x, temp.origin.y), ccp(temp.origin.x + temp.size.width, temp.origin.y), ccp(temp.origin.x + temp.size.width, temp.origin.y + temp.size.height ), ccp(temp.origin.x, temp.origin.y + temp.size.height) };
    
    //ccDrawPoly(verices2, 4, YES);
}

#pragma 手勢區
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
    NSLog(@"swipe");
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
        //NSLog(@"pan OutSide");
        if (_panEnable) {
            
            for (tempObject in panObjectArray) {
                if (CGRectContainsPoint(tempObject.boundingBox, touchLocation)) {
                    NSLog(@"pan");
                    selectedMoveSprite = tempObject.tag;
                    [self switchInteractionElse:self data:PAN];
                    
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
        if (_panEnable && !_tapEnable) {
            
                    NSLog(@"pan END");
                    selectedMoveSprite = -1;
                    [self switchInteractionElse:self data:PAN];
                    
                    [tempObject stopAllActions];
                    if (tempObject.soundName && soundMgr) {
                        [soundMgr stopSound];
                    }
        }
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
                    [soundMgr playSoundFile:@"nextpage2.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:TURN_DELAY scene:[EAPageMenu scene]]];
                    break;
                case 1:
                    //下一頁
                    [soundMgr playSoundFile:@"nextpage2.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage1 scene]]];
                    break;
                case 2://Word image 的叉叉
                    [soundMgr stopSound];
                    soundFile = NULL;
                    [self removeWordImage];
                    [self switchInteractionElse:NULL data:TAP];
                    break;
                case 20:
                    [soundMgr stopSound];
                    NSLog(@"%@",soundFile);
                    [soundMgr playMusicFile:soundFile];
                    [self schedule:@selector(checkMusicPlay:) interval:0.5];
                    break;
                case 6: //蛋tap消失
                case 3:
                case 4:
                case 5:
                    [self addWordImage:tempObject.wordimageName :tempObject.wordMusicName];
                    [soundMgr playWordSoundFile:tempObject.wordsoundName];
                    soundFile = tempObject.wordMusicName;
                    break;
                default:
                    break;
            }
            break;
        }
    }
}

#pragma mark 播放兒歌時的轉圈圖案
-(void) checkMusicPlay:(ccTime)dt{
    NSLog(@"music is play %d",soundMgr.musicPlayer.isPlaying);
    if (soundMgr.musicPlayer && soundMgr.musicPlayer.isPlaying) {
        [MusicButton startCircle];
    }
    else if (soundMgr.musicPlayer && !soundMgr.musicPlayer.isPlaying){
        [MusicButton stopCircle];
        [self unschedule:@selector(checkMusicPlay:)];
    }
}

-(void) swipeSpriteMovement:(CGPoint)touchLocation direction:(UISwipeGestureRecognizerDirection) direction
{
    NSLog(@"swipe");
    for (tempObject in swipeObjectArray) {
        
        temp = tempObject.boundingBox;
        temp.origin.x = tempObject.boundingBox.origin.x-40;
        temp.origin.y = tempObject.boundingBox.origin.y-20;
        temp.size.width = tempObject.boundingBox.size.width + 80;
        temp.size.height = tempObject.boundingBox.size.height + 30;
        
        
        if (CGRectContainsPoint(temp, touchLocation)) {
            //[soundMgr playSoundFile:tempObject.soundName];
            //[self draw];
                /*
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
                }*/
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
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerUp];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerDown];
    tempObject = nil;
}
@end
