//
//  DRLoadingHUD.h
//  DoradaCore
//
//  Created by Daniel Broad on 18/06/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DRLoadingHUD;

@interface DRLoadingHUD : NSObject

typedef void(^DRLoadingHUDCallback)(DRLoadingHUD *hud, NSInteger buttonIndex);

+(instancetype) showHUDWithTitle: (NSString*) title
                    cancelButton: (NSString*) cancelText
               otherButtonTitles: (NSArray*) titles
                 callbackHandler: (DRLoadingHUDCallback) handler;

@property (strong) DRLoadingHUDCallback handler;
@property (assign) NSInteger tag;
@property (assign) NSInteger cancelButtonIndex;
@property (strong,nonatomic) NSString* title;
-(void) cancel;

@end
