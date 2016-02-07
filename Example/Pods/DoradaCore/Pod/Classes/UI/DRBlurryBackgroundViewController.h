//
//  DRBlurryBackgroundViewController.h
//  DoradaCore
//
//  Created by Daniel Broad on 02/06/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRBlurryBackgroundViewController : UIViewController

@property (strong) UIImageView *backgroundImageView;
@property (strong) UIImage *backgroundImage;
@property (strong) UIImage *blurredBackgroundImage;

- (id)initWithBackgroundDonerView: (UIView*) view;
- (UIImage *)snapshot:(UIView *)view;
@end
