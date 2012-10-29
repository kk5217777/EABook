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

@interface MotionSensor : CCNode
{
    CMMotionManager *motionMgr;
    CMAccelerometerData *_acData;
    
    BOOL animAble;
}

@property (nonatomic, retain) CMAccelerometerData *acData;

-(id) init;
-(void) update;
-(void) updateSprite:(id)object;
@end
