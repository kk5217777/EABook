//
//  GamePoint.h
//  traffic
//
//  Created by Mac04 on 12/10/23.
//  Copyright 2012年 國立台北教育大學. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GamePoint : CCNode {
    //A 公 Ｂ工程 Ｃ家用
    int typeA;
    int typeB;
    int typeC;
}

-(void) addTypeA;
-(void) addTypeB;
-(void) addTypeC;

-(NSString*) goToPage;
@end
