//
//  DRGetHelpItem.h
//  Pods
//
//  Created by Daniel Broad on 06/02/2016.
//
//

#import "DRHelpAndSupportItem.h"

@interface DRGetHelpItem : DRHelpAndSupportItem

-(instancetype) initWithTitle: (NSString*) title
                  recipientEmails: (NSArray<NSString*>*) recipients
                  attachmentPaths: (NSArray<NSString*>*) attachments;

@end
