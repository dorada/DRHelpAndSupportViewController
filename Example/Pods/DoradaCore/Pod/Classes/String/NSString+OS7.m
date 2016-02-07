//
//  NSString+OS7.m
//  DoradaCore
//
//  Created by Daniel Broad on 22/06/2013.
//  Copyright (c) 2013 Dorada. All rights reserved.
//

#import "NSString+OS7.h"

@implementation NSString (OS7)

-(CGSize) drsizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000

    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *fontAtts = @{NSFontAttributeName : font};
        CGRect labelBounds = [self boundingRectWithSize:size
                              
                                                options:NSStringDrawingUsesLineFragmentOrigin
                              
                                             attributes:fontAtts
                              
                                                context:nil];
        return labelBounds.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        return [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }

#endif
}

-(CGSize) drsizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [self drsizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
}

-(CGSize) drsizeWithFont:(UIFont *)font {
    return [self drsizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}
@end
