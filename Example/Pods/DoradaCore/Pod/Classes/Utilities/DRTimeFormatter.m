//
//  DRTimeFormatter.m
//  DoradaCore
//
//  Created by Daniel Broad on 26/02/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import "DRTimeFormatter.h"

@implementation DRTimeFormatter


+(NSString*) timeFormatFromInteger: (NSInteger) inSeconds allowNegative: (BOOL) allowNegative {
	if (inSeconds < 0 && !allowNegative) {
		inSeconds = 0 - inSeconds; // never show a -ve, even when the calc goes wrong
	}
    int intseconds = (int) inSeconds;
	int hours = (intseconds / 3600);
	int minutes = (intseconds / 60) % 60;
	int seconds = intseconds % 60;
	if (hours > 0)
		return [NSString stringWithFormat: @"%d:%02d:%02d", hours, minutes, seconds];
	else
		return [NSString stringWithFormat: @"%02d:%02d", minutes, seconds];
	
}

+(NSString*) timeFormatFromNumber: (NSNumber*) number {
    return  [self timeFormatFromInteger:[number integerValue]];
}

+(NSString*) timeFormatFromInteger: (NSInteger) inSeconds {
    return [self timeFormatFromInteger:inSeconds allowNegative:NO];
}

+(NSString*) wordyTimeFormatFromInteger: (NSInteger) inSeconds {
    int intseconds = (int) inSeconds;
    int hours = (intseconds / 3600);
    int minutes = (int) round((float)intseconds / 60.0f) % 60;
    //int seconds = intseconds % 60;

    if (hours > 0) {
        NSString *strHours;
        if (hours==1) {
            strHours = NSLocalizedString(@"1 hour", nil);
        } else {
            strHours = [NSString stringWithFormat:NSLocalizedString(@"%g hours",nil),(float)hours];
        }
        
        NSString *strMins;
        if (minutes==1) {
            strMins = NSLocalizedString(@"1 minute", nil);
        } else if (minutes>1) {
            strMins = [NSString stringWithFormat:NSLocalizedString(@"%g minutes",nil),(float)minutes];
        } else {
            return strHours;
        }
        
        return [NSString stringWithFormat: NSLocalizedString(@"%1$@ %2$@", @"Reverse the order of 1 and 2 if your language would say (2 minutes 3 hours rather than 3 hours 2 minutes)"), strHours, strMins];
    } else {
        if (minutes==1) {
            return NSLocalizedString(@"1 minute", nil);
        } else {
            return [NSString stringWithFormat:NSLocalizedString(@"%g minutes",nil),(float)minutes];
        }
    }
}

+(NSString*) shortFriendlyTimeFormatFromInteger: (NSInteger) inSeconds {
    int intseconds = (int) inSeconds;
    int hours = (intseconds / 3600);
    int minutes = (int) round((float)intseconds / 60.0f) % 60;
    //int seconds = intseconds % 60;
    
    if (hours > 0) {
        NSNumber *numHours = [NSNumber numberWithInteger:hours];
        NSString *mins = [NSString stringWithFormat:@"%d",minutes];
        return [NSString stringWithFormat: NSLocalizedString(@"%1$@h %2$@m", @"%1$@ hours %2$@ minutes (you can swap the order of %1$@,%2$@ if you need to)"), numHours, mins];
    } else {
        return [NSString stringWithFormat: NSLocalizedString(@"%ld min",@"%d minutes"), minutes];
    }
}
@end
