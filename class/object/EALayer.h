//
//  EALayer.h
//  EbookAnimal
//
//  Created by Mac06 on 12/10/25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SoundSensor.h"
#import "MotionSensor.h"
#import "AppDelegate.h"
#import "GamePoint.h"
#import "SoundDetectOB.h"
#import "EAAnimSprite.h"

@interface EALayer : CCLayer {
    @protected
    NSMutableArray *tapObjectArray;
    NSMutableArray *swipeObjectArray;
    NSMutableArray *panObjectArray;
    NSMutableArray *moveObjectArray;
    
    GamePoint *gamepoint;
    AppController *delegate;
    
    BOOL touchEnable;
    BOOL soundEnable;
    
    SoundSensor *soundDetect;
    MotionSensor *motionDetect;
    
    UITapGestureRecognizer *tapgestureRecognizer;
    UISwipeGestureRecognizer *swipegestureRecognizerLeft;
    UISwipeGestureRecognizer *swipegestureRecognizerRight;
    UIPanGestureRecognizer *pangestureRecognizer;
    
    CCSpriteBatchNode *spriteSheet;
}
@property (nonatomic,retain) GamePoint *gamepoint;
+(CCScene *) scene;
+(CCScene*) sceneWithGamePoint:(GamePoint *)gp;
-(id) initWithGamePoint :(GamePoint *)gp;

-(void) addObjects;
-(void) addImage;
-(void) addGamePoint:(SoundDetectOB*) object;
-(void) handleSwipe:(UISwipeGestureRecognizer *)recognizer;
-(void) handleTap:(UITapGestureRecognizer *)recognizer;
-(void) handlePan:(UITapGestureRecognizer *)recognizer;
-(void) swipeRightSpriteMovement:(CGPoint)touchLocation;
-(void) swipeLeftSpriteMovement:(CGPoint)touchLocation;
-(void) tapSpriteMovement:(CGPoint)touchLocation;
-(void) panSpriteMovement:(CGPoint)touchLocation;

-(void) addSprite:(CCSprite*) obj spriteType:(int)type;
/*
-(void) addTapToLayer;
-(void) addPanToLayer;
-(void) addSwipeToLayer;
-(void) handlePanAndSwipe;
-(void) removeTapFromLayer;
-(void) removePanFromLayer;
-(void) removeSwipeFromLayer;
*/
-(void) addBackGround:(NSString*)imageName;

@end
