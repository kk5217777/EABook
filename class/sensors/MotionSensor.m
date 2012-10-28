//
//  MotionSensor.m
//  EBook ClickAnimate
//
//  Created by Mac06 on 12/10/1.
//
//

#import "MotionSensor.h"
#define LIMIT 0.1

@implementation MotionSensor
-(id) init
{
    if (self = [super init]) {
        enable = YES;
        motionMgr = [[CMMotionManager alloc] init];
        if (motionMgr.isDeviceMotionAvailable) {
            motionMgr.accelerometerUpdateInterval = 1.0/10.0;
            [motionMgr startAccelerometerUpdates];
            if (![motionMgr isAccelerometerActive])
            {
                printf("accelerometer is hot active");
            }
        }
        else
        {
            NSLog(@"Thise device has no accelerometer.");
        }
    }
    return self;
}

-(void) update
{
    if ([motionMgr isAccelerometerActive]) {
        _acData = motionMgr.accelerometerData;
        if (fabsf(_acData.acceleration.x) > LIMIT || fabsf(_acData.acceleration.y) > LIMIT )
        {
            //printf("\nshake!!!!!!");
            [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_MOTION object:self];
        }
        //NSLog(@"Accelerometer\n----------\nx:%+.2f\ny:%+.2f\nz:%+.2f",_acData.acceleration.x, _acData.acceleration.y, _acData.acceleration.z);
    }
}

-(void) updateSprite:(id)object
{
    CCSprite *sprite = object;
    if ([motionMgr isAccelerometerActive]) {
        _acData = motionMgr.accelerometerData;
        if (fabsf(_acData.acceleration.x) > LIMIT )
        {
            [sprite setPosition:CGPointMake((sprite.position.x + _acData.acceleration.x*10), sprite.position.y)];
        }
        //NSLog(@"Accelerometer\n----------\nx:%+.2f\ny:%+.2f\nz:%+.2f",_acData.acceleration.x, _acData.acceleration.y, _acData.acceleration.z);
    }
}

-(void) dealloc
{
    [motionMgr dealloc];
    [super dealloc];
}

-(void) enableFlag
{
    enable = YES;
}
@end
