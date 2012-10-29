//
//  EALayer.m
//  EbookAnimal
//
//  Created by Mac06 on 12/10/25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EALayer.h"


@implementation EALayer
@synthesize gamepoint;

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if (self=[super init])
    {
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];// new add
        
        gamepoint = delegate.EAGamePoint;
        
        touchEnable = YES;
        soundEnable = YES;
        
        soundMgr = [[SoundManager alloc] init];
        
        NSLog(@"Layer");
	}
	return self;
}
//等待實作！！
-(void) addWordImage:(NSString*)imageName
{
    
}
-(void) removeWordImage
{
    
}
-(void) addPre
{
    
}
-(void) addNext
{
    
}

-(void) switchInteraction
{
    if (touchEnable) {
        NSLog(@"witchInteraction OFF");
    }
    else{
        NSLog(@"witchInteraction ON");
    }
    touchEnable = !touchEnable;
    soundEnable = !soundEnable;
}

-(void) switchTouchInteraction
{
    if (touchEnable) {
        NSLog(@"switchTouchInteraction OFF");
    }
    else{
        NSLog(@"switchTouchInteraction ON");
    }
    touchEnable = !touchEnable;
    //soundEnable = !soundEnable;
}

-(void) stopSpriteMove
{
    NSLog(@"EALayer stopSpriteMove");
    [self switchInteraction];
}

-(void) addTapToLayer
{
    tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
    tapgestureRecognizer.numberOfTapsRequired = 1; //new add
    
    [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
}
-(void) removeTapFromLayer
{
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
}

-(void) addPanToLayer
{
    pangestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)] autorelease];
    [delegate.navController.view addGestureRecognizer:pangestureRecognizer];
}
-(void) removePanFromLayer
{
    [delegate.navController.view removeGestureRecognizer:pangestureRecognizer];
}

-(void) addSwipeToLayer
{
    swipegestureRecognizerRight = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]autorelease];
    [swipegestureRecognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    swipegestureRecognizerLeft = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]autorelease];
    [swipegestureRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [delegate.navController.view addGestureRecognizer:swipegestureRecognizerRight];
    [delegate.navController.view addGestureRecognizer:swipegestureRecognizerLeft];
}
-(void) removeSwipeFromLayer
{
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerRight];
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerLeft];
}

-(void) handlePanAndSwipe
{
    [pangestureRecognizer requireGestureRecognizerToFail:swipegestureRecognizerLeft];
    [pangestureRecognizer requireGestureRecognizerToFail:swipegestureRecognizerRight];
}
//來回swipe動作
-(void) swipeSpriteMovement:(CGPoint)touchLocation direction:(UISwipeGestureRecognizerDirection) direction
{
    //NSLog(@"list Direction %dl",swipeDirection);
    //NSLog(@"swipe Direction %d",direction);
    for (tempObject in swipeObjectArray) {
        if (CGRectContainsPoint(tempObject.boundingBox, touchLocation)) {
            //當前一次與本次同一物件進入
            if (tempObject == touchedSprite) {
                //當前一次與本次方向不同時進入
                if (swipeDirection != direction) {
                    NSLog(@"swipe twice");
                    touchedSprite = Nil;
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
            }
        }
    }
}

-(void) addBackGround:(NSString*)imageName
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *backGround = [CCSprite spriteWithFile:imageName];
    backGround.position = ccp(size.width/2, size.height/2);
    [self addChild:backGround];
}

-(void) addSprite:(CCSprite*) obj spriteType:(int)type
{
    switch (type) {
        case TAP:
            if (!tapObjectArray) {
                [tapObjectArray addObject:obj];
                [self addChild:obj];
            }
            else
                NSLog(@"tap array 沒有初始化");
            break;
        case SWIPE:
            if (!swipeObjectArray) {
                [swipeObjectArray addObject:obj];
                [self addChild:obj];
            }
            else
                NSLog(@"swipe array 沒有初始化");
            break;
        case PAN:
            if (!panObjectArray) {
                [panObjectArray addObject:obj];
                [self addChild:obj];
            }
            else
                NSLog(@"pan array 沒有初始化");
            break;
        case MOVE:
            if (!moveObjectArray) {
                [moveObjectArray addObject:obj];
                [self addChild:obj];
            }
            else
                NSLog(@"move array 沒有初始化");
            break;
        default:
            break;
    }
}

-(void) onExit{
    NSLog(@"EALayer exit");
    delegate.EAGamePoint = gamepoint;
}

-(void) dealloc
{
    NSLog(@"EALayer dealloc");
    [super dealloc];
}

@end
