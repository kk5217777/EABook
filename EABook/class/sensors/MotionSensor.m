//
//  MotionSensor.m
//  EBook ClickAnimate
//
//  Created by Mac06 on 12/10/1.
//
//

#import "MotionSensor.h"
#define LIMIT 0.5


@implementation MotionSensor
@synthesize sprite;
@synthesize sManage;

-(id) init
{
    if (self = [super init]) {
        animAble = YES;
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
        if (fabsf(_acData.acceleration.y) > LIMIT )
        {
            if (sprite) {
                if (animAble) {
                    [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchTouchInteraction)]];
                    [sprite startLoopAnimation];
                    animAble = !animAble;
                }
                if (sprite.position.x > 30 && sprite.position.x < 1000) {
                    [sprite setPosition:CGPointMake((sprite.position.x + _acData.acceleration.y*10), sprite.position.y)];
                    sprite.rotation += _acData.acceleration.y*10;
                    NSLog(@"MOVE");
                }
                else
                {
                    if (sprite.position.x < 30) {
                        [sprite setPosition:CGPointMake((sprite.position.x+1), sprite.position.y)];
                    }
                    else if (sprite.position.x > 1000)
                    {
                        [sprite setPosition:CGPointMake((sprite.position.x-1), sprite.position.y)];
                    }
                }
            }
        }
        else
        {
            if (sprite) {
                if (!animAble) {
                    [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchTouchInteraction)]];
                    animAble = !animAble;
                    [sprite stopAllActions];
                }
            }
        }
        //NSLog(@"Accelerometer\n----------\nx:%+.2f\ny:%+.2f\nz:%+.2f",_acData.acceleration.x, _acData.acceleration.y, _acData.acceleration.z);
    }
}

-(void) updateSprite:(id)object
{
    sprite = object;
    if ([motionMgr isAccelerometerActive]) {
        _acData = motionMgr.accelerometerData;
        if (fabsf(_acData.acceleration.x) > LIMIT )
        {
            if (animAble) {
                [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchTouchInteraction)]];
                animAble = !animAble;
            }
            [sprite setPosition:CGPointMake((sprite.position.x + _acData.acceleration.x*10), sprite.position.y)];
        }
        else
        {
            if (!animAble) {
                [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchTouchInteraction)]];
                animAble = !animAble;
            }
        }
        //NSLog(@"Accelerometer\n----------\nx:%+.2f\ny:%+.2f\nz:%+.2f",_acData.acceleration.x, _acData.acceleration.y, _acData.acceleration.z);
    }
}

-(void) dealloc
{
    [motionMgr dealloc];
    [super dealloc];
}
@end
