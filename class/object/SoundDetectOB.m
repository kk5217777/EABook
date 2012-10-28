//
//  SoundDetectOB.m
//  EBook ClickAnimate
//
//  Created by gdlab on 12/8/15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SoundDetectOB.h"

BOOL flag=TRUE;
BOOL wordsoundflag = TRUE;
float wordsoundseconds = 0;
float playseconds =0;
@implementation SoundDetectOB
@synthesize fileName,soundfileName,wordsoundfileName,wordimagefileName,cartype;
@synthesize imgNum;
@synthesize delayTime;

+ (id)spriteWithName:(NSString*)name{
    
    SoundDetectOB* sprite = [[[self alloc] initWithName:name] autorelease];
    return sprite;
}

-(id)initWithName:(NSString*)name
{
    fileName = name;
    
    if (self = [super initWithSpriteFrameName:[NSString stringWithFormat:@"%@_%d.png",fileName,0]]) {
        //fileType = @".png";
        //NSLog(@"fileName-------%@",fileName);
        imgNum = 0;
        delayTime = 0.3f;
        cartype =nil;
        soundfileName = nil;
        wordimagefileName = nil;
        soundEffectID = 0;
        audioPlayer = Nil;
    }
    return self;
}

- (void) dealloc
{
    //[self.fileName dealloc];//sent to object may be referenced elsewhere
	[super dealloc];
}

- (void) load
{
    for (int i = 0; i < imgNum; i++)
    {
        NSString* name;
        //生成文件名bg_0.png ~ bg_3.png
        if(i < 10)
        {
            name = [NSString stringWithFormat:@"%@0%d.png", fileName, i];
        }
        else {
            name = [NSString stringWithFormat:@"%@%d.png", fileName, i];
        }
        CCTexture2D *texture  =  [[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:name,i]];
        CGSize texSize = texture.contentSize;
        CGRect texRect = CGRectMake(0, 0, texSize.width, texSize.height);
        CCSpriteFrame* frame = [CCSpriteFrame frameWithTexture:texture rect:texRect];
        
        //将frame加入内存池
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFrame:frame name:[name stringByDeletingPathExtension]];
    }
}
- (void) animation
{
    NSMutableArray* array = [NSMutableArray array];
    CCAnimate *actLion = NULL;
    //生成背景图动画，共5帧
    if (flag ) {
        flag = FALSE;
        
        for (int i = 1; i < imgNum; i++)
        {
            NSString* key;
            if (i < 10) {
                key = [NSString stringWithFormat:@"%@0%d",fileName, i];
            }
            else {
                key = [NSString stringWithFormat:@"%@%d",fileName, i];
            }
            
            //从内存池中取出Frame
            CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:key];
            //添加到序列中
            [array addObject:frame];
        }
        
        //将数组转化为动画序列,换帧间隔0.1
        CCAnimation* animLion = [CCAnimation animationWithFrames:array delay:delayTime];
        //生成动画播放的行为对象
        actLion = [CCAnimate actionWithAnimation:animLion];
        //清空缓存数组
        [array removeAllObjects];
        
        [self runAction:actLion];
    }
    if([actLion isDone])
        flag = TRUE;
    
}

-(void) makeanimation{
    CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
    //[cache addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist",fileName]];

    
    NSMutableArray *frames =[[NSMutableArray array] retain];
    CCAnimate *actLion = NULL;
    for (int i=0; i<imgNum; i++) {
        NSString *FrameName =[NSString stringWithFormat:@"%@_%d.png",fileName,i];
        CCSpriteFrame *frame = [cache spriteFrameByName:FrameName];
        [frames addObject:frame];
    }
    
    CCAnimation *walkAnim =[CCAnimation animationWithFrames:frames delay:delayTime];
   
    actLion = [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:YES];
    //actLion = [CCRepeat actionWithAction:actLion times:5];
    [self runAction:actLion];
    //CCTexture2D * texture =[[CCTextureCache sharedTextureCache] addImage: [NSString stringWithFormat:@"%@_%d.png",fileName,0]];//新建贴图
    //UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%d.png",fileName,0]];

    //NSLog(@"%@",texture.debugDescription);
    //[self setTexture:texture];

    [frames removeAllObjects];
    [frames release];
    
    //printf("\nadd event");
    //[[NSNotificationCenter defaultCenter] postNotificationName:WORD_STOP object:self];
}
-(void) animationForever{
    CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
    //[cache addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist",fileName]];
    
    
    NSMutableArray *frames =[[NSMutableArray array]retain];
    CCAnimate *actLion = NULL;
    for (int i=1; i<imgNum; i++) {
        NSString *FrameName =[NSString stringWithFormat:@"%@_%d.png",fileName,i];
        CCSpriteFrame *frame = [cache spriteFrameByName:FrameName];
        [frames addObject:frame];
    }
    
    CCAnimation *walkAnim =[CCAnimation animationWithFrames:frames delay:delayTime];
    
    //actLion = [CCAnimate actionWithAnimation:walkAnim];
    actLion = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
    
    [self runAction:actLion];
    //CCTexture2D * texture =[[CCTextureCache sharedTextureCache] addImage: [NSString stringWithFormat:@"%@_%d.png",fileName,0]];//新建贴图
    //[self setTexture:texture];
    
    [frames removeAllObjects];
    [frames release];
}
/*
-(void) addSoundEffect{
    SimpleAudioEngine *sae=[SimpleAudioEngine sharedEngine];
    
    [[CDAudioManager sharedManager]setResignBehavior:kAMRBStopPlay autoHandle:YES];
    
    [sae preloadEffect:soundfileName];
    
    soundEffectID=[sae playEffect:soundfileName];
    
    
}
-(void) stopSoundEffect{
    if (soundEffectID) {
        printf("stop Sount Effiect");
        [[SimpleAudioEngine sharedEngine]stopEffect:soundEffectID];
    }
    else
    {
        printf("no Sount Effiect stoped");
    }
}
 */
-(void) addWordSoundEffect{
    
    if (audioPlayer == Nil) {

    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],wordsoundfileName]];
    
    
        NSLog(@"play");
        wordsoundflag = FALSE;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        audioPlayer.numberOfLoops = 0;
        [audioPlayer play];
        [self schedule:@selector(PlayWordSound:) interval:1];
        //[self addWordImage];
        [url release];
    }
    //[audioPlayer play];
    //[self addWordImage];
    
    //[self schedule:@selector(PlayWordSound:) interval:1];
    
}
-(void) stopWordSoundEffect{
    [audioPlayer stop];
    audioPlayer = Nil;
}
-(CCSprite *) addWordImage{
    
    wordimage = [[CCSprite alloc]initWithFile:wordimagefileName];
    return wordimage;
}
-(void) removeWordImage{
    [self removeChild:wordimage cleanup:YES];
}
-(void) PlayWordSound:(ccTime)dt{
    
    isplaydone=[audioPlayer isPlaying];
    if (!isplaydone) {
        printf("\nplaydone");
        //[self removeWordImage];
        [self unschedule:@selector(PlayWordSound:)];
        wordsoundflag = TRUE;
        audioPlayer = Nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:WORD_STOP object:self];
    }
    
}


@end
