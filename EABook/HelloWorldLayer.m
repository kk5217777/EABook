//
//  HelloWorldLayer.m
//  EABook
//
//  Created by gdlab on 12/10/26.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

+(CCScene*) sceneWithGamePoint:(GamePoint *)gp
{
	CCScene *scene = [CCScene node];
	HelloWorldLayer *pointlayer = [HelloWorldLayer node];
	[scene addChild: pointlayer];
	return scene;
}

-(id) init
{
    if (self = [super init]) {
        //NSLog(@"game point: %@", gp.description);
        
        // always call "super" init
        // Apple recommends to re-assign "self" with the "super's" return value
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
		AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        UIGestureRecognizer *tap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
        [app.navController.view addGestureRecognizer:tap];
        
        /*
         //
         // Leaderboards and Achievements
         //
         
         // Default font size will be 28 points.
         [CCMenuItemFont setFontSize:28];
         
         // Achievement Menu Item using blocks
         CCMenuItem *itemAchievement = [CCMenuItemFont itemWithString:@"Achievements" block:^(id sender) {
         
         
         GKAchievementViewController *achivementViewController = [[GKAchievementViewController alloc] init];
         achivementViewController.achievementDelegate = self;
         
         AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
         
         [[app navController] presentModalViewController:achivementViewController animated:YES];
         
         [achivementViewController release];
         }
         ];
         
         // Leaderboard Menu Item using blocks
         CCMenuItem *itemLeaderboard = [CCMenuItemFont itemWithString:@"Leaderboard" block:^(id sender) {
         
         
         GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
         leaderboardViewController.leaderboardDelegate = self;
         
         AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
         
         [[app navController] presentModalViewController:leaderboardViewController animated:YES];
         
         [leaderboardViewController release];
         }
         ];
         
         CCMenu *menu = [CCMenu menuWithItems:itemAchievement, itemLeaderboard, nil];
         
         [menu alignItemsHorizontallyWithPadding:20];
         [menu setPosition:ccp( size.width/2, size.height/2 - 50)];
         
         // Add the menu to the layer
         [self addChild:menu];
         */
        
        // add "HelloWorld" splash screen"
        //[self addBackGround:@"P2_Background.jpg"];
        
        //CGSize size = [[CCDirector sharedDirector] winSize];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"P2.plist"];
        
        CCSprite* pSprite2 = [CCSprite spriteWithSpriteFrameName:@"P2_horse_0.png"];
        [pSprite2 setPosition:ccp(size.width/2, size.height/2)];
        [self addChild:pSprite2];
        
        CCAnimation *pAnim2 = [CCAnimation animation];
        for(unsigned int i = 1; i < 6; i++)
        {
            NSString *name = [NSString stringWithFormat:@"P2_horse_%d.png", i];
            [pAnim2 addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
        }
        [pAnim2 setDelayPerUnit:1.0f];
        
        [pSprite2 runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0f],
                             [CCAnimate actionWithAnimation:pAnim2],
                             NULL]];
        
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];

    }
    return self;
}

-(void) handleTap:(UIGestureRecognizer*) recognizer
{
    NSLog(@"tap");
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
