//
//  EAAnimSprite.h
//  EbookAnimal
//
//  Created by gdlab on 12/10/26.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <AVFoundation/AVFoundation.h>

@interface EAAnimSprite : CCSprite {
    @public
    NSString *imageName;
    NSString *soundName;
    NSString *wordsoundName;
    NSString *wordimageName;
    NSInteger imgNum;
    
    @protected
    unsigned int soundEffectID;
    unsigned int wordsoundEffectID;
    float delayTime;
    NSMutableArray *animImageFrames;
    CCAnimation *animate;
    
}

@property(nonatomic, retain)NSString *imageName,*soundName,*wordsoundName,*wordimageName;
@property(nonatomic, readwrite)NSInteger imgNum;
@property(nonatomic, readwrite)float delayTime;

+ (id)spriteWithName:(NSString*)name;
- (id)initWithName:(NSString*)name;

-(void) startAnimation;
-(void) startLoopAnimation;

@end
