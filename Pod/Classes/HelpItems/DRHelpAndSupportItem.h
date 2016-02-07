//
//  DRHelpAndSupportItem.h
//  Pods
//
//  Created by Daniel Broad on 06/02/2016.
//
//

#import <Foundation/Foundation.h>

@interface DRHelpAndSupportItem : NSObject

typedef void (^DRHelpAndSupportActionHandler)(DRHelpAndSupportItem *item);

@property (strong,readonly) NSString *title;
@property (strong,readonly) DRHelpAndSupportActionHandler actionHandler;

-(instancetype) initWithTitle: (NSString*) title actionHandler: (DRHelpAndSupportActionHandler) actionHandler;

@property (weak) UIViewController *containingHelpViewController;
@property (weak) UITableViewCell *containingCell;

@end
