//
//  EAPage1.h
//  EABook
//
//  Created by gdlab on 12/10/27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EALayer.h"

#import "EAPageMenu.h"
#import "EAPage2.h"

@interface EAPage1 : EALayer {
    EAAnimSprite *egg;
    EAAnimSprite *chicken;
    EAAnimSprite *pig;
    EAAnimSprite *cow;
    
    BOOL eggEnable;
}
+(CCScene *) scene;
@end
