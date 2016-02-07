//
//  ActivityAlertView.m
//  Dorada
//
//  Created by Daniel Broad on 21/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DRActivityAlertView.h"
#import "UIDevice+Extensions.h"

@interface DRActivityAlertView () <UIAlertViewDelegate>

@end

@implementation DRActivityAlertView

@synthesize activityView;

- (void) dealloc {
    [self.activityView removeFromSuperview];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    if ([UIDevice is_ios7]) {
        self = [super initWithTitle:title message:nil delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
    } else {
        self = [super initWithTitle:title message:@"\n" delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
	{
        self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 43, 30, 30)];
        if ([UIDevice is_ios7]) {
            activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            [self setValue:activityView forKey:@"_accessoryView"];
        } else {
            activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            [self addSubview:activityView];
        }
		[activityView startAnimating];
    }
	
    return self;
}

- (void) show {
    [super show];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass: UIScrollView.class]) {
            [view addSubview:self.activityView];
        }
    }
    if (![self.activityView superview]) {
        [self addSubview:self.activityView];
    }
    
}

- (void) close
{
	[self dismissWithClickedButtonIndex:-99 animated:YES];
}

@end