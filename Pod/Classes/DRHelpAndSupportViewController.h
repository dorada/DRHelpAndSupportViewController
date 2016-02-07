//
//  HSHelpAndSupportViewController.h
//
//  Created by Daniel Broad on 26/04/2012.
//  Copyright (c) 2012 Dorada. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DRHelpViewController.h"

@class DRHelpAndSupportItem;

@interface DRHelpAndSupportViewController : UITableViewController

@property (strong) NSArray<NSArray<DRHelpAndSupportItem*>*> *supportSections;

-(instancetype) initWithCancelButton: (BOOL) cancelButton;

-(UIImage*) helpTabBarImage;

@end
