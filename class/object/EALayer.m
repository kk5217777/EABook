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
        
        touchEnable = YES;
        soundEnable = YES;
        
        NSLog(@"Layer");
	}
	return self;
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
}

-(void) dealloc
{
    NSLog(@"EALayer dealloc");
    [super dealloc];
}

@end
