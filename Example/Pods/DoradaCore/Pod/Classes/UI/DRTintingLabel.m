//
//  RRTintingLabel.m
//  DoradaCore
//
//  Created by Daniel Broad on 11/09/2013.
//  Copyright (c) 2013 Dorada. All rights reserved.
//

#import "DRTintingLabel.h"

@implementation DRTintingLabel

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        self.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
#endif
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        self.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
#endif
    }
    return self;
}

-(void) didMoveToSuperview {
    [super didMoveToSuperview];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([self respondsToSelector:@selector(setTintColor:)]) {
        self.textColor = self.tintColor;
    }
#endif
}

-(void) tintColorDidChange {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([self respondsToSelector:@selector(setTintColor:)]) {
        self.textColor = self.tintColor;
    }
#endif
}

-(void) setBounds:(CGRect)bounds{
    [super setBounds:bounds];
    if (self.preferredMaxLayoutWidth != bounds.size.width) {
        self.preferredMaxLayoutWidth = bounds.size.width;
        [self invalidateIntrinsicContentSize];
    }
}

@end
