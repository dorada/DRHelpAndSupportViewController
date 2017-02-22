//
//  DRHelpAndSupportViewController.h
//
//  Created by Daniel Broad on 26/04/2012.
//  Copyright (c) 2012 Dorada. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DRHelpViewController.h"
#import "DRHelpAndSupportItem.h"

@interface DRHelpAndSupportViewController : UITableViewController

@property (strong) NSArray<NSArray<DRHelpAndSupportItem*>*> *supportSections;

-(instancetype) initWithCancelButton: (BOOL) cancelButton;

-(UIImage*) helpTabBarImage;

-(NSArray*) defaultSupportSections;

-(DRHelpAndSupportSection*) defaultHelpSection1;
-(DRHelpAndSupportSection*) defaultHelpSection2;
-(DRHelpAndSupportSection*) defaultLinksSection;
-(DRHelpAndSupportSection*) defaultLegalSection;

-(DRHelpAndSupportItem*) removeAdsItem;

@end
