//
//  DRSegmentedControl.m
//  DoradaCore
//
//  Created by Daniel Broad on 18/07/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import "DRSegmentedControl.h"

@implementation DRSegmentedControl {
    NSInteger _selectedSegment;
    BOOL _segmentSelected;
}

@synthesize delegate = __delegate;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSInteger previousSelectedSegmentIndex = self.selectedSegmentIndex;
    [super touchesEnded:touches withEvent:event];
    if (previousSelectedSegmentIndex != self.selectedSegmentIndex) {
        [self.delegate segmentedControl:self didSelectSection: self.selectedSegmentIndex];
        self.selectedSegmentIndex = UISegmentedControlNoSegment;
    }
}

@end