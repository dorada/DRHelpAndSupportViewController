//
//  DRSimpleAlert.h
//  DoradaCore
//
//  Created by Daniel Broad on 12/08/2015.
//  Copyright © 2015 Dorada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRSimpleAlert : NSObject

+(void) showSimpleAlertFromViewController: (UIViewController*) viewController title: (NSString*) title message: (NSString*) message cancelButton: (NSString*) cancel;
@end
