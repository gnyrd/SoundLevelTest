//
//  AppController.m
//  Sound Level Test
//
//  Created by jeff ganyard on 9/5/06.
//  Copyright 2006 Bithaus. All rights reserved.
//

#import "AppController.h"
#import "SoundLevelController.h"


@implementation AppController

- (IBAction)showSoundLevel:(id)sender;
{
	if (!soundLevelController) {
		soundLevelController = [[SoundLevelController alloc] init];
	}
	[soundLevelController showWindow:self];
}


@end
