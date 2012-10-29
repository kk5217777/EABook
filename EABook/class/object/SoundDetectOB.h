//
//  SoundDetectOB.h
//  EBook ClickAnimate
//
//  Created by gdlab on 12/8/15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "cocos2d.h"

@interface SoundDetectOB : CCSprite {
    NSString *fileName;
    NSString *fileType;
    NSString *soundfileName;
    NSString *wordsoundfileName;
    NSString *wordimagefileName;
    NSString *cartype;
    CCSprite *wordimage;
    NSInteger imgNum;
    AVAudioPlayer *audioPlayer;
    unsigned int soundEffectID;
    unsigned int wordsoundEffectID;
    BOOL isplaydone;
    float delayTime;
}

@property(nonatomic, retain)NSString *fileName,*soundfileName,*wordsoundfileName,*wordimagefileName,*cartype;
@property(nonatomic, readwrite)NSInteger imgNum;
@property(nonatomic, readwrite)float delayTime;

+ (id)spriteWithName:(NSString*)name;
- (id)initWithName:(NSString*)name;

-(void) load;
-(void) animation;
-(void) makeanimation;
-(void) animationForever;

-(void) addSoundEffect;
-(void) stopSoundEffect;
-(void) addWordSoundEffect;
-(void) stopWordSoundEffect;
-(CCSprite *) addWordImage;
-(void) removeWordImage;

@end
