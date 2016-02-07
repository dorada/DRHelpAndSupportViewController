//
//  HSHelpViewController.h
//
//  Created by Daniel Broad on 28/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRHelpAndSupportItem;

@interface DRHelpViewController : UIViewController <UIWebViewDelegate> {
	UIWebView *_webView;
}

@property (nonatomic,retain) IBOutlet UIWebView *webView;

+(DRHelpAndSupportItem*) quickHelpItem;

@end
