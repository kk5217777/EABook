//
//  EAPageMap.h
//  EABook
//
//  Created by Mac06 on 12/11/1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EALayer.h"
#import "EAPage0.h"
#import "EAPage2.h"
#import "EAPage1.h"
#import "EAPage3-1.h"
#import "EAPage3-2.h"
#import "EAPage3-3.h"
#import "EAPage4.h"
#import "EAPageMenu.h"

@interface EAPageMap : EALayer {
    int goToPage;
}
+(CCScene *) scene;
-(void) goToPage;
@end
