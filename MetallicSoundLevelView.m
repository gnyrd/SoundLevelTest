//
//  MetallicSoundLevelView.m
//  Sound Level Test
//
//  Created by jeff ganyard on 9/5/06.
//  Copyright 2006 Bithaus. All rights reserved.
//

#import "MetallicSoundLevelView.h"
#import "NSBezierPath+RoundRects.h"


@implementation MetallicSoundLevelView
/*
 - (id)init
 {
	 [super init];
	 
	 return self;
 }
 */
- (void)awakeFromNib
{
	[self setFrameWidth:10.0];

	if (![self cornerRadius])
		[self setCornerRadius:[self frame].size.height/6];
	if (![self screenColor])
		[self setScreenColor:[NSColor blackColor]];
	if (![self round])
		[self setRound:NO];
	if (![self sampleArray])
		[self setSampleArray:[NSMutableArray arrayWithCapacity:1]];
}

- (void)drawRect:(NSRect)rect
{
	
	NSBezierPath *rectPath;
	NSBezierPath *innerPath;
	NSBezierPath *outerPath;
	NSBezierPath *contentPath;
	NSBezierPath *highlightPath;
	
	[self setCornerRadius:MIN(40.0, [self cornerRadius])];
	float firstInset = 5.5;
	float outerRadius = [self cornerRadius] - firstInset;
	float secondInset = 7.5;
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
	[[[NSGradient alloc] initWithStartingColor: [NSColor colorWithDeviceWhite:0.71 alpha:1.0] endingColor:[NSColor colorWithDeviceWhite:0.15 alpha:1.0]] drawInRect:targetRect angle:92.0];
	
	[contentPath addClip];
	[screenColor set];
	[contentPath fill];

	[self setContentFrame:NSInsetRect(targetRect, secondInset, secondInset)];
	[self drawWaveWithRect:contentFrame];
	
	[highlightPath addClip];
	[[[NSGradient alloc] initWithStartingColor: [NSColor colorWithDeviceWhite:0.3 alpha:0.1] endingColor:[NSColor colorWithDeviceWhite:1.0 alpha:0.3]] drawInRect:targetRect angle:90];
	
	[currentContext restoreGraphicsState];	
}

- (void)drawWaveWithRect:(NSRect)rect;
{
	NSBezierPath *wave = [NSBezierPath bezierPath];
	[wave moveToPoint:NSMakePoint(rect.origin.x, rect.origin.y+rect.size.height/2)];
	if ([self countOfSampleArray] < 2 || [self sampleArray] == nil) {
		[wave lineToPoint:NSMakePoint(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height/2)];
	} else {
		// kinda ugly but it works
		int i;
		float baseline, y1, y2, x;
		float deltaX = rect.size.width/[self countOfSampleArray];
		baseline = rect.origin.y+rect.size.height/2;
		for (i = 0; i < [self countOfSampleArray]; i++) {
			x = rect.origin.x+((i+1)*deltaX);
			if ([sampleArray objectAtIndex:i] > 0) {
				NSNumber *item = [sampleArray objectAtIndex:i];
				y1 = baseline + (rect.size.height*[item floatValue]/2 - 2);
				y2 = baseline - (rect.size.height*[item floatValue]/2 - 2);
				[wave lineToPoint:NSMakePoint(x, baseline)]; // along baseline
				[wave moveToPoint:NSMakePoint(x, y1)]; // above baseline
				[wave lineToPoint:NSMakePoint(x, y2)]; // below baseline
				[wave moveToPoint:NSMakePoint(x, baseline)]; // finish at baseline
			} else {
				[wave lineToPoint:NSMakePoint(x, baseline)]; // along baseline
			}
		}
		[wave lineToPoint:NSMakePoint(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height/2)]; // finish it off
	}
	[wave setLineWidth:1.0];
	[waveColor set];
	[wave stroke];
	
	[self drawThresholdWithRect:rect withThresholdType:block];	
}

- (void)drawThresholdWithRect:(NSRect)rect withThresholdType:(thresholdType)type
{
	float threshVal = 1 - [[self threshold] floatValue];
	float threshPos = rect.size.height/2*threshVal;
	float upperPos = rect.origin.y+(rect.size.height/2)+threshPos;
	float lowerPos = rect.origin.y+(rect.size.height/2)-threshPos;
	
	if (type == block) {
		NSBezierPath *threshBlock = [NSBezierPath bezierPathWithRect:NSInsetRect(rect, 0, threshPos)];
		//[[[self screenColor] colorWithAlphaComponent:0.3] set];
		[[NSColor colorWithCalibratedWhite:0.0 alpha:0.55] set];
		[threshBlock fill];
	} else {
		NSBezierPath *threshLine = [NSBezierPath bezierPath];
		[threshLine moveToPoint:NSMakePoint(rect.origin.x, upperPos)];
		[threshLine lineToPoint:NSMakePoint(rect.origin.x+rect.size.width, upperPos)];
		[threshLine moveToPoint:NSMakePoint(rect.origin.x, lowerPos)];
		[threshLine lineToPoint:NSMakePoint(rect.origin.x+rect.size.width, lowerPos)];
		
		//[[NSColor colorWithDeviceRed:0.2 green:0.2 blue:0.2 alpha:0.4] set];
		[threshLine setLineWidth:1.5];
		[threshLine stroke];
	}
}


- (NSColor *)waveColor
{
	return waveColor; 
}
- (void)setWaveColor:(NSColor *)newWaveColor
{
	if (waveColor != newWaveColor) {
		waveColor = newWaveColor;
	}
}

- (NSNumber *)threshold
{
	return threshold; 
}

- (void)setThreshold:(NSNumber *)newThreshold
{
	if (threshold != newThreshold) {
		threshold = newThreshold;
	}
}

- (NSMutableArray *)sampleArray
{
	return sampleArray; 
}

- (void)setSampleArray:(NSMutableArray *)newSampleArray
{
	if (sampleArray != newSampleArray) {
		sampleArray = newSampleArray;
	}
}

- (void)addToSampleArray:(id)sampleArrayObject
{
	[[self sampleArray] addObject:sampleArrayObject];
	if ([self countOfSampleArray] > floor([self frame].size.width/2))
		[[self sampleArray] removeObjectsInRange:NSMakeRange(0, ([self countOfSampleArray] - floor([self frame].size.width/2)))];
	[self setNeedsDisplay:YES];
}

- (void)removeObjectFromSampleArrayAtIndex:(unsigned int)index;
{
	[[self sampleArray] removeObjectAtIndex:index];
}

- (unsigned int)countOfSampleArray 
{
	return [[self sampleArray] count];
}

@end
