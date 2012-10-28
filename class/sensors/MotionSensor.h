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

@interface MotionSensor : NSObject
{
    BOOL enable;
    CMMotionManager *motionMgr;
    CMAccelerometerData *_acData;
}

@property (nonatomic, retain) CMAccelerometerData *acData;

-(id) init;
-(void) update;
-(void) enableFlag;
@end
