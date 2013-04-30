//
//  MetalBorderView.h
//  Round Rect Gradient Test
//
//  Created by jeff ganyard on 9/4/06.
//  Copyright 2006 Bithaus. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MetallicFrameView : NSView 
{
	BOOL round;

	NSColor *screenColor;
	float cornerRadius;
	float frameWidth;
	NSRect contentFrame;
}

- (BOOL)round;
- (void)setRound:(BOOL)flag;

- (NSColor *)screenColor;
- (void)setScreenColor:(NSColor *)newScreenColor;

- (float)cornerRadius;
- (void)setCornerRadius:(float)newCornerRadius;

- (float)frameWidth;
- (void)setFrameWidth:(float)newFrameWidth;

- (NSRect)contentFrame;
- (void)setContentFrame:(NSRect)newContentFrame;

@end
