//
//  SoundLevelController.h
//  Sound Level Test
//
//  Created by jeff ganyard on 9/5/06.
//  Copyright 2006 Bithaus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MetallicSoundLevelView;

@interface SoundLevelController : NSWindowController 
{
	IBOutlet MetallicSoundLevelView *waveView;
	IBOutlet MetallicSoundLevelView *roundView;
}

- (void)seedSampleArray:(NSRect)rect;

@end
