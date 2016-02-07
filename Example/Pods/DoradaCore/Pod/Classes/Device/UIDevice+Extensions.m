//
//  UIDevice+Extensions.m
//  DoradaCore
//
//  Created by Daniel Broad on 16/02/2011.
//  Copyright 2011 Dorada. All rights reserved.
//

#import "UIDevice+Extensions.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDevice (Extensions)

+ (NSString *) device {
	size_t size;
	
	// Set 'oldp' parameter to NULL to get the size of the data
	// returned so we can allocate appropriate amount of space
	sysctlbyname("hw.machine", NULL, &size, NULL, 0); 
	
	// Allocate the space to store name
	char *name = malloc(size);
	
	// Get the platform name
	sysctlbyname("hw.machine", name, &size, NULL, 0);
	
	// Place name into a string
	NSString *machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
	
	// Done with this
	free(name);
	
	return machine;
}

+ (BOOL) is_iPad {
	
	if(![[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]) {
		return NO;
	}
	
	if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)  {
		return YES;
	}
	
	return NO;
}

+ (BOOL) is_ios4 {
	float version = [[[UIDevice currentDevice] systemVersion] floatValue];
	
	if (version < 4.0f) {
		return NO;
	}
	
	return YES;
}

+ (BOOL) is_ios5 {
	float version = [[[UIDevice currentDevice] systemVersion] floatValue];
	
	if (version < 5.0f) {
		return NO;
	}
	
	return YES;
}

+ (BOOL) is_ios6 {
	float version = [[[UIDevice currentDevice] systemVersion] floatValue];
	
	if (version < 6.0f) {
		return NO;
	}
	
	return YES;
}

+ (BOOL) is_ios7 {
	float version = [[[UIDevice currentDevice] systemVersion] floatValue];
	
	if (version < 7.0f) {
		return NO;
	}
	
	return YES;
}

+ (BOOL) is_ios7_1 {
	float version = [[[UIDevice currentDevice] systemVersion] floatValue];
	
	if (version < 7.1f) {
		return NO;
	}
	
	return YES;
}

+ (BOOL) is_ios8 {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version < 8.0f) {
        return NO;
    }
    
    return YES;
}

+ (BOOL) is_ios9 {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version < 9.0f) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)is_Jailbroken {
    BOOL jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }
    
    return jailbroken;
}

+ (BOOL) is_4inch {
    return ([UIDevice screenBoundsFixedToPortraitOrientation].size.height >  500);
}

+ (BOOL) has_multipleCores {
    return [[NSProcessInfo processInfo] processorCount]>1;
}

+ (CGRect)screenBoundsFixedToPortraitOrientation {
    UIScreen *screen = [UIScreen mainScreen];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([screen respondsToSelector:@selector(fixedCoordinateSpace)]) {
        return [screen.coordinateSpace convertRect:screen.bounds toCoordinateSpace:screen.fixedCoordinateSpace];
    }
#endif
    return screen.bounds;
}

+ (BOOL) is_47InchOrBigger {
    CGRect screen = [UIDevice screenBoundsFixedToPortraitOrientation];
    return (screen.size.height >= 667);
}

+ (BOOL) is_55InchOrBigger {
    CGRect screen = [UIDevice screenBoundsFixedToPortraitOrientation];
    return (screen.size.height >= 736);
}
@end

