//
//  DRSeperatorView.m
//  DoradaCore
//
//  Created by Daniel Broad on 04/06/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import "DRSeparatorView.h"

@implementation DRSeparatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIColor* bottom = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0f];
    
    //// Frames
    CGRect frame = self.bounds;
    
    
    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame) - 0, 0.5)];
    [bottom setFill];
    [rectangle2Path fill];

}


@end
