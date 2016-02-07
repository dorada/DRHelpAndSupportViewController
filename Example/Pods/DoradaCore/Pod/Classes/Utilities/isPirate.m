//
//  isPirate.m
//  DoradaCore
//
//  Created by Daniel Broad on 04/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "isPirate.h"


@implementation CCIsPirate

+(NSNumber*) isP
{
	NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
	NSString* path = [NSString stringWithFormat:@"%@/Info.plist", bundlePath];
	NSString *appName = [[[NSBundle mainBundle] infoDictionary]   objectForKey:@"CFBundleExecutable"];
	NSString* path2 = [NSString stringWithFormat:@"%@/%@", bundlePath,appName];
	
	NSDate* infoModifiedDate = [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] fileModificationDate];
	NSDate* infoModifiedDate2 = [[[NSFileManager defaultManager] attributesOfItemAtPath:path2 error:nil] fileModificationDate];
	NSDate* pkgInfoModifiedDate = [[[NSFileManager defaultManager] attributesOfItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"PkgInfo"] error:nil] fileModificationDate];
		
	int dif1 = fabs([infoModifiedDate timeIntervalSinceReferenceDate] - [pkgInfoModifiedDate timeIntervalSinceReferenceDate]);
	int dif2 = fabs([infoModifiedDate2 timeIntervalSinceReferenceDate] - [pkgInfoModifiedDate timeIntervalSinceReferenceDate]);
	
	//log4Debug(@"%@ = %@ = %@, %d, %d",infoModifiedDate,infoModifiedDate2,pkgInfoModifiedDate,dif1,dif2);

	if(dif1 > 600) {	
		return [NSNumber numberWithInt:YES];
	}
	if(dif2 > 600) {	
		return [NSNumber numberWithInt:YES];
	}
	
	return [NSNumber numberWithInt:NO];
}

@end
