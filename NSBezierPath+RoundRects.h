//
//  NSBezierPath+RoundRects.h
//  Text Access
//
//  Created by Jeff Ganyard on 3/24/06.
//  Copyright 2006 Bithaus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum cornerTypes
{
	topLeftCorner	  = 1,
	bottomLeftCorner  = 2,
	topRightCorner	  = 4,
	bottomRightCorner = 8
} cornerType;

@interface NSBezierPath(RoundedRectangle)

+ (NSBezierPath *)bezierPathWithRoundRectInRect:(NSRect)newRect radius:(float)radius;
+ (NSBezierPath *)bezierPathWithRoundRectInRect:(NSRect)newRect radius:(float)radius inCorners:(cornerType)corners;

@end
