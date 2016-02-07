//
//  NSString+OS7.h
//  DoradaCore
//
//  Created by Daniel Broad on 22/06/2013.
//  Copyright (c) 2013 Dorada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OS7)

-(CGSize) drsizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
-(CGSize) drsizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
-(CGSize) drsizeWithFont:(UIFont *)font;
@end
