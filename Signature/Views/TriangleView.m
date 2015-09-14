//
//  TriangleView.m
//  Signature
//
//  Created by Michael Fellows on 9/14/15.
//  Copyright (c) 2015 Broadway Lab, Inc. All rights reserved.
//

#import "TriangleView.h"
#import "UIColor+SigColors.h"

@implementation TriangleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // mid right
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));  // bottom left
    CGContextClosePath(ctx);
    
    CGContextAddArcToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMidX(rect), CGRectGetMaxY(rect), 5.0f);
    
//    CGContextSetLineWidth(ctx, 0.5f);
//    CGContextSetRGBStrokeColor(ctx, 199.0f / 255.0f, 199.0f / 255.0f, 204.0f / 255.0f, 1.0f);
    CGContextSetRGBFillColor(ctx, 247.0f / 255.0f, 247.0f / 255.0f, 247.0f / 255.0f, 1.0f);
    CGContextFillPath(ctx);
}

@end
