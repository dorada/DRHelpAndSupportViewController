//
//  DRNavigationControllerWithPopControl.m
//  DoradaCore
//
//  Created by Daniel Broad on 26/02/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import "DRNavigationControllerWithPopControl.h"

@interface DRNavigationControllerWithPopControl ()

@end

@implementation DRNavigationControllerWithPopControl

- (BOOL) navigationShouldPopOnBackButton {
    return YES;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
	if([self.viewControllers count] < [navigationBar.items count]) {
		return YES;
	}
    
	BOOL shouldPop = YES;
	UIViewController* vc = [self topViewController];
	if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
		shouldPop = (BOOL) [vc performSelector:@selector(navigationShouldPopOnBackButton)];
	}
    
	if(shouldPop) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self popViewControllerAnimated:YES];
		});
	}
    
	return NO;
}

@end
