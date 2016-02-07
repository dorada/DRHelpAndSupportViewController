//
//  UITabBarController+autoRotate.m
//  DoradaCore
//
//  Created by Daniel Broad on 01/06/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import "UITabBarController+autoRotate.h"

@implementation UITabBarController (autoRotate)

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (NSUInteger)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

@end
