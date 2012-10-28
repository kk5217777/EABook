//
//  SoundSensor.h
//  EBook ClickAnimate
//
//  Created by Mac06 on 12/10/1.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "cocos2d.h"

@interface SoundSensor : NSObject
{
    float soundLimit,lowPassResults;
    AVAudioRecorder *recorder;
    BOOL enable;
}

-(id) init;
-(void) update;
-(void) enableFlag;
-(void) stopDetect;
@end
