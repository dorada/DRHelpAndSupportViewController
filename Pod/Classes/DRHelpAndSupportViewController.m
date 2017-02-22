//
//  DRHelpAndSupportViewController.m
//
//  Created by Daniel Broad on 11/04/2011.
//  Copyright 2011 Dorada. All rights reserved.
//

#import "DRHelpAndSupportViewController.h"

#import "DRInstallTracker.h"

#import "DRHelpAndSupportItem.h"
#import "DRHelpViewController.h"
#import "DRGetHelpItem.h"

#import "DRApplicationPaths.h"
#import "DRTwitterLinkHelpItem.h"

#pragma mark - DRMailComposeViewController

@interface DRApplicationDelegate : NSObject
-(NSString*) getFeedbackLog;
-(NSArray*) helpAttachments;
@end

@interface DRHelpAndSupportViewController ()

@property (nonatomic) BOOL cancelButton;

@end

@implementation DRHelpAndSupportViewController

#pragma mark - View lifecycle

-(instancetype) initWithCancelButton: (BOOL) cancelButton {
	
	if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
		self.title = [NSString stringWithFormat:@"%@ %@",
					  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
					  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        self.cancelButton = cancelButton;
        self.supportSections = [self defaultSupportSections];
	}
	
	return self;
}

-(void) loadView {
    [super loadView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.autoresizesSubviews = YES;
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.navigationController.viewControllers.count == 1 && self.cancelButton)  {
        UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
        self.navigationItem.leftBarButtonItem = cancelButtonItem;

    }
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;
}

- (void) cancel: (id) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.supportSections.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self itemsForSection:section].helpItems.count;
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    DRHelpAndSupportSection *hssection = [self itemsForSection:section];
    return hssection.title;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSString *cellIdentifier = @"DRHelpCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell...
    DRHelpAndSupportSection *section = [self itemsForSection:indexPath.section];
    DRHelpAndSupportItem *item = [section.helpItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.subtitle;
    item.containingCell = cell;
    item.containingHelpViewController = self;
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    DRHelpAndSupportSection *section = [self itemsForSection:indexPath.section];
    DRHelpAndSupportItem *item = [section.helpItems objectAtIndex:indexPath.row];

    item.actionHandler(item);

}

#pragma mark - sections

-(DRHelpAndSupportSection *) itemsForSection: (NSInteger) section {
    return [self.supportSections objectAtIndex:section];
}

#pragma mark - Icon

-(UIImage*) helpTabBarImage {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(32, 32),false,[UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSAssert(context,@"context must not be nil");
    
    //// Oval 2 Drawing
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(7.5, 3.5, 17, 15)];
    [[UIColor whiteColor] setStroke];
    oval2Path.lineWidth = 4.5;
    [oval2Path stroke];
    
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(13, 19, 6, 6) cornerRadius: 2];
    [[UIColor whiteColor] setFill];
    [roundedRectanglePath fill];
    
    //// Bezier Drawing
    CGContextSetBlendMode(context, kCGBlendModeClear);
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(12, 8, 8, 6)];
    [[UIColor clearColor] setFill];
    [ovalPath fill];
    
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(12.5, 22.5)];
    [bezierPath addLineToPoint: CGPointMake(12.5, 18.5)];
    [bezierPath addLineToPoint: CGPointMake(15.5, 14.5)];
    [bezierPath addLineToPoint: CGPointMake(15.5, 10.5)];
    [bezierPath addLineToPoint: CGPointMake(2.5, 10.5)];
    [bezierPath addLineToPoint: CGPointMake(2.5, 22.5)];
    [bezierPath addLineToPoint: CGPointMake(12.5, 22.5)];
    [bezierPath closePath];
    [[UIColor clearColor] setFill];
    [bezierPath fill];
    [[UIColor clearColor] setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    
    
    
    //// Rounded Rectangle 2 Drawing
    UIBezierPath* roundedRectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(13, 26, 6, 6) cornerRadius: 2];
    [[UIColor whiteColor] setFill];
    [roundedRectangle2Path fill];
    
    
    
    //// Rounded Rectangle 3 Drawing
    UIBezierPath* roundedRectangle3Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(5.5, 8, 5, 5) cornerRadius: 2];
    [[UIColor whiteColor] setFill];
    [roundedRectangle3Path fill];
    
    // drawing ended
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return viewImage;
}

