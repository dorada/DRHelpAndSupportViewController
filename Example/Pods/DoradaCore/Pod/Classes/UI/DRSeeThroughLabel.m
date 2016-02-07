//
//  DRSeeThroughLabel.m
//  DoradaCore
//
//  Created by Daniel Broad on 02/06/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import "DRSeeThroughLabel.h"
#import <CoreText/CoreText.h>
#import "UIBezierPath+TextPaths.h"

@implementation DRSeeThroughLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(void)drawRect:(CGRect)rect {
    CGContextRef        ctx = UIGraphicsGetCurrentContext();

    UIBezierPath *text = [UIBezierPath pathFromMultilineString:self.text WithFont:self.font maxWidth:self.bounds.size.width];
    
    CGContextSaveGState(ctx);
    
    CGAffineTransform flipVertical = CGAffineTransformMake(
                                                           1, 0, 0, -1, 0, self.frame.size.height
                                                           );
    CGContextConcatCTM(ctx, flipVertical);
    
    CGRect textBounds = [text bounds];
    CGAffineTransform transform = CGAffineTransformMakeTranslation((self.bounds.size.width-textBounds.size.width)/2, (self.bounds.size.height-textBounds.size.height)/2);
    [text applyTransform: transform];
    
    CGContextAddPath(ctx, text.CGPath);
    CGContextClip(ctx);
    [self.textImage drawInRect:CGRectMake(0-self.frame.origin.x, 0-self.frame.origin.y, self.textImage.size.width, self.textImage.size.height)];
    CGContextRestoreGState(ctx);
    
}


@end
