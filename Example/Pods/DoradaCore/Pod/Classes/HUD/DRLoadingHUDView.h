//
//  DRLoadingHUDView.h
//  DoradaCore
//
//  Created by Daniel Broad on 18/06/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonSelectionBlock)(NSInteger buttonSelected);

@interface DRLoadingHUDView : UIView

@property (strong,nonatomic) NSString* title;
@property (strong,nonatomic) NSString* cancelText;
@property (strong) NSArray* otherButtonTitles;

@property (strong) buttonSelectionBlock selectionBlock;

-(void) loadView;
@end
