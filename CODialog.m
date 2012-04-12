//
//  CODialog.m
//  CODialog
//
//  Created by Erik Aigner on 10.04.12.
//  Copyright (c) 2012 chocomoko.com. All rights reserved.
//

#import "CODialog.h"


@interface CODialog ()
@property (nonatomic, strong) UIView *hostView;
@end

#define Synth(x) @synthesize x = x##_;

@implementation CODialog
Synth(customView)
Synth(dialogStyle)
Synth(title)
Synth(subtitle)
Synth(batchDelay)
Synth(hostView)

+ (instancetype)dialogWithView:(UIView *)hostView {
  return [[self alloc] initWithView:hostView];
}

- (id)initWithView:(UIView *)hostView {
  self = [super initWithFrame:CGRectIntegral(CGRectInset(hostView.bounds, 30.0, 30.0))];
  if (self) {
    self.hostView = hostView;
    self.opaque = NO;
    self.alpha = 1.0;
  }
  return self;
}

- (void)showOrUpdateAnimated:(BOOL)flag {
  [self.hostView addSubview:self];
}

- (void)hideAnimated:(BOOL)flag {
  
}

- (void)hideAnimated:(BOOL)flag afterDelay:(NSTimeInterval)delay {
  
}

- (void)drawDialogBackgroundInRect:(CGRect)rect {
  // General Declarations
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  // Set alpha
  CGContextSaveGState(context);
  CGContextSetAlpha(context, 0.65);
  
  // Color Declarations
  UIColor *color = [UIColor colorWithRed:0.047 green:0.141 blue:0.329 alpha:1.0];
  
  // Gradient Declarations
  NSArray *gradientColors = [NSArray arrayWithObjects: 
                              (id)[UIColor colorWithWhite:1.0 alpha:0.75].CGColor, 
                              (id)[UIColor colorWithRed:0.227 green:0.310 blue:0.455 alpha:0.8].CGColor, nil];
  CGFloat gradientLocations[] = {0, 1};
  CGGradientRef gradient2 = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
  
  // Abstracted Graphic Attributes
  CGFloat cornerRadius = 8.0;
  CGFloat strokeWidth = 2.0;
  CGColorRef dialogShadow = [UIColor blackColor].CGColor;
  CGSize shadowOffset = CGSizeMake(0, 4);
  CGFloat shadowBlurRadius = 6;
  
  CGFloat frameInset = shadowBlurRadius + 2;
  CGRect frame = CGRectInset(CGRectIntegral(self.bounds), frameInset, frameInset);
  
  // Rounded Rectangle Drawing
  UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:cornerRadius];
  
  CGContextSaveGState(context);
  CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, dialogShadow);
  
  [color setFill];
  [roundedRectanglePath fill];
  
  CGContextRestoreGState(context);
  
  // Set clip path
  [roundedRectanglePath addClip];
  
  // Bezier Drawing
  CGFloat mx = CGRectGetMinX(frame);
  CGFloat my = CGRectGetMinY(frame);
  CGFloat w = CGRectGetWidth(frame);
  CGFloat w2 = w / 2.0;
  CGFloat w4 = w / 4.0;
  CGFloat h1 = 25;
  CGFloat h2 = 35;
  
  UIBezierPath *bezierPath = [UIBezierPath bezierPath];
  [bezierPath moveToPoint:CGPointMake(mx, h1)];
  [bezierPath addCurveToPoint:CGPointMake(mx + w2, h2) controlPoint1:CGPointMake(mx, h1) controlPoint2:CGPointMake(mx + w4, h2)];
  [bezierPath addCurveToPoint:CGPointMake(mx + w, h1) controlPoint1:CGPointMake(mx + w2 + w4, h2) controlPoint2:CGPointMake(mx + w, h1)];
  [bezierPath addCurveToPoint:CGPointMake(mx + w, my) controlPoint1:CGPointMake(mx + w, h1) controlPoint2:CGPointMake(mx + w, my)];
  [bezierPath addCurveToPoint:CGPointMake(mx, my) controlPoint1:CGPointMake(mx + w, my) controlPoint2:CGPointMake(mx, my)];
  [bezierPath addLineToPoint:CGPointMake(mx, h1)];
  [bezierPath closePath];
  
  CGContextSaveGState(context);
  
  [bezierPath addClip];
  
  CGContextDrawLinearGradient(context, gradient2, CGPointMake(w2, 0), CGPointMake(w2, h2), 0);
  CGContextRestoreGState(context);
  
  // Stroke
  [[UIColor whiteColor] setStroke];  
  UIBezierPath *strokePath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(frame, strokeWidth / 2.0, strokeWidth / 2.0)
                                                        cornerRadius:cornerRadius - strokeWidth / 2.0];
  strokePath.lineWidth = strokeWidth;
  
  [strokePath stroke];
  
  // Cleanup
  CGGradientRelease(gradient2);
  CGColorSpaceRelease(colorSpace);
  CGContextRestoreGState(context);
}

