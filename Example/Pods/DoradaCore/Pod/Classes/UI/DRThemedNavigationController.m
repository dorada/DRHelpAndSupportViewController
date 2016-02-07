//
//  RRNavigationController.m
//  Dorada
//
//  Created by Daniel Broad on 23/04/2014.
//  Copyright (c) 2014 Dorada Software Ltd. All rights reserved.
//

#import "DRThemedNavigationController.h"

@interface DRThemedNavigationController ()

@end

@implementation DRThemedNavigationController

-(void) _setup {
    self.defaultStatusBarStyle = (UIStatusBarStyle) 99;
}

-(id) init {
    self = [super init];
    if (self) {
        [self _setup];
    }
    return self;
}

-(id) initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self _setup];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _setup];
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.defaultStatusBarStyle != (UIStatusBarStyle) 99) {
        return self.defaultStatusBarStyle;
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    return [self.visibleViewController preferredStatusBarStyle];
#endif
}

@end
