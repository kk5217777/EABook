//
//  EAPage0.h
//  EABook
//
//  Created by Mac04 on 12/11/2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EALayer.h"

#import "EAPageMenu.h"
#import "EAPage1.h"
#import "MotionSensorIce.h"

@interface EAPage0 : EALayer {
    EAAnimSprite *Taxi;
    EAAnimSprite *ThreeCar;
    EAAnimSprite *Cat;
    EAAnimSprite *Dog;
    CGRect temp;
    int selectedMoveSprite;
    BOOL eggEnable;
    
    NSString *soundFile;
}
+(CCScene *) scene;
@end
