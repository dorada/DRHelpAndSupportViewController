//
//  DRInstallTracker.h
//  DoradaCore
//
//  Created by Daniel Broad on 14/02/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRInstallTracker : NSObject

+(void) trackInstall;
+(BOOL) hasBeenInstalledForADay;
+(BOOL) hasBeenInstalledForAWeek;
+(BOOL) doThisOncePer: (NSInteger) days trackingKey: (NSString*) key;
@end
