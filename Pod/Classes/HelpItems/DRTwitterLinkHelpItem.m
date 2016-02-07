//
//  DRTwitterLinkHelpItem.m
//  Pods
//
//  Created by Daniel Broad on 07/02/2016.
//
//

#import "DRTwitterLinkHelpItem.h"

@interface DRTwitterLinkHelpItem ()

@property (strong) NSString *twitterID;

@end

@implementation DRTwitterLinkHelpItem

-(instancetype) initWithTwitterUsername: (NSString*) username {
    self = [super initWithTitle:username actionHandler:^(DRHelpAndSupportItem* item){
        NSURL *twitterURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@",_twitterID]];
        [[UIApplication sharedApplication] openURL:twitterURL];
    }];
    if (self) {
        self.twitterID = username;
    }
    return self;
}

-(void) setContainingCell:(UITableViewCell *)containingCell {
    [super setContainingCell:containingCell];
    containingCell.detailTextLabel.text = [NSString stringWithFormat:@"http://twitter.com/%@",self.twitterID];
}
@end
