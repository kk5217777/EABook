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

-(void) onEnter
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
	CCLabelTTF *tt = [CCLabelTTF labelWithString:@"hello page1" fontName:@"Marker Felt" fontSize:64];
    tt.position = ccp(size.width/2, size.width/2);
    [self addChild:tt];
    
    
    delegate = (AppController*) [[UIApplication sharedApplication] delegate];
    tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
    tapgestureRecognizer.numberOfTapsRequired = 1; //new add
    [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
    
    soundDetect = [[SoundSensor alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(soundMove) name:EVENT_SOUND object:soundDetect];
}

-(void) draw
{
    [soundDetect update];
}

-(void) soundMove
{
    printf("sound");
    [soundDetect enableFlag];
}

-(void) handleTap:(UITapGestureRecognizer*) recognizer
{
    NSLog(@"tap");
    
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[EAPageMenu scene] withColor:ccWHITE]];
}
-(void) onExit {
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
}
@end
