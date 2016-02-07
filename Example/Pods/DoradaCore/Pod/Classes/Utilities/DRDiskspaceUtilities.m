//
//  DRDiskspaceUtilities.m
//  DoradaCore
//
//  Created by Daniel Broad on 13/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DRDiskspaceUtilities.h"

@implementation DRDiskspaceUtilities

+(NSString *)applicationDocumentsDirectory {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

+(float)getFreeDiskSpaceInBytes {
    float totalSpace = 0.0f;  
    NSError *error = nil;  
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];  
	
    if (dictionary) {  
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemFreeSize];  
        totalSpace = [fileSystemSizeInBytes floatValue];  
    }
	
    return totalSpace;  
}  

+(float) getFreeDiskSpaceInMegaBytes {
	return [DRDiskspaceUtilities getFreeDiskSpaceInBytes] / 1024.0f / 1024.0f;
}
+(float) getUsedSpaceInMegaBytes {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *cachesDirectory = [paths objectAtIndex:0];
	
	NSArray *files = [[NSFileManager defaultManager]contentsOfDirectoryAtPath: cachesDirectory error:nil];

    if ([files count] > 300) {
        // its too slow
        return 999999;
    }
    
	int iTotal = 0;
	float fSize = 0;
	for (NSString *filename in files) {
        iTotal++;
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[cachesDirectory stringByAppendingPathComponent:filename] error:nil];
        if(fileAttributes != nil)
        {
            fSize += [[fileAttributes objectForKey: NSFileSize] floatValue];
        }
        //log4Debug(@"%@", filename);
	}
	
	return fSize/1024.0f/1024.0f;
}

+(int) getTotalFileCount {
	int iTotal = 0;
	int iSize = 0;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cachesDirectory = [paths objectAtIndex:0];
    
	NSArray *files = [[NSFileManager defaultManager]contentsOfDirectoryAtPath: cachesDirectory error:nil];
    
	
	for (NSString *filename in files) {
        iTotal++;
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[cachesDirectory stringByAppendingPathComponent:filename] error:nil];
        if(fileAttributes != nil)
        {
            iSize += [[fileAttributes objectForKey: NSFileSize] intValue];
        }
	}
	
	return iTotal;
}

+(void) getTotalUsedSpaceInMegaBytesOnBackgroundThreadCompletion: (CompletionHandler) completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        float totalSpace = [self getUsedSpaceInMegaBytes];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(totalSpace);
        });
    });
}
@end
