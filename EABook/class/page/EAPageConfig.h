//
//  EAPageConfig.h
//  EABook
//
//  Created by gdlab on 12/10/27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EALayer.h"

#define BTN_W 125
#define BTN_H 80

#define HOME_PATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Config.plist"]
#define KEY_VOLUME @"VolumeSwitch"
#define KEY_WORD @"WordSwitch"

@interface EAPageConfig : EALayer {
    
}
+(CCScene *) scene;
@property (retain, nonatomic) NSMutableDictionary *configContent;

- (void) selectTapSpriteForTouch:(CGPoint)touchLocation;
- (void) addObjects;

- (void) switchVolume;
- (void) switchWord;

- (NSMutableDictionary*) readConfig;

+ (BOOL) getVolumeState;
+ (BOOL) getWordState;
@end
