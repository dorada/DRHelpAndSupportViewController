//
//  HSHelpAndSupportViewController.m
//  Hundred Square
//
//  Created by Daniel Broad on 11/04/2011.
//  Copyright 2011 Dorada. All rights reserved.
//

#import "DRHelpAndSupportViewController.h"

#import "DRHelpAndSupportItem.h"

#pragma mark - DRMailComposeViewController

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
    return [self itemsForSection:section].count;
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
    NSArray *section = [self itemsForSection:indexPath.section];
    DRHelpAndSupportItem *item = [section objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.title;
    item.containingCell = cell;
    item.containingHelpViewController = self;
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    NSArray *section = [self itemsForSection:indexPath.section];
    DRHelpAndSupportItem *item = [section objectAtIndex:indexPath.row];

    item.actionHandler(item);

}

#pragma mark - sections

-(NSArray<DRHelpAndSupportItem*> *) itemsForSection: (NSInteger) section {
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

@end
