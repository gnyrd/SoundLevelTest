//
//  MetalBorderView.m
//  Round Rect Gradient Test
//
//  Created by jeff ganyard on 9/4/06.
//  Copyright 2006 Bithaus. All rights reserved.
//

#import "MetallicFrameView.h"
#import "NSBezierPath+RoundRects.h"

@implementation MetallicFrameView

- (void)drawRect:(NSRect)rect
{
	NSBezierPath *rectPath;
	NSBezierPath *innerPath;
	NSBezierPath *outerPath;
	NSBezierPath *contentPath;
	NSBezierPath *highlightPath;
	
	[self setCornerRadius:MIN(40.0, [self cornerRadius])];
	float firstInset = ([self frameWidth]/2) + 0.5;
	float outerRadius = [self cornerRadius] - firstInset;
	float secondInset = frameWidth - 4;
	float innerRadius = outerRadius - 2;
	
	NSRect targetRect = [self bounds];
	
	NSGraphicsContext *currentContext = [NSGraphicsContext currentContext];
	[currentContext saveGraphicsState];
	
	if ([self round]) {
		rectPath = [NSBezierPath bezierPathWithOvalInRect:targetRect];
		outerPath = [NSBezierPath  bezierPathWithOvalInRect:NSInsetRect(targetRect, 1.5, 1.5)];
		innerPath = [NSBezierPath bezierPathWithOvalInRect:NSInsetRect(targetRect, firstInset, firstInset)];
		contentPath = [NSBezierPath bezierPathWithOvalInRect:NSInsetRect(targetRect, secondInset, secondInset)];
		highlightPath = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(targetRect.origin.x, targetRect.origin.y+(targetRect.size.height/2), targetRect.size.width, targetRect.size.height/2)];
	} else {
		rectPath = [NSBezierPath bezierPathWithRoundRectInRect:targetRect radius:[self cornerRadius]];
		outerPath = [NSBezierPath bezierPathWithRoundRectInRect:NSInsetRect(targetRect, 1.5, 1.5) radius:[self cornerRadius]];
		innerPath = [NSBezierPath bezierPathWithRoundRectInRect:NSInsetRect(targetRect, firstInset, firstInset) radius:MAX(outerRadius, 5.0)];
		contentPath = [NSBezierPath bezierPathWithRoundRectInRect:NSInsetRect(targetRect, secondInset, secondInset) radius:MAX(innerRadius, 5.0)];
		highlightPath = [NSBezierPath bezierPathWithRoundRectInRect:NSMakeRect(targetRect.origin.x, targetRect.origin.y+(targetRect.size.height/2), targetRect.size.width, targetRect.size.height/2) radius:[self cornerRadius]];
	}
	
	[[NSColor darkGrayColor] set];
	[rectPath fill];
	
	[outerPath addClip];
	[[[NSGradient alloc] initWithStartingColor: [NSColor grayColor] endingColor:[NSColor colorWithDeviceWhite:0.99 alpha:1.0]] drawInRect:targetRect angle:92.0];
	
	[innerPath addClip];
	[[[NSGradient alloc] initWithStartingColor: [NSColor colorWithDeviceWhite:0.61 alpha:1.0] endingColor:[NSColor colorWithDeviceWhite:0.15 alpha:1.0]] drawInRect:targetRect angle:92.0];
	
	[contentPath addClip];
	[screenColor set];
	[contentPath fill];

	[highlightPath addClip];
	[[[NSGradient alloc] initWithStartingColor: [NSColor colorWithDeviceWhite:0.75 alpha:0.1] endingColor:[NSColor colorWithDeviceWhite:1.0 alpha:0.6]] drawInRect:targetRect angle:90];

	[currentContext restoreGraphicsState];
	
	// this isn't right, watch out for the corners on round rects and it's just plain wrong on round
	[self setContentFrame:NSInsetRect(targetRect, secondInset, secondInset)];
}



- (BOOL)round
{
    return round;
}
- (void)setRound:(BOOL)flag
{
    round = flag;
}

- (NSColor *)screenColor
{
    return screenColor; 
}
- (void)setScreenColor:(NSColor *)newScreenColor
{
    if (screenColor != newScreenColor) {
        screenColor = newScreenColor;
    }
}

- (float)cornerRadius
{
	return cornerRadius;
}
- (void)setCornerRadius:(float)newCornerRadius
{
	cornerRadius = newCornerRadius;
}

- (float)frameWidth
{
    return frameWidth;
}
- (void)setFrameWidth:(float)newFrameWidth
{
    frameWidth = newFrameWidth;
}

- (NSRect)contentFrame
{
    return contentFrame;
}
- (void)setContentFrame:(NSRect)newContentFrame
{
    contentFrame = newContentFrame;
}

@end