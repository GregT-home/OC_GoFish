//
//  customView.m
//  Spike_CollectionView
//
//  Created by Greg Tarsa on 2/3/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "SmileyFaceView.h"

@implementation SmileyFaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor greenColor];
        // this forces the face to be redrawn whenever bounds change, like when display is rotated.
        self.layer.needsDisplayOnBoundsChange = YES;
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();

    [[UIColor blueColor] setFill];

    // make a smaller rectangle in the view
    CGRect insetRectangle = [self insetSquare:rect by:50.0];
    

    // from 2/4 class: do some CTM transforms
#if 0
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, +200, +120);
    CGContextScaleCTM(context, .25, .25);
    CGContextRotateCTM(context, -M_PI/10);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:insetRectangle];
    [path fill];
    CGContextRestoreGState(context);
#endif
    
    [self fillBackground:context in:insetRectangle];

    // do a similar refactor for forerounnd (fill + stroke in same method)
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    [self drawEyes:insetRectangle context:context];
    [self DrawMouth:insetRectangle context:context];
    
}

- (void)fillBackground:(CGContextRef)context in:(CGRect)rectangle {
    [[UIColor purpleColor] setFill];
    CGContextFillRect(context, rectangle);
    CGContextFillRect(context, rectangle);
}

//- (CGRect) insetRectangle:(CGRect)rectangle by:(CGFloat)inset{
//    return CGRectMake(rectangle.origin.x + inset,
//                      rectangle.origin.y + inset,
//                      rectangle.size.width - inset * 2.0,
//                      rectangle.size.height - inset * 2.0
//                      );
//    
//}
- (CGRect) insetSquare:(CGRect)rectangle by:(CGFloat)inset{
    CGFloat insetX = inset;
    CGFloat insetY = inset;
    CGFloat size = 0;

    if (rectangle.size.width > rectangle.size.height) {
        insetX = insetX + (rectangle.size.width - rectangle.size.height) / 2.0;
        size = rectangle.size.height  - inset * 2;
    }
    else {
        insetY = insetY + (rectangle.size.height - rectangle.size.width) / 2.0;
        size = rectangle.size.width   - inset * 2;
        
    }
//    return CGRectMake(rectangle.origin.x + inset,
//                      rectangle.origin.y + inset,
//                      rectangle.size.width - inset * 2.0,
//                      rectangle.size.height - inset * 2.0
//                      );
    return (CGRectMake(rectangle.origin.x + insetX, rectangle.origin.y + insetY, size, size));
    
}


- (void)drawEyes:(CGRect)rectangle context:(CGContextRef)context
{
    
    CGFloat eyeSize = 30.;
    CGFloat centerX = rectangle.origin.x + (rectangle.size.width - eyeSize)/ 2;
    CGFloat centerY = rectangle.origin.y + (rectangle.size.height - eyeSize) / 2;
    
    CGRect leftEyeRectangle = (CGRect){centerX - eyeSize * 2, centerY - eyeSize * 2, eyeSize, eyeSize};
    CGContextFillEllipseInRect(context, leftEyeRectangle);
    
    CGRect rightEyeRectangle = (CGRect){centerX + eyeSize * 2, centerY - eyeSize * 2, eyeSize, eyeSize};
    CGContextFillEllipseInRect(context, rightEyeRectangle);
}


#define degrees(a) a*(M_PI/180)
- (void)DrawMouth:(CGRect)rectangle context:(CGContextRef)context {
    CGFloat centerX = rectangle.origin.x + rectangle.size.width / 2;
    CGFloat centerY = rectangle.origin.y + rectangle.size.height / 2;
    
    // draw the mouth
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddArc(path, NULL,            // path, transform
                 centerX, centerY,      // center
                 100.00,                // radius
                 degrees(160), degrees(20), //3pm is 0 deg
                 YES);                  // clockwise
    
    CGContextSetLineWidth(context, 15.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextAddPath(context, path);
    //    CGContextDrawPath(context, kCGPathEOFillStroke);
    CGContextDrawPath(context, kCGPathStroke);
}



@end
