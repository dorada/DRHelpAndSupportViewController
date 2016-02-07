//
//  UIDevice+Extensions.h
//  DoradaCore
//
//  Created by Daniel Broad on 16/02/2011.
//  Copyright 2011 Dorada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface UIDevice (Extensions)

+ (NSString *) device;
+ (BOOL) is_iPad;
+ (BOOL) is_ios4;
+ (BOOL) is_ios5;
+ (BOOL) is_ios6;
+ (BOOL) is_Jailbroken;
+ (BOOL) is_4inch;
+ (BOOL) is_ios7;
+ (BOOL) is_ios7_1;
+ (BOOL) is_ios8;
+ (BOOL) has_multipleCores;
+ (BOOL) is_47InchOrBigger;
+ (BOOL) is_55InchOrBigger;
+ (CGRect)screenBoundsFixedToPortraitOrientation;
+ (BOOL) is_ios9;
@end
