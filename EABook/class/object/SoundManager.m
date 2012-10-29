//
//  SoundManager.m
//  EABook
//
//  Created by gdlab on 12/10/29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SoundManager.h"

@implementation SoundManager

-(void) playSoundFile:(NSString*) soundName;
{
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],soundName]];
    
    NSLog(@"play");
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPlayer.numberOfLoops = 0;
    [audioPlayer play];
    //[self schedule:@selector(PlayWordSound:) interval:1];
    [url release];
}

-(void) playWordSoundFile:(NSString*) soundName
{
    //切換互動狀態
    [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchInteraction)]];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],soundName]];
    
    NSLog(@"play");
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPlayer.numberOfLoops = 0;
    [audioPlayer play];
    [self schedule:@selector(PlayWordSound:) interval:1];
    [url release];
}

-(void) stopSound
{
    if (audioPlayer) {
        [audioPlayer stop];
    }
}

-(void) PlayWordSound:(ccTime)dt{
    
    if (![audioPlayer isPlaying]) {
        printf("\nplaydone");
        [self unschedule:@selector(PlayWordSound:)];
        audioPlayer = Nil;
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:WORD_STOP object:self];
        //切換互動狀態
        [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchInteraction)]];
    }
}

-(void) dealloc
{
    [super dealloc];
    [audioPlayer dealloc];
}

@end
