//
//  DRSegmentedControl.h
//  DoradaCore
//
//  Created by Daniel Broad on 18/07/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRSegmentedControl;

@protocol DRSegmentedControlDelegate <NSObject>
-(void) segmentedControl: (DRSegmentedControl*) control didSelectSection: (NSInteger) section;
@end

@interface DRSegmentedControl : UISegmentedControl

@property (weak) id<DRSegmentedControlDelegate> delegate;
@end
