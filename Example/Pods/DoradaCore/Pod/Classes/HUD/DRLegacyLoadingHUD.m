//
//  DRLegacyLoadingHUD.m
//  DoradaCore
//
//  Created by Daniel Broad on 19/06/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import "DRLegacyLoadingHUD.h"
#import "DRActivityAlertView.h"

@interface DRLegacyLoadingHUD () <UIAlertViewDelegate>
@end

@implementation DRLegacyLoadingHUD {
    DRActivityAlertView *_activityAlertView;
}

-(void) dealloc {
    _activityAlertView.delegate = nil;
}

-(instancetype) initWithTitle: (NSString*) title
                 cancelButton: (NSString*) cancelText
            otherButtonTitles: (NSArray*) titles
              callbackHandler: (DRLoadingHUDCallback) handler {
    self  = [super init];
    if (self) {
        if ([titles count]==0) {
            _activityAlertView = [[DRActivityAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:cancelText otherButtonTitles: nil];
        } else {
            id first = titles.count?[titles objectAtIndex:0]:nil;
            _activityAlertView = [[DRActivityAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:cancelText otherButtonTitles: first,nil];
        }
        _activityAlertView.delegate = self;
        self.handler = handler;
    }
    return self;
}

-(void) cancel {
    [_activityAlertView close];
}

-(void) show {
    [_activityAlertView show];
}

-(void) setTitle:(NSString *)title {
    _activityAlertView.title = title;
}

-(NSString*) title {
    return _activityAlertView.title;
}

-(NSInteger) cancelButtonIndex {
    return _activityAlertView.cancelButtonIndex;
}

-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex != -99) {
        self.handler(self,buttonIndex);
    }
}

@end
