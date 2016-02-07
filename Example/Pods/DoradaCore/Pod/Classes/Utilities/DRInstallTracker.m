//
//  DRInstallTracker.m
//  DoradaCore
//
//  Created by Daniel Broad on 14/02/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

static NSString *const kUserDefaultInstallDateKey = @"DRInstallTracker_InstallDate";
static NSString *const kDoThisTrackingKey = @"DRInstallTracker_Tracking_%@";

#import "DRInstallTracker.h"

@implementation DRInstallTracker

+(void) trackInstall {
    NSDate *firstRun = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultInstallDateKey];
    if (!firstRun) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kUserDefaultInstallDateKey];
        firstRun = [NSDate date];
    }
    
}

+(BOOL) hasBeenInstalledForADay {
    [self trackInstall];
    NSDate *firstRun = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultInstallDateKey];
    if ([(NSDate*)[firstRun dateByAddingTimeInterval:86400] compare: [NSDate date]] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

+(BOOL) hasBeenInstalledForAWeek {
    [self trackInstall];
    NSDate *firstRun = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultInstallDateKey];
    if ([(NSDate*)[firstRun dateByAddingTimeInterval:7*86400] compare: [NSDate date]] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

+(BOOL) doThisOncePer: (NSInteger) days trackingKey: (NSString*) key {
    NSString *defaultsKey = [NSString stringWithFormat:kDoThisTrackingKey,key];
    NSDate *lastDone = [[NSUserDefaults standardUserDefaults] objectForKey:defaultsKey];
    
    if (!lastDone) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:defaultsKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    
    if ([(NSDate*)[lastDone dateByAddingTimeInterval:days*86400] compare: [NSDate date]] == NSOrderedAscending) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:defaultsKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    
    return NO;
    
}
@end
