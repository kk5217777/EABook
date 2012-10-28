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

+(CCScene*) sceneWithGamePoint:(GamePoint *)gp
{
	CCScene *scene = [CCScene node];
	EAPage2 *layer = [[EAPage2 alloc] initWithGamePoint:gp];
	[scene addChild: layer];
	return scene;
}
-(id) initWithGamePoint:(GamePoint *)gp
{
    if (self = [super init]) {
        NSLog(@"game point: %@", gp.description);
        gamepoint = gp;
    }
    return self;
}

-(void) onEnter
{
    tapObjectArray = [[NSMutableArray alloc] init];
    
    NSLog(@"game point: %@", gamepoint.description);
    CGSize size = [[CCDirector sharedDirector] winSize];
    
	CCLabelTTF *tt = [CCLabelTTF labelWithString:@"hello page2" fontName:@"Marker Felt" fontSize:64];
    tt.position = ccp(size.width/2, size.width/2);
    [self addChild:tt];

    
    delegate = (AppController*) [[UIApplication sharedApplication] delegate];
    tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
    tapgestureRecognizer.numberOfTapsRequired = 1; //new add
    [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
    
    soundDetect = [[SoundSensor alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(soundMove) name:EVENT_SOUND object:soundDetect];
    
    [self addObjects];
}

-(void) addObjects
{
    //加入物件
    [self addBackGround:@"P2_Background.jpg"];
    
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"p2.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P2.png"];
    [self addChild:spriteSheet];
    
    EAAnimSprite *animSprite;
    animSprite = [EAAnimSprite spriteWithName:@"P2_horse"];
    animSprite.tag = 1;
    animSprite.imgNum = 6;
    [animSprite setPosition:LOCATION(600, 200)];
    [spriteSheet addChild:animSprite];
    //[self addChild:animSprite];
    [tapObjectArray addObject:animSprite];
    
    
    CCSprite *btnback;
    btnback= [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"P2_horse_0.png"]];
    [btnback setTag:0];
    [btnback setPosition:LOCATION(200, 200)];
    [spriteSheet addChild:btnback];
    [tapObjectArray addObject:btnback];
    
    
     
    NSLog(@"Tap! %d", tapObjectArray.count);
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
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable) {
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    NSLog(@"tap");
    NSMutableArray *animImageFrames = [[NSMutableArray array] retain];
    int imgNum = 6;
    NSString *imageName = @"P2_horse";
    
    for (int i = 0; i < imgNum; i++)
    {
        NSString *fullImagName;
        fullImagName = [NSString stringWithFormat:@"%@_%d.png", imageName, i];
        [animImageFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fullImagName]];
    }
    CCAnimation *animate = [CCAnimation animationWithSpriteFrames:animImageFrames delay:1];
    CCAnimate *action = [CCAnimate actionWithAnimation:animate];
    
    
    for (EAAnimSprite *tapObject in tapObjectArray) {
        if (CGRectContainsPoint(tapObject.boundingBox, touchLocation)) {
            NSLog(@"show config panel");
            NSLog(@"btn tag:%d",tapObject.tag);
            
            switch (tapObject.tag) {
                case 0:
                    NSLog(@"tap 0");
                    [tapObject runAction:action];
                    //[tapObject startAnimation];
                    /*for (int i = 0; i < tapObject.imgNum; i++)
                    {
                        NSString *fullImagName;
                        fullImagName = [NSString stringWithFormat:@"%@%d.png", tapObject.imageName, i];
                        NSMutableArray *animImageFrames = [NSMutableArray array];
                        [animImageFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fullImagName]];
                    }
                    */
                    break;
                case 1:
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
-(void) onExit {
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
}
@end
