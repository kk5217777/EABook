//
//  EAPageGame1.h
//  EABook
//
//  Created by gdlab on 12/10/31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EALayer.h"
#import "EAPage3-1.h"
#import "EAPage3-2.h"
#import "EAPage3-3.h"
#import "EAPage4.h"
#import "MySprite.h"
#import "Box.h"

@interface EAPageGame1 : EALayer {
    Box *box;
    MySprite *selsprite;
	Tile *selectedTile;
    CCSprite *MenuImage;
    CCSprite *destimage;
    CCSprite *PrePage;
    CCSprite *background;
    CCSprite *wordimage;
    CCSprite *gamewin;
    CCSprite *NextRoundBtn;
    CCSprite *ExitBtn;
    CCSprite *AgainBtn;
    
    
    BOOL tt ;
    BOOL isReturn;
    int nowvalue;
	int count;
    int countTime;
}
+(CCScene *) scene;
@end
