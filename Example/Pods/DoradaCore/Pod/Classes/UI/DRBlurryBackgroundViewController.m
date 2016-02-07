//
//  DRBlurryBackgroundViewController.m
//  DoradaCore
//
//  Created by Daniel Broad on 02/06/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import "DRBlurryBackgroundViewController.h"

@interface DRBlurryBackgroundViewController ()
@property (weak) UIView *donerView;
@property (assign) BOOL isLandscape;
@property (assign) BOOL isPortrait;
@end

@implementation DRBlurryBackgroundViewController

- (id)initWithBackgroundDonerView: (UIView*) view {
    self = [super init];
    if (self) {
        self.backgroundImage = [self snapshot:view];
        self.donerView = view;
        // subclass to set self.blurryBackgroundImage as blurs are app specific
    }
    return self;
}


#pragma mark - blurred background

- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
#endif
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void) loadView {
    [super loadView];
    self.view.clipsToBounds = YES;
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectOffset(self.view.bounds,0,0-self.view.frame.size.height)];
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundImageView.image = self.blurredBackgroundImage;
    [self.view addSubview:self.backgroundImageView];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.backgroundImageView.frame = CGRectOffset(self.view.bounds,0,0-self.view.frame.size.height);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [[self transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.backgroundImageView.frame = self.view.bounds;
    } completion:nil];
#endif
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isLandscape = UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
    self.isPortrait = UIInterfaceOrientationIsPortrait(self.interfaceOrientation);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [[self transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:[context transitionDuration]];
        [UIView setAnimationCurve:[context completionCurve]];
        [UIView setAnimationBeginsFromCurrentState:YES];
        
        self.backgroundImageView.transform = CGAffineTransformMakeTranslation(0, -self.view.frame.size.height);
        
        [UIView commitAnimations];
    } completion:nil];
#endif
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    // cannot rotate
    if (self.isPortrait) {
        return UIInterfaceOrientationMaskPortrait;
    }
    if (self.isLandscape) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskAll;
}
@end
