//
//  DRHelpAndSupportItem.m
//  Pods
//
//  Created by Daniel Broad on 06/02/2016.
//
//

#import "DRHelpAndSupportItem.h"

@implementation DRHelpAndSupportItem

-(instancetype) initWithTitle: (NSString*) title actionHandler: (DRHelpAndSupportActionHandler) actionHandler {
    self = [super init];
    if (self) {
        _title = title;
        _actionHandler = actionHandler;
    }
    return self;
}

@end
