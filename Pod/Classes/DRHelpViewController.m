//
//  HSHelpViewController.m
//
//  Created by Daniel Broad on 28/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DRHelpViewController.h"

#import "DRHelpAndSupportItem.h"

@implementation DRHelpViewController

+(DRHelpAndSupportItem*) quickHelpItem {
    DRHelpAndSupportItem *quickHelpItem = [[DRHelpAndSupportItem alloc] initWithTitle:NSLocalizedString(@"Quick Help", nil) actionHandler:^(DRHelpAndSupportItem *item){
        DRHelpViewController *helpViewController = [[DRHelpViewController alloc] init];
        [item.containingHelpViewController.navigationController pushViewController:helpViewController animated:YES];
    }];
    return quickHelpItem;
}

- (void) loadView {
    [super loadView];
    if (!self.webView) {
        self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:self.webView];
        _webView.delegate = self;
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Help",nil);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	if (error) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil) 
														message:error.localizedDescription 
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"OK",nil) 
											  otherButtonTitles:nil];
		[alert show];
	}	
	
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
    NSString *pathName = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:pathName encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:nil];

}

-(IBAction) cancel: (id) sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}


@end
