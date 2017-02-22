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
    return [self initWithTitle:title subtitle:nil actionHandler:actionHandler];
}

-(instancetype) initWithTitle: (NSString*) title subtitle: (NSString*) subtitle actionHandler: (DRHelpAndSupportActionHandler) actionHandler {
    self = [super init];
    if (self) {
        _title = title;
        _subtitle = subtitle;
        _actionHandler = actionHandler;
    }
    return self;
}

@end

@implementation DRHelpAndSupportSection

-(instancetype) initWithTitle: (NSString*) title helpItems: (NSArray*) items {
    self = [super init];
    if (self) {
        _title = title;
        _helpItems = items;
    }
    return self;
}

-(void) appendHelpItem: (DRHelpAndSupportItem*) item {
    NSMutableArray *items = [_helpItems mutableCopy];
    [items addObject: item];
    _helpItems = [NSArray arrayWithArray:items];
}
@end