#pragma mark - help sections

-(NSArray*) defaultSupportSections {
    return @[
             [self defaultHelpSection1],
             [self defaultHelpSection2],
             [self defaultLinksSection],
             [self defaultLegalSection]
             ];
}

-(DRHelpAndSupportSection*) defaultHelpSection1 {
    return [[DRHelpAndSupportSection alloc] initWithTitle: NSLocalizedString(@"Help", nil)
                                                helpItems: @[
                                                            [DRHelpViewController quickHelpItem]
                                                            ]
            ];
}

-(DRHelpAndSupportSection*) defaultHelpSection2 {
    NSMutableArray *helpAttachments = [NSMutableArray array];
    DRApplicationDelegate *delegate = (DRApplicationDelegate*) [UIApplication sharedApplication].delegate;
    if ([delegate respondsToSelector:@selector(helpAttachments)]) {
        [helpAttachments addObjectsFromArray:[delegate helpAttachments]];
    }
    if ([delegate respondsToSelector:@selector(getFeedbackLog)]) {
        NSString *log = [delegate getFeedbackLog];
        NSString *debug = [[DRApplicationPaths applicationCachesDirectory] stringByAppendingPathComponent:@"debug.log"];
        if ([log writeToFile:debug atomically:NO encoding:NSUTF8StringEncoding error:nil]) {
            [helpAttachments addObject:debug];
        }
    }
    NSMutableArray *items = [@[
             [[DRHelpAndSupportItem alloc] initWithTitle:NSLocalizedString(@"FAQ", @"Frequently Asked Questions") actionHandler:^(DRHelpAndSupportItem *item) {
                 NSString *name = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
                 name = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                 NSString *url = [NSString stringWithFormat:@"https://www.dorada.co.uk/api/faq.php?app=%@",name];
                 [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
             }],
             [[DRGetHelpItem alloc] initWithTitle:NSLocalizedString(@"Get Help", nil)
                                  recipientEmails:@[@"support@dorada.co.uk"]
                                  attachmentPaths:helpAttachments]
             ] mutableCopy];
    
    return [[DRHelpAndSupportSection alloc] initWithTitle: nil
                                                helpItems: items
            ];
}

-(DRHelpAndSupportSection*) defaultLinksSection {
    NSString *twitterID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"twitter_user"];
    NSMutableArray *items = [NSMutableArray array];
    [items addObjectsFromArray: @[
             [[DRHelpAndSupportItem alloc] initWithTitle:NSLocalizedString(@"More Apps", nil) actionHandler:^(DRHelpAndSupportItem *item) {
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.dorada.co.uk/AppStore"]];
             }]
    ]];
    
    if (twitterID) {
        [items addObject: [[DRTwitterLinkHelpItem alloc] initWithTwitterUsername:twitterID]];
    }
    return [[DRHelpAndSupportSection alloc] initWithTitle: NSLocalizedString(@"Links", @"Links to pages on the internet")
                                                helpItems: items
            ];
}

-(DRHelpAndSupportSection*) defaultLegalSection {
    NSMutableArray *items = [NSMutableArray array];
    [items addObjectsFromArray: @[
                                  [[DRHelpAndSupportItem alloc] initWithTitle:NSLocalizedString(@"Privacy Policy", nil) actionHandler:^(DRHelpAndSupportItem *item) {
        NSString *url = [NSString stringWithFormat:@"https://www.doradasoftware.com/privacy"];
        [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
    }],
                                  [[DRHelpAndSupportItem alloc] initWithTitle:NSLocalizedString(@"Terms of Use", nil) actionHandler:^(DRHelpAndSupportItem *item) {
        NSString *url = [NSString stringWithFormat:@"https://www.doradasoftware.com/terms"];
        [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
    }]
                                  ]];
    return [[DRHelpAndSupportSection alloc] initWithTitle: NSLocalizedString(@"Legal", @"Links to privacy policy and terms of use")
                                                helpItems: items
            ];
    
}

@end
