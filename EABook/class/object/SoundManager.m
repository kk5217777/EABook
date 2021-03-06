//
//  SoundManager.m
//  EABook
//
//  Created by gdlab on 12/10/29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SoundManager.h"

@implementation SoundManager

-(void) playLoopSound:(NSString*) soundName
{
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],soundName]];
    
    NSLog(@"play loop");
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    if (audioPlayer) {
        audioPlayer.numberOfLoops = -1;
        [audioPlayer play];
    }
}

-(void) playSoundFile:(NSString*) soundName
{
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],soundName]];
    
    NSLog(@"sound play");
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    if (audioPlayer && !audioPlayer.isPlaying) {
        audioPlayer.numberOfLoops = 0;
        [audioPlayer play];
    }
}
//會switch ON and OFF
-(void) playWordSoundFile:(NSString*) soundName
{
    //切換互動狀態
    [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchInteraction)]];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],soundName]];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    if (audioPlayer) {
        audioPlayer.numberOfLoops = 0;
        [audioPlayer play];
        [self schedule:@selector(PlayWordSound:) interval:1];
    }
}

-(void) playSound
{
    if (audioPlayer && !audioPlayer.isPlaying) {
        [audioPlayer play];
    }
}

-(void) stopSound
{
    if (audioPlayer && audioPlayer.isPlaying) {
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
