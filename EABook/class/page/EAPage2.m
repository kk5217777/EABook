//
//  EAPage2.m
//  EABook
//
//  Created by gdlab on 12/10/27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPage2.h"
#import "EAPageMenu.h"

@implementation EAPage2

+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPage2 *layer = [EAPage2 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if (self = [super init]) {
        
        tapObjectArray = [[NSMutableArray alloc] init];
        
        NSLog(@"game point: %@", gamepoint.description);
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF *tt = [CCLabelTTF labelWithString:@"hello page2" fontName:@"Marker Felt" fontSize:64];
        tt.position = ccp(size.width/2, size.width/2);
        [self addChild:tt];
        
        [self addObjects];
        
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        
        gamepoint = delegate.EAGamePoint;
        
        soundDetect = [[SoundSensor alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(soundMove) name:EVENT_SOUND object:soundDetect];
        
    }
    return self;
}

-(void) addObjects
{
    //加入物件
    [self addBackGround:@"P2_Background.jpg"];
    
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P2.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P2.png"];
    [self addChild:spriteSheet];
    
    //EAAnimSprite *animSprite;
    animSprite = [EAAnimSprite spriteWithName:@"P2_horse"];
    animSprite.tag = 1;
    animSprite.imgNum = 6;
    [animSprite setPosition:LOCATION(600, 200)];
    //[spriteSheet addChild:animSprite];
    [self addChild:animSprite];
    [tapObjectArray addObject:animSprite];
    
    
}

-(void) draw
{
    //[soundDetect update];
}

-(void) soundMove
{
    printf("sound");
    [soundDetect enableFlag];
}

-(void) handleTap:(UITapGestureRecognizer*) recognizer
{
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable) {
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    NSLog(@"tap");
    
    for (EAAnimSprite *tapObject in tapObjectArray) {
        if (CGRectContainsPoint(tapObject.boundingBox, touchLocation)) {
            NSLog(@"btn tag:%d",tapObject.tag);
            switch (tapObject.tag) {
                case 0:
                    NSLog(@"tap 0");
                    
                    break;
                case 1:
                    [animSprite startAnimation];
                    break;
                case 2:
                    break;
                case 3:
                case 4:
                    break;
                default:
                    break;
            }
            break;
        }
    }
    
}
-(void) dealloc {
    [super dealloc];
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
}
@end
