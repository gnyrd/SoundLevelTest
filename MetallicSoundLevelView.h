//
//  MetallicSoundLevelView.h
//  Sound Level Test
//
//  Created by jeff ganyard on 9/5/06.
//  Copyright 2006 Bithaus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MetallicFrameView.h"

@class MetallicFrameView;

typedef enum thresholdTypes
{
	block	= 1,
	line	= 2,
} thresholdType;

@interface MetallicSoundLevelView : MetallicFrameView 
{
	NSColor *waveColor;
	NSNumber *threshold;
	NSMutableArray *sampleArray;
}

- (void)drawWaveWithRect:(NSRect)rect;
- (void)drawThresholdWithRect:(NSRect)rect withThresholdType:(thresholdType)type;

- (NSColor *)waveColor;
- (void)setWaveColor:(NSColor *)newWaveColor;

- (NSNumber *)threshold;
- (void)setThreshold:(NSNumber *)newThreshold;

- (NSNumber *)threshold;
- (void)setThreshold:(NSNumber *)newThreshold;

- (NSMutableArray *)sampleArray;
- (void)setSampleArray:(NSMutableArray *)newSampleArray;

- (void)addToSampleArray:(id)sampleArrayObject;
- (void)removeObjectFromSampleArrayAtIndex:(unsigned int)index;

- (unsigned int)countOfSampleArray;

@end