- (void)drawButtonInRect:(CGRect)rect highlighted:(BOOL)highlighted down:(BOOL)down {
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGContextSaveGState(ctx);
  
  CGFloat radius = 4.0;
  CGFloat strokeWidth = 1.0;
  
  CGRect frame = CGRectIntegral(rect);
  CGRect buttonFrame = CGRectInset(frame, 0, 1);
  
  // Color declarations
  UIColor* whiteTop = [UIColor colorWithWhite:1.0 alpha:0.35];
  UIColor* whiteMiddle = [UIColor colorWithWhite:1.0 alpha:0.10];
  UIColor* whiteBottom = [UIColor colorWithWhite:1.0 alpha:0.0];
  
  // Gradient declarations
  NSArray* gradientColors = [NSArray arrayWithObjects: 
                              (id)whiteTop.CGColor, 
                              (id)whiteMiddle.CGColor, 
                              (id)whiteBottom.CGColor, 
                              (id)whiteBottom.CGColor, nil];
  CGFloat gradientLocations[] = {0, 0.5, 0.5, 1};
  
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
  CGColorSpaceRelease(colorSpace);
  
  // Bottom shadow
  UIBezierPath *fillPath = [UIBezierPath bezierPathWithRoundedRect:buttonFrame cornerRadius:radius];
  
  UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:frame];
  [clipPath appendPath:fillPath];
  [clipPath setUsesEvenOddFillRule:YES];
  
  CGContextSaveGState(ctx);
  
  [clipPath addClip];
  [[UIColor blackColor] setFill];
  
  CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 0, [UIColor colorWithWhite:1.0 alpha:0.25].CGColor);
  
  [fillPath fill];
  
  CGContextRestoreGState(ctx);
  
  // Top shadow
  CGContextSaveGState(ctx);
  
  [fillPath addClip];
  [[UIColor blackColor] setFill];
  
  CGContextSetShadowWithColor(ctx, CGSizeMake(0, 2), 0, [UIColor colorWithWhite:1.0 alpha:0.25].CGColor);
  
  [clipPath fill];
  
  CGContextRestoreGState(ctx);
  
  // Button gradient
  CGContextSaveGState(ctx);
  [fillPath addClip];
  
  CGContextDrawLinearGradient(ctx,
                              gradient,
                              CGPointMake(CGRectGetMidX(buttonFrame), CGRectGetMinY(buttonFrame)),
                              CGPointMake(CGRectGetMidX(buttonFrame), CGRectGetMaxY(buttonFrame)), 0);
  CGContextRestoreGState(ctx);
  
  // Draw highlight
  if (highlighted) {
    CGContextSaveGState(ctx);
    
    [[UIColor colorWithWhite:1.0 alpha:0.25] setFill];
    [fillPath fill];
    
    CGContextRestoreGState(ctx);
  }
  
  // Button stroke
  UIBezierPath *strokePath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(buttonFrame, strokeWidth / 2.0, strokeWidth / 2.0)
                                                        cornerRadius:radius - strokeWidth / 2.0];
  
  [[UIColor colorWithWhite:0.0 alpha:0.8] setStroke];
  [strokePath stroke];
  
  // Restore
  CGContextRestoreGState(ctx);
}

- (void)drawRect:(CGRect)rect {
  [self drawDialogBackgroundInRect:rect];
  
  // TODO: remove
  CGRect bframe = CGRectMake(20, CGRectGetHeight(rect) - 44.0 - 20.0, 100, 44.0);
  [self drawButtonInRect:bframe highlighted:NO down:NO];
  
  CGRect bframe2 = CGRectOffset(bframe, CGRectGetWidth(bframe) + 20.0, 0);
  [self drawButtonInRect:bframe2 highlighted:YES down:NO];
}

@end
