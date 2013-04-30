//
//  AppController.h
//  Sound Level Test
//
//  Created by jeff ganyard on 9/5/06.
//  Copyright 2006 Bithaus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SoundLevelController;

@interface AppController : NSObject 
{
	SoundLevelController *soundLevelController;
}

- (IBAction)showSoundLevel:(id)sender;

@end
