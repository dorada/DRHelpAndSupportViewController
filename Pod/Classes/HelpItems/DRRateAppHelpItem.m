//
//  DRRateAppHelpItem.m
//  Pods
//
//  Created by Daniel Broad on 07/02/2016.
//
//

#import "DRRateAppHelpItem.h"
#import "DRGetRatingController.h"

@interface DRRateAppHelpItem ()

@property (strong) NSString *appName;
@property (strong) NSString *appID;

@end

@implementation DRRateAppHelpItem

-(instancetype) initWithAppName: (NSString*) appName appID: (NSString*) appID {
    self = [super initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Please Rate %@", @"Rate <app name> (write a review or rate the app on the App Store"),appName] actionHandler:^(DRHelpAndSupportItem *item){
        
    }];
    if (self) {
        self.appID = appID;
        self.appName = appName;
    }
    return self;
}

-(void) setContainingCell:(UITableViewCell *)containingCell {
    [super setContainingCell:containingCell];
    [[DRGetRatingController sharedInstance] getAppRatingForAppID:[NSString stringWithFormat:@"%@",self.appID] completionHandler:^(NSDictionary *ratingDictionary) {
        NSInteger rating = [[ratingDictionary objectForKey:kRatingDictionaryCurrentVersionRatingCount] integerValue];
        
        if (rating < 2) {
            self.containingCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Nobody has rated this version", nil),@"😂"];
        } else if (rating < 20) {
            self.containingCell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"This version only has %d ratings", nil), rating];
        } else {
            self.containingCell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"This version has %d ratings", nil), rating];
        }
    }];
}
@end
