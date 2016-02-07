//
//  RRTwoLabelTitleView.h
//  Dorada
//
//  Created by Daniel Broad on 27/06/2013.
//  Copyright (c) 2013 Dorada Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRTwoLabelTitleView : UIView

@property (strong) UILabel *titleLabel;
@property (strong) UILabel *subtitleLabel;

-(void) setTitle: (NSString*) title;
-(void) setSubtitle: (NSString*) subtitle;

@end
