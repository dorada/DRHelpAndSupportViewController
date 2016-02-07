//
//  DRGetRatingController.h
//  DoradaCore
//
//  Created by Daniel Broad on 06/12/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import "DRSingleton.h"

extern NSString *const kRatingDictionaryTotalRatingCount;
extern NSString *const kRatingDictionaryCurrentVersionRatingCount;

@interface DRGetRatingController : DRSingleton

-(void) getAppRatingForAppID: (NSString*) appId completionHandler: (void(^)(NSDictionary *ratingDictionary)) completionHandler;

-(NSInteger) savedRatingCount;

@end
