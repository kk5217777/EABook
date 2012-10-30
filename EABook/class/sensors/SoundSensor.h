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
#import "EAAnimSprite.h"

@interface SoundSensor : CCNode
{
    float soundLimit,lowPassResults;
    AVAudioRecorder *recorder;
    BOOL enable;
    EAAnimSprite *sprite;
}
@property (nonatomic, retain) EAAnimSprite *sprite;
-(id) init;
-(void) update;
-(void) updateSprite:(id)object;
//-(void) enableFlag;
//-(void) stopDetect;
@end