//
//  DRSimpleAlert.m
//  DoradaCore
//
//  Created by Daniel Broad on 12/08/2015.
//  Copyright © 2015 Dorada. All rights reserved.
//

#import "DRSimpleAlert.h"
@implementation DRSimpleAlert

+(void) showSimpleAlertFromViewController: (UIViewController*) viewController title: (NSString*) title message: (NSString*) message cancelButton: (NSString*) cancel {
    
    Class alertController = NSClassFromString(@"UIAlertController");
    if (alertController) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                
                                                            }];
        
        [alert addAction:cancelAction];

        UIViewController *vc = viewController?viewController:[UIApplication sharedApplication].keyWindow.rootViewController;
        
        alert.popoverPresentationController.sourceView = vc.view;
        alert.popoverPresentationController.sourceRect = CGRectMake(alert.popoverPresentationController.sourceView.frame.size.width / 2.0, alert.popoverPresentationController.sourceView.frame.size.height / 2.0, 1.0, 1.0);
        
        [vc presentViewController:alert animated:YES completion:nil];
    } else {
#if !TARGET_OS_TV
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil];
        [alert show];
#endif
    }
}
@end
