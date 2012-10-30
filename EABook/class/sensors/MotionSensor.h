//
//  MotionSensor.h
//  EBook ClickAnimate
//
//  Created by Mac06 on 12/10/1.
//
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "cocos2d.h"
#import "EAAnimSprite.h"
#import "SoundManager.h"

@interface MotionSensor : CCNode
{
    CMMotionManager *motionMgr;
    CMAccelerometerData *_acData;
    
    BOOL animAble;
    
    EAAnimSprite *sprite;
    SoundManager *sManage;
}

@property (nonatomic, retain) CMAccelerometerData *acData;
@property (nonatomic, retain) EAAnimSprite *sprite;
@property (nonatomic, retain) SoundManager *sManage;

-(id) init;
-(void) update;
-(void) updateSprite:(id)object;
@end
