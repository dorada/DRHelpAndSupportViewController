//
//  UITabBarController+autoRotate.h
//  DoradaCore
//
//  Created by Daniel Broad on 01/06/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (autoRotate)

-(BOOL)shouldAutorotate;
- (NSUInteger)supportedInterfaceOrientations;

@end
