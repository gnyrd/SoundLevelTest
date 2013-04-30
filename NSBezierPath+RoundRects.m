//
//  NSBezierPath+RoundRects.m
//  Text Access
//
//  Created by Jeff Ganyard on 3/24/06.
//  Copyright 2006 Bithaus. All rights reserved.
//

#import "NSBezierPath+RoundRects.h"


@implementation NSBezierPath(RoundedRectangle)

+ (NSBezierPath *)bezierPathWithRoundRectInRect:(NSRect)newRect radius:(float)radius
{
	return [NSBezierPath bezierPathWithRoundRectInRect:newRect radius:radius inCorners:topLeftCorner | topRightCorner | bottomLeftCorner | bottomRightCorner];
}

+ (NSBezierPath *)bezierPathWithRoundRectInRect:(NSRect)newRect radius:(float)radius inCorners:(cornerType)corners
{
	NSBezierPath* path = [self bezierPath];
    if (!NSIsEmptyRect(newRect)) {
		if (radius > 0.0) {
			radius = MIN(radius, 0.5f * MIN(NSWidth(newRect), NSHeight(newRect)));
			NSRect rect = NSInsetRect(newRect, radius, radius);
			
			if (corners & bottomLeftCorner) {
				[path appendBezierPathWithArcWithCenter:NSMakePoint(NSMinX(rect), NSMinY(rect)) radius:radius startAngle:180.0 endAngle:270.0];
			} else {
				NSPoint cornerPoint = NSMakePoint(NSMinX(newRect), NSMinY(newRect));
				[path appendBezierPathWithPoints:&cornerPoint count:1];
			}
			
			if (corners & bottomRightCorner) {
				[path appendBezierPathWithArcWithCenter:NSMakePoint(NSMaxX(rect), NSMinY(rect)) radius:radius startAngle:270.0 endAngle:360.0];
			} else {
				NSPoint cornerPoint = NSMakePoint(NSMaxX(newRect), NSMinY(newRect));
				[path appendBezierPathWithPoints:&cornerPoint count:1];
			}
			
			if (corners & topRightCorner) {
				[path appendBezierPathWithArcWithCenter:NSMakePoint(NSMaxX(rect), NSMaxY(rect)) radius:radius startAngle:  0.0 endAngle: 90.0];
			} else {
				NSPoint cornerPoint = NSMakePoint(NSMaxX(newRect), NSMaxY(newRect));
				[path appendBezierPathWithPoints:&cornerPoint count:1];
			}
			
			if (corners & topLeftCorner) {
				[path appendBezierPathWithArcWithCenter:NSMakePoint(NSMinX(rect), NSMaxY(rect)) radius:radius startAngle: 90.0 endAngle:180.0];
			} else {
				NSPoint cornerPoint = NSMakePoint(NSMinX(newRect), NSMaxY(newRect));
				[path appendBezierPathWithPoints:&cornerPoint count:1];
			}
			[path closePath];
		} else {
			// radius == 0.0 no rounding needed
			[path appendBezierPathWithRect:newRect];
		}		
	}
	return path;	
}
@end
