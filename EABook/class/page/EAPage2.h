//
//  EAPage2.h
//  EABook
//
//  Created by gdlab on 12/10/27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EALayer.h"
#import "EAAnimSprite.h"

@interface EAPage2 : EALayer {
    EAAnimSprite *animSprite;
    EAAnimSprite *horse;
    EAAnimSprite *sheep;
    EAAnimSprite *zibber;
    EAAnimSprite *windmil;
}

+(CCScene *) scene;
@end
