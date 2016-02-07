//
//  DRTimeFormatter.h
//  DoradaCore
//
//  Created by Daniel Broad on 26/02/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRTimeFormatter : NSObject

+(NSString*) timeFormatFromInteger: (NSInteger) inSeconds;
+(NSString*) timeFormatFromInteger: (NSInteger) inSeconds allowNegative: (BOOL) allowNegative;
+(NSString*) timeFormatFromNumber: (NSNumber*) number;

+(NSString*) wordyTimeFormatFromInteger: (NSInteger) inSeconds; // 1 hour 33 min

+(NSString*) shortFriendlyTimeFormatFromInteger: (NSInteger) inSeconds; // 1h33m

@end
