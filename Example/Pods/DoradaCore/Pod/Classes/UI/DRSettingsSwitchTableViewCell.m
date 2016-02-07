//
//  DRSettingsSwitchTableViewCell.m
//  Dorada
//
//  Created by Daniel Broad on 13/04/2011.
//  Copyright 2011 Dorada. All rights reserved.
//

#import "DRSettingsSwitchTableViewCell.h"

@implementation DRSettingsSwitchTableViewCell

@synthesize settingsObject;
@synthesize targetGlobalSetting;
@synthesize mySwitch;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		mySwitch = [[UISwitch alloc] init];
		self.accessoryView = mySwitch;
		[mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

-(void) setSettingsObject: (id) _settingsObject {
    NSAssert(self.targetGlobalSetting,@"You must set the setting name first");
	settingsObject = _settingsObject;
    BOOL value = [[settingsObject valueForKey:self.targetGlobalSetting] intValue];
    if (self.invertedSetting) {
        value = !value;
    }
    mySwitch.on = value;
}

- (void)dealloc {
	settingsObject = nil;
    
}

-(IBAction) switchChanged: (UISwitch*) sender {
    BOOL value = sender.on;
    if (self.invertedSetting) {
        value = !value;
    }
	[settingsObject setValue:
	 [NSNumber numberWithInt:value] forKey:self.targetGlobalSetting];
}

-(void) toggleSwitch {
    [self.mySwitch setOn:!self.mySwitch.isOn animated:YES];
    [self.mySwitch sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void) tintColorDidChange {
    [super tintColorDidChange];
    self.mySwitch.onTintColor = self.tintColor;
}

@end
