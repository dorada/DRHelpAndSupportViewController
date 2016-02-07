//
//  DRSettingsSwitchTableViewCell.h
//  Dorada
//
//  Created by Daniel Broad on 13/04/2011.
//  Copyright 2011 Dorada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRSettingsSwitchTableViewCell : UITableViewCell

@property (nonatomic, copy) id settingsObject;
@property (nonatomic, copy) NSString *targetGlobalSetting;
@property (nonatomic) UISwitch *mySwitch;
@property (nonatomic) BOOL invertedSetting;

-(void) toggleSwitch;

@end