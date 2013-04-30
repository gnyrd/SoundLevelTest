//
//  SoundLevelController.m
//  Sound Level Test
//
//  Created by jeff ganyard on 9/5/06.
//  Copyright 2006 Bithaus. All rights reserved.
//

#import "SoundLevelController.h"
#import "MetallicSoundLevelView.h"

@implementation SoundLevelController

- (id)init
{
	self = [super initWithWindowNibName:@"SoundLevel"];

	if (!waveView)
		waveView = [[MetallicSoundLevelView alloc] init];
	if (!roundView)
		roundView = [[MetallicSoundLevelView alloc] init];
	
	return self;
}


- (void)awakeFromNib
{
	[waveView setThreshold:[NSNumber numberWithFloat:0.45]];
	[waveView setWaveColor:[NSColor whiteColor]];
	[waveView setScreenColor:[NSColor blueColor]];
//	[self seedSampleArray:[waveView frame]];

	[roundView setRound:YES];
	[roundView setThreshold:[NSNumber numberWithFloat:0.45]];
	[roundView setWaveColor:[NSColor greenColor]];
	[roundView setScreenColor:[NSColor blackColor]];
//	[self seedSampleArray:[roundView frame]];

	NSTimer *timer;
	
	timer = [NSTimer scheduledTimerWithTimeInterval: 0.03
											 target: self
										   selector: @selector(handleTimer:)
										   userInfo: nil
											repeats: YES];
	
}

- (void)handleTimer:(NSTimer *)timer
{
	float seed = ((float)random()/RAND_MAX);

	[waveView addToSampleArray:[NSNumber numberWithFloat:seed]];
	[roundView addToSampleArray:[NSNumber numberWithFloat:seed]];
}

- (void)seedSampleArray:(NSRect)rect;
{
	int i;
	for (i = 0; i < rect.size.width/2; i++) {
		[waveView addToSampleArray:[NSNumber numberWithFloat:((float)random()/RAND_MAX)]];
	}
}

@end
