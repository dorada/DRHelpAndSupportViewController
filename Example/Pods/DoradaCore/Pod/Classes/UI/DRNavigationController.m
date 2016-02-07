//
//  DRNavigationController.m
//  DoradaCore
//
//  Created by Daniel Broad on 15/06/2012.
//  Copyright (c) 2012 Dorada. All rights reserved.
//

#import "DRNavigationController.h"

@interface DRNavigationController ()
@end

@implementation DRNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.tabBarItem respondsToSelector:@selector(setTitlePositionAdjustment:)]) {
         self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2.0f);
    }
}


-(BOOL)shouldAutorotate {
    
    if ([self.visibleOrShowingViewController respondsToSelector:@selector(shouldAutorotate)]) {
        return [self.visibleOrShowingViewController shouldAutorotate];
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([self.visibleOrShowingViewController respondsToSelector:@selector(supportedInterfaceOrientations)]) {
        return [self.visibleOrShowingViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    if ([self.visibleOrShowingViewController respondsToSelector:@selector(preferredInterfaceOrientationForPresentation)]) {
        return [self.visibleOrShowingViewController preferredInterfaceOrientationForPresentation];
    }
    return [[UIApplication sharedApplication] statusBarOrientation];
}


- (UIViewController*) visibleOrShowingViewController {
    if (![self.visibleViewController isKindOfClass:UIAlertController.class]) {
        return self.visibleViewController;
    }
    return self.topViewController;
}

+(DRNavigationController*) navigationControllerWithRootViewController: (UIViewController*) viewController {
    return [[self.class alloc] initWithRootViewController: viewController];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    if ([self.visibleViewController respondsToSelector:@selector(preferredStatusBarStyle)]) {
        return [self.visibleViewController preferredStatusBarStyle];
    }
    
    return UIStatusBarStyleDefault;
}
@end
