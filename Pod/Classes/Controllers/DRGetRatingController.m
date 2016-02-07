//
//  DRGetRatingController.m
//  DoradaCore
//
//  Created by Daniel Broad on 06/12/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//
// https://itunes.apple.com/search?term=rssradio&country=us&entity=software

NSString *const kiTunesSearchURL = @"https://itunes.apple.com/search?term=%@&country=%@&entity=software";

#import "DRGetRatingController.h"

NSString *const kRatingDictionaryTotalRatingCount = @"userRatingCount";
NSString *const kRatingDictionaryCurrentVersionRatingCount = @"userRatingCountForCurrentVersion";

NSString *const kUserDefaultRatingCount = @"userRatingCount";

@implementation DRGetRatingController

-(instancetype) init {
    self = [super init];
    if (self) {
    }
    return self;
}

-(void) getAppRatingForAppID: (NSString*) requestedAppID completionHandler: (void(^)(NSDictionary *ratingDictionary)) completionHandler {
    NSString *country = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    NSDictionary *dict = [[NSBundle mainBundle] localizedInfoDictionary];
    NSString *appName = [dict objectForKey:@"CFBundleDisplayName"];
    appName = [appName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kiTunesSearchURL,appName,country]];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return;
        }
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray *results = [responseDict objectForKey:@"results"];
        if (![results isKindOfClass:NSArray.class] || !results.count) {
            return;
        }
        
        for (NSDictionary *result in results) {
            NSString *appID = [[result objectForKey:@"trackId"] stringValue];
            if ([appID compare: requestedAppID]==NSOrderedSame) {
                NSInteger ratingCount = [[result objectForKey:kRatingDictionaryCurrentVersionRatingCount] integerValue];
                [[NSUserDefaults standardUserDefaults] setInteger:ratingCount forKey:kUserDefaultRatingCount];
                if (completionHandler) {
                    completionHandler(result);
                }
                return;
            }
        }
    }];
    [task resume];
}

-(NSInteger) savedRatingCount {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kUserDefaultRatingCount];
}

@end
