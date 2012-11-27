//
//  EAPageGame2.h
//  EABook
//
//  Created by gdlab on 12/10/31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EALayer.h"
#import "EAPage4.h"
#import "EAPageEnd.h"
#import "CCSpriteFloodFill.h"
#import "EAPageEnd.h"
#import "DrawGallery.h"
#import "ShowImg.h"
#import "FileOps.h"

@interface EAPageGame2 : EALayer {
    CCSpriteFloodFill * sprite;
	ccColor4B Colors[9];
    NSArray *cavas;
    
    BOOL drawAble;
    NSInteger canvasImageNum;
    NSUInteger SelectedCrayon;
    
    DrawGallery *gallery;
    ShowImg *imageShow;
    NSMutableArray *tapArray;
    FileOps *fileMgr;
}
+(CCScene *) scene;
@end
